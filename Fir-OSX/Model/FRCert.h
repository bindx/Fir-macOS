//
//  FRCert.h
//  Fir-OSX
//
//  Created by gejw on 16/6/20.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cert,Icon,Binary;

@interface FRCert : NSObject

@property (nonatomic, copy) NSString *app_id;

@property (nonatomic, strong) Cert *cert;

@property (nonatomic, copy) NSString *short_url;

@property (nonatomic, copy) NSString *type;

@end

@interface Cert : NSObject

@property (nonatomic, strong) Icon *icon;

@property (nonatomic, strong) Binary *binary;

@end

@interface Icon : NSObject

@property (nonatomic, copy) NSString *key;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *upload_url;

@end

@interface Binary : NSObject

@property (nonatomic, copy) NSString *key;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *upload_url;

@end

