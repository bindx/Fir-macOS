//
//  FRUser.m
//  Fir-OSX
//
//  Created by gejw on 16/6/18.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRUser.h"

@implementation FRUser

- (instancetype)initWithUserName:(NSString *)userName userToken:(NSString *)userToken {
    self = [super init];
    if (self) {
        _userName = userName;
        _userToken = userToken;
    }
    return self;
}

- (instancetype)init NS_UNAVAILABLE {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSDictionary *)dict {
    NSString *userName = _userName ? _userName : @"";
    NSString *userToken = _userToken ? _userToken : @"";
    
    return @{@"userName": userName, @"userToken": userToken};
}

@end
