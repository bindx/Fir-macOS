//
//  STAndroidPageage.h
//  Fir-OSX
//
//  Created by gejw on 16/6/18.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STAndroidPackage : NSObject

@property (nonatomic, strong) NSString *applicationName;

@property (nonatomic, strong) NSString *packageName;

@property (nonatomic, strong) NSString *versionCode;

@property (nonatomic, strong) NSString *versionName;

@property (nonatomic, strong) NSArray *permissions;

@property (nonatomic, strong) NSImage *appIconImage;

@property (nonatomic, strong) NSString *filePath;

+ (instancetype)analysisApkWithPath:(NSString *)path;

@end
