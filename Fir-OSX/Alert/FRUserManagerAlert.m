//
//  FRUserManagerAlert.m
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRUserManagerAlert.h"
#import "FRNewUserAlert.h"
#import "FRUserManager.h"
#import "FRUser.h"
#import "FRUserListCell.h"

@interface FRUserManagerAlert() <NSTabViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) NSArray <FRUser *> *users;

@end

@implementation FRUserManagerAlert

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadUsers];
        [_tableView registerNib:[[NSNib alloc] initWithNibNamed:@"FRUserListCell" bundle:nil] forIdentifier:@"FRUserListCell"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateUserNotification:) name:FRUpdateUserNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadUsers {
    _users = [[FRUserManager sharedInstance] userList];
}

- (void)didUpdateUserNotification:(NSNotification *)notification {
    [self loadUsers];
    [_tableView reloadData];
}

- (IBAction)clickCloseButton:(id)sender {
    [self dismiss];
}

- (IBAction)clickNewButton:(id)sender {
    FRNewUserAlert *alert = [[FRNewUserAlert alloc] init];
    [alert showFromWindow:self.window];
}

#pragma NSTabViewDelegate, NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _users.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 40;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    FRUserListCell *cellView = [tableView makeViewWithIdentifier:@"FRUserListCell" owner:nil];
    FRUser *user = [_users objectAtIndex:row];
    cellView.user = user;
    return cellView;
}

//- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    FRAppListCell *cellView = [tableView makeViewWithIdentifier:@"FRAppListCell" owner:self];
//    FRApp *app = [_apps objectAtIndex:row];
//    cellView.app = app;
//    cellView.wantsLayer = YES;
//    return cellView;
//}

@end
