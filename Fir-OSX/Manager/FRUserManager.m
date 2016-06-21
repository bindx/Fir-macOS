//
//  FRUserManager.m
//  Fir-OSX
//
//  Created by gejw on 16/6/18.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRUserManager.h"
#define FR_USERS_KEY @"users"
#define FR_CURRENTUSER_KEY @"currentUser"

@interface FRUserManager()

@property (nonatomic, strong) NSMutableArray *users;

@end

@implementation FRUserManager

SingletonImplementation(FRUserManager)

- (instancetype)init {
    self = [super init];
    if (self) {
        
        id users = [[NSUserDefaults standardUserDefaults] objectForKey:FR_USERS_KEY];
        if (users) {
            _users = [NSMutableArray arrayWithArray:[FRUser mj_objectArrayWithKeyValuesArray:users]];
        } else {
            _users = [NSMutableArray array];
        }
    }
    return self;
}

- (void)save {
    NSMutableArray *arr = [NSMutableArray array];
    for (FRUser *user in _users) {
        [arr addObject:[user dict]];
    }
    NSString *jsonString = [arr mj_JSONString];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:jsonString forKey:FR_USERS_KEY];
    [userDefault synchronize];
}

- (void)setCurrentUser:(FRUser *)currentUser {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:currentUser.userName forKey:FR_CURRENTUSER_KEY];
    [userDefault synchronize];
}

- (FRUser *)currentUser {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefault objectForKey:FR_CURRENTUSER_KEY];
    if (userName) {
        return [self queryUserWithUserName:userName];
    }
    return nil;
}

- (NSArray<FRUser *> *)userList {
    return _users;
}

- (void)addUser:(FRUser *)user {
    if (!self.currentUser) {
        self.currentUser = user;
    }
    [_users addObject:user];
    [self save];
}

- (void)removeUser:(FRUser *)user {
    [_users removeObject:user];
    [self save];
}

- (FRUser *)queryUserWithUserName:(NSString *)userName {
    if (userName) {
        for (FRUser *user in _users) {
            if ([user.userName isEqualToString:userName]) {
                return user;
            }
        }
    }
    return nil;
}

@end
