//
//  STIosPackage.h
//  Fir-OSX
//
//  Created by gejw on 16/6/18.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STIosPackage : NSObject

@property (nonatomic, strong) NSString *bundleIdentifier;

@property (nonatomic, strong) NSString *bundleName;

@property (nonatomic, strong) NSString *bundleDisplayName;

@property (nonatomic, strong) NSString *bundleVersion;

@property (nonatomic, strong) NSString *bundleShortVersion;

@property (nonatomic, strong) NSString *minimumOSVersion;

@property (nonatomic, strong) NSString *filePath;

+ (instancetype)analysisIpaWithPath:(NSString *)path;

@end
