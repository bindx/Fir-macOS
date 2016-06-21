//
//  FRUserListCell.m
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRUserListCell.h"
#import "FRUserManager.h"

@implementation FRUserListCell

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)setUser:(FRUser *)user {
    _user = user;
    _nameLabel.stringValue = _user.userName;
}

- (IBAction)clickDeleteButton:(id)sender {
    [[FRUserManager sharedInstance] removeUser:_user];
    [[NSNotificationCenter defaultCenter] postNotificationName:FRUpdateUserNotification object:nil];
}

@end
