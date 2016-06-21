//
//  STIosPackage.m
//  Fir-OSX
//
//  Created by gejw on 16/6/18.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "STIosPackage.h"

static NSString* const PCInfoParserErrorDomain = @"PCInfoParserError";

typedef NS_ENUM(NSInteger, PCInfoParserError) {
    PCInfoParserErrorUnknown = 9000,
    PCInfoParserErrorCorruptInfo,
    PCInfoParserErrorUnexpectedPropertyListType
};

@implementation STIosPackage

+ (instancetype)analysisIpaWithPath:(NSString *)path {
    STIosPackage *ipa = [[STIosPackage alloc] init];
    ipa.filePath = path;
    [ipa analysis:path];
    return ipa;
}

- (void)analysis:(NSString *)path {
    if (path == nil) {
        return;
    }
    // 解析plist
    NSData *data = [self readFileInIpa:path name:@"/info.plist"];
    if (!data) {
        return;
    }
    
    NSError *error;
    NSPropertyListFormat format = NSPropertyListBinaryFormat_v1_0;
    NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
    
    _bundleIdentifier = [plist objectForKey:@"CFBundleIdentifier"];
    _bundleName = [plist objectForKey:@"CFBundleName"];
    _bundleVersion = [plist objectForKey:@"CFBundleVersion"];
    _bundleShortVersion = [plist objectForKey:@"CFBundleShortVersionString"];
    _bundleDisplayName = [plist objectForKey:@"CFBundleDisplayName"];
//    _bundleIconFile = [[[[plist objectForKey:@"CFBundleIcons"] objectForKey:@"CFBundlePrimaryIcon"] objectForKey:@"CFBundleIconFiles"] lastObject];
//    if (_bundleIconFile) {
//        _bundleIconImage = [[NSImage alloc] initWithData:[self readFileInIpa:path name:[NSString stringWithFormat:@"%@.png", _bundleIconFile]]];
//    }
    _minimumOSVersion = [plist objectForKey:@"MinimumOSVersion"];
}

- (NSData *)readFileInIpa:(NSString *)path name:(NSString *)name {
    OZZipFile *unzipFile = [[OZZipFile alloc] initWithFileName:path mode:OZZipFileModeUnzip];
    NSArray *infos= [unzipFile listFileInZipInfos];
    
    NSMutableArray<NSData *> *datas = [NSMutableArray array];
    
    for (OZFileInZipInfo *info in infos) {
        if ([[info.name lowercaseString] hasSuffix:name]) {
            [unzipFile locateFileInZip:info.name];
            
            OZZipReadStream *read= [unzipFile readCurrentFileInZip];
            NSMutableData *data= [[NSMutableData alloc] initWithLength:info.length];
            [read readDataWithBuffer:data];
            [read finishedReading];
            [datas addObject:data];
            break;
        }
    }
    [unzipFile close];
    if (datas.count > 0) {
        return [datas objectAtIndex:0];
    }
    return nil;
}

@end
