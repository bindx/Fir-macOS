//
//  FRAppListCell.m
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRAppListCell.h"
#import "FRAppQRCodeAlert.h"
#import "QRCodeGenerator.h"

@implementation FRAppListCell

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (IBAction)clickLink:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:_app.url]];

}

- (IBAction)clickQRCode:(id)sender {
    NSImage *image = [QRCodeGenerator qrImageForString:_app.url imageSize:200];
    
    FRAppQRCodeAlert *alert = [[FRAppQRCodeAlert alloc] init];
    alert.imageView.image = image;
    alert.descLabel.stringValue = [NSString stringWithFormat:@"请用手机扫描二维码下载%@", _app.name];
    [alert show];
}

- (void)setApp:(FRApp *)app {
    _app = app;
    
    _appNameLabel.stringValue = [NSString stringWithFormat:@"%@", _app.name];
    _appVersionLabel.stringValue = [NSString stringWithFormat:@"V%@ (Build %@)", _app.master_release.version, _app.master_release.build];
    [_linkButton setStringValue:@"11"];
    _linkButton.title = _app.url;
    
    _uploadTimeLabel.stringValue = [NSString stringWithFormat:@"上传时间 %@", [self formatDate:_app.master_release.created_at]];
    [_iconImageView downloadImageFromURL:_app.icon_url withPlaceholderImage:[NSImage imageNamed:@"default_appIcon"] andErrorImage:[NSImage imageNamed:@"default_appIcon"]];
}

- (NSString *)formatDate:(NSInteger)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

@end
