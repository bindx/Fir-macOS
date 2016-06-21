//
//  NSString+Trim.m
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
