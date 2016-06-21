//
//  FRUser.h
//  Fir-OSX
//
//  Created by gejw on 16/6/18.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRUser : NSObject

// 如果用户名相同，则覆盖
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *userToken;

- (instancetype)initWithUserName:(NSString *)userName userToken:(NSString *)userToken;

- (NSDictionary *)dict;

@end
