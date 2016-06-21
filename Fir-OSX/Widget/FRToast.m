//
//  FRToast.m
//  Fir-OSX
//
//  Created by gejw on 16/6/18.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRToast.h"

@implementation FRToast

+ (void)show:(NSString *)msg {
    __block NSView *view = [[[NSApplication sharedApplication] windows] objectAtIndex:0].contentView;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
}

@end
