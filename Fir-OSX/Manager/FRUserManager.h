//
//  FRUserManager.h
//  Fir-OSX
//
//  Created by gejw on 16/6/18.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRUser.h"

@interface FRUserManager : NSObject

SingletonInterface(FRUserManager)

@property (nonatomic, strong) FRUser *currentUser;

- (NSArray <FRUser *> *)userList;

- (void)addUser:(FRUser *)user;

- (void)removeUser:(FRUser *)user;

- (FRUser *)queryUserWithUserName:(NSString *)userName;

@end
