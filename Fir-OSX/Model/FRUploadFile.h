//
//  FRUploadFile.h
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRUploadFile : NSObject

@property (nonatomic, strong) NSData *data;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, strong) NSString *mimeType;

+ (instancetype)create:(NSString *)path name:(NSString *)name;

@end
