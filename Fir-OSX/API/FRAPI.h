//
//  FRAPI.h
//  Fir-OSX
//
//  Created by gejw on 16/6/17.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRUploadFile.h"

#define SERVER_URL @"http://api.fir.im"

@interface FRAPI : NSObject

SingletonInterface(FRAPI)

- (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id data))success
     failure:(void (^)(NSInteger code, NSString *msg))failure;

- (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id data))success
    failure:(void (^)(NSInteger code, NSString *msg))failure;

- (void)put:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id data))success
    failure:(void (^)(NSInteger code, NSString *msg))failure;

- (void)upload:(NSString *)url
          file:(FRUploadFile *)file
        params:(NSDictionary *)params
       success:(void (^)(id data))success
      progress:(void (^)(CGFloat progress))progress
       failure:(void (^)(NSInteger code, NSString *msg))failure;

@end
