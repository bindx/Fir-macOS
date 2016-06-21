//
//  FRNewUserAlert.m
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRNewUserAlert.h"
#import "FRUserManager.h"

@implementation FRNewUserAlert

- (IBAction)clickCancelButton:(id)sender {
    [self dismiss];
}

- (IBAction)clickSaveButton:(id)sender {
    NSString *key = [[_keyTextField stringValue] trim];
    NSString *token = [[_tokenTextField stringValue] trim];
    if ([key isEqualToString:@""] || [token isEqualToString:@""]) {
        [FRToast show:@"请输入内容！"];
        return;
    }
    [self dismiss];
    [[FRUserManager sharedInstance] addUser:[[FRUser alloc] initWithUserName:key userToken:token]];
    [[NSNotificationCenter defaultCenter] postNotificationName:FRUpdateUserNotification object:nil];
}

@end
