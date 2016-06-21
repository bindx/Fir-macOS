//
//  FRUploadFile.m
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRUploadFile.h"

@implementation FRUploadFile

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)create:(NSString *)path name:(NSString *)name {
    FRUploadFile *file = [[FRUploadFile alloc] init];
    file.data = [NSData dataWithContentsOfFile:path];
    file.name = name;
    file.fileName = [path lastPathComponent];
    
    NSString *suffix = [path pathExtension];
    file.mimeType = [[suffix lowercaseString] hasSuffix:@"apk"] ? @"application/vnd.Android.package-archive" : @"application/iphone";
    return file;
}

@end
