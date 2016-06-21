//
//  FRApp.m
//  Fir-OSX
//
//  Created by gejw on 16/6/20.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRApp.h"

@implementation FRApp

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"short_url": @"short",
             @"app_id": @"id"};
}

- (NSString *)url {
    return [NSString stringWithFormat:@"http://fir.im/%@", _short_url];
}

@end

@implementation Master_Release

@end


