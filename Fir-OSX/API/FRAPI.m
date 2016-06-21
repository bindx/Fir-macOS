//
//  FRAPI.m
//  Fir-OSX
//
//  Created by gejw on 16/6/17.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRAPI.h"
#import <AFNetworking.h>

@interface FRAPI()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation FRAPI

SingletonImplementation(FRAPI)

- (instancetype)init NS_UNAVAILABLE {
    self = [super init];
    if (self) {
        _manager = [[AFHTTPRequestOperationManager alloc] init];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", nil];
    }
    return self;
}

- (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id))success
     failure:(void (^)(NSInteger code, NSString *msg))failure {
#if DEBUG
    NSLog(@"%@  [发送]-> \njson -> %@ \n\n", url, params);
#endif
    [_manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
#if DEBUG
        NSLog(@"%@  [接收 success]-> \n%@", url, responseObject);
#endif
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#if DEBUG
        NSLog(@"%@  [接收 error]-> \n%@", url, error);
#endif
        if (failure) {
            failure(-1, error.description);
        }
    }];
}

- (void)put:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id))success
    failure:(void (^)(NSInteger code, NSString *msg))failure {
#if DEBUG
    NSLog(@"%@  [发送]-> \njson -> %@ \n\n", url, params);
#endif
    [_manager PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
#if DEBUG
        NSLog(@"%@  [接收 success]-> \n%@", url, responseObject);
#endif
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#if DEBUG
        NSLog(@"%@  [接收 error]-> \n%@", url, error);
#endif
        if (failure) {
            failure(-1, error.description);
        }
    }];
}

- (void)upload:(NSString *)url
         file:(FRUploadFile *)file
        params:(NSDictionary *)params
       success:(void (^)(id))success
      progress:(void (^)(CGFloat progress))progress
       failure:(void (^)(NSInteger, NSString *))failure {
    AFHTTPRequestOperation *uploadOp = [_manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:file.data name:file.name fileName:file.fileName mimeType:file.mimeType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
#if DEBUG
        NSLog(@"%@  [接收 success]-> \n%@", url, responseObject);
#endif
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#if DEBUG
        NSLog(@"%@  [接收 error]-> \n%@", url, error);
#endif
        if (failure) {
            failure(-1, error.description);
        }
    }];
    [uploadOp setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat p = ((float)totalBytesWritten) / totalBytesExpectedToWrite;
        if (progress) {
            progress(p);
        }
    }];
}

- (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id))success
    failure:(void (^)(NSInteger code, NSString *msg))failure {
    
#if DEBUG
    NSLog(@"%@  [发送]-> \njson -> %@ \n\n", url, params);
#endif
    [_manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
#if DEBUG
        NSLog(@"%@  [接收 success]-> \n%@", url, responseObject);
#endif
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#if DEBUG
        NSLog(@"%@  [接收 error]-> \n%@", url, error);
#endif
        if (failure) {
            failure(-1, error.description);
        }
    }];
}

- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

@end
