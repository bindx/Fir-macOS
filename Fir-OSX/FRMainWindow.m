//
//  FRMainWindow.m
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRMainWindow.h"
#import "FRDragView.h"
#import "STAndroidPackage.h"
#import "STIosPackage.h"
#import "FRDonateAlert.h"
#import "FRUserManager.h"
#import "FRUserManagerAlert.h"
#import "FRAppListCell.h"

@interface FRMainWindow() <NSTabViewDelegate, NSTableViewDataSource, FRDragViewDelegate>

@property (weak) IBOutlet NSView *mainView;
@property (weak) IBOutlet NSTableView *appsTableView;
@property (weak) IBOutlet FRDragView *dropView;
@property (weak) IBOutlet NSPopUpButton *userPopUpButton;
@property (nonatomic, strong) NSArray<FRApp *> *apps;

@end

@implementation FRMainWindow

- (void)setup {
    _apps = @[];
    
    _mainView.wantsLayer = YES;
    _mainView.layer.backgroundColor = [NSColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00].CGColor;
    _dropView.wantsLayer = YES;
    _dropView.layer.backgroundColor = [NSColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1.00].CGColor;
    _dropView.fileTypes = @[@"ipa", @"apk"];
    _dropView.delegate = self;
    [_appsTableView registerNib:[[NSNib alloc] initWithNibNamed:@"FRAppListCell" bundle:nil] forIdentifier:@"FRAppListCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateUserNotification:) name:FRUpdateUserNotification object:nil];
    
    [self reloadUsers];
    [self reloadApps];
}

- (void)reloadUsers {
    [_userPopUpButton removeAllItems];
    NSArray *users = [FRUserManager sharedInstance].userList;
    
    FRUser *currentUser = [FRUserManager sharedInstance].currentUser;
    
    int selectIndex = 0;
    for (int i = 0; i < users.count; i++) {
        FRUser *user = users[i];
        if (user == currentUser) {
            selectIndex = i;
        }
        [_userPopUpButton addItemWithTitle:user.userName];
    }
    [_userPopUpButton selectItemAtIndex:selectIndex];
}

- (void)didUpdateUserNotification:(NSNotification *)notification {
    [self reloadUsers];
    [self reloadApps];
}

- (void)reloadApps {
    __weak typeof(self) weakSelf = self;
    NSInteger selectIndex = _userPopUpButton.indexOfSelectedItem;
    FRUser *currentUser = [[FRUserManager sharedInstance] currentUser];
    FRUser *selectUser = selectIndex < [FRUserManager sharedInstance].userList.count ? [FRUserManager sharedInstance].userList[selectIndex] : nil;
    if (!currentUser) {
        _apps = @[];
        [_appsTableView reloadData];
        return;
    }
    if (selectUser != currentUser || _apps.count == 0) {
        [FRUserManager sharedInstance].currentUser = selectUser;
        [[FRAPI sharedInstance] appList:selectUser.userToken success:^(NSArray<FRApp *> *apps) {
            weakSelf.apps = apps;
            [weakSelf.appsTableView reloadData];
        } failure:^(NSInteger code, NSString *msg) {
            
        }];
    }
}

- (IBAction)didClickDonate:(id)sender {
    FRDonateAlert *alert = [[FRDonateAlert alloc] init];
    [alert show];
}

- (IBAction)didClickSetting:(id)sender {
    FRUserManagerAlert *alert = [[FRUserManagerAlert alloc] init];
    [alert show];
}

- (IBAction)clickSelectUser:(id)sender {
    [self reloadApps];
}

#pragma NSTabViewDelegate, NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _apps.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 80;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    FRAppListCell *cellView = [tableView makeViewWithIdentifier:@"FRAppListCell" owner:self];
    FRApp *app = [_apps objectAtIndex:row];
    cellView.app = app;
    cellView.wantsLayer = YES;
    return cellView;
}

#pragma FRDragViewDelegate

- (void)dragView:(FRDragView *)view didDragFilePath:(NSString *)path {
    NSLog(@"didDragFilePath --> %@", path);
    
    if ([[[path pathExtension] lowercaseString] isEqualToString:@"apk"]) {
        STAndroidPackage *package = [STAndroidPackage analysisApkWithPath:path];
        NSLog(@"ApplicationName -> %@", package.applicationName);
        NSLog(@"packageName -> %@", package.packageName);
        NSLog(@"versionName -> %@", package.versionName);
        NSLog(@"versionCode -> %@", package.versionCode);
        NSLog(@"permissions -> %@", package.permissions);
        [self uploadFile:path bundle_id:package.packageName type:@"android" name:package.applicationName version:package.versionName build:package.versionCode];
    } else if ([[[path pathExtension] lowercaseString] isEqualToString:@"ipa"]) {
        STIosPackage *package = [STIosPackage analysisIpaWithPath:path];
        NSLog(@"bundleName -> %@", package.bundleName);
        NSLog(@"bundleDisplayName -> %@", package.bundleDisplayName);
        NSLog(@"bundleIdentifier -> %@", package.bundleIdentifier);
        NSLog(@"bundleShortVersion -> %@", package.bundleShortVersion);
        NSLog(@"bundleVersion -> %@", package.bundleVersion);
        NSLog(@"minimumOSVersion -> %@", package.minimumOSVersion);
        [self uploadFile:path bundle_id:package.bundleIdentifier type:@"ios" name:package.bundleName version:package.bundleVersion build:package.bundleShortVersion];
    }
}

- (void)dragView:(FRDragView *)view didDragFileError:(NSError *)error {
    NSLog(@"didDragFileError --> %@", error);
    [FRToast show:@"文件不支持！"];
}

- (void)uploadFile:(NSString *)path
         bundle_id:(NSString *)bundle_id
              type:(NSString *)type
              name:(NSString *)name
           version:(NSString *)version
             build:(NSString *)build {
    __weak typeof(self) weakSelf = self;
    
    FRUser *user = [[FRUserManager sharedInstance] currentUser];
    if (!user) {
        return;
    }
    [[FRAPI sharedInstance] getUploadCert:user.userToken bundle_id:bundle_id type:type success:^(FRCert *cert) {
        
        __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.contentView animated:YES];
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        hud.labelText = @"上传中";
        hud.labelFont = [NSFont systemFontOfSize:12];
        
        [[FRAPI sharedInstance] upload:[FRUploadFile create:path name:@"file"]
                            upload_url:cert.cert.binary.upload_url
                                   key:cert.cert.binary.key
                                 token:cert.cert.binary.token
                                  name:name
                               version:version
                                 build:build
                          release_type:@""
                             changelog:@""
                               success:^{
                                   [hud hide:YES];
                                   [FRToast show:@"上传成功"];
                                   [weakSelf reloadApps];
                               } progress:^(CGFloat progress) {
                                   NSLog(@"upload progress -> %.2f", progress);
                                   hud.progress = @(progress).floatValue;
                               } failure:^(NSInteger code, NSString *msg) {
                                   NSLog(@"msg -> %@", msg);
                                   [hud hide:YES];
                                   [FRToast show:msg];
                               }];
    } failure:^(NSInteger code, NSString *msg) {
        [FRToast show:msg];
    }];
}

@end
