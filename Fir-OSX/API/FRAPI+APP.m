//
//  FRAPI+APP.m
//  Fir-OSX
//
//  Created by gejw on 16/6/17.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRAPI+APP.h"

@implementation FRAPI (APP)

- (void)getUploadCert:(NSString *)api_token
            bundle_id:(NSString *)bundle_id
                 type:(NSString *)type
              success:(void (^)(FRCert *cert))success
              failure:(void (^)(NSInteger code, NSString *msg))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"api_token": api_token}];
    if (bundle_id) {
        [params setValue:bundle_id forKey:@"bundle_id"];
    }
    if (type) {
        [params setValue:type forKey:@"type"];
    }
    
    [self post:[NSString stringWithFormat:@"%@/apps", SERVER_URL] params:params success:^(id data) {
        FRCert *cert = [FRCert mj_objectWithKeyValues:data];
        if (success) {
            success(cert);
        }
    } failure:^(NSInteger code, NSString *msg) {
        if (failure) {
            failure(code, msg);
        }
    }];
}

- (void)upload:(FRUploadFile *)file
    upload_url:(NSString *)upload_url
           key:(NSString *)key
         token:(NSString *)token
          name:(NSString *)name
       version:(NSString *)version
         build:(NSString *)build
  release_type:(NSString *)release_type
     changelog:(NSString *)changelog
       success:(void (^)())success
      progress:(void (^)(CGFloat progress))progress
       failure:(void (^)(NSInteger code, NSString *msg))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (key) {
        [params setValue:key forKey:@"key"];
    }
    if (token) {
        [params setValue:token forKey:@"token"];
    }
    if (name) {
        [params setValue:name forKey:@"x:name"];
    }
    if (version) {
        [params setValue:version forKey:@"x:version"];
    }
    if (build) {
        [params setValue:build forKey:@"x:build"];
    }
    if (release_type) {
        [params setValue:release_type forKey:@"x:release_type"];
    }
    if (changelog) {
        [params setValue:changelog forKey:@"x:changelog"];
    }
    [self upload:upload_url file:file params:params success:^(id data) {
        Boolean is_completed = [[data objectForKey:@"is_completed"] boolValue];
        if (is_completed) {
            if (success) {
                success();
            }
        } else {
            if (failure) {
                failure(-1, @"upload error");
            }
        }
    } progress:^(CGFloat p) {
        if (progress) {
            progress(p);
        }
    } failure:^(NSInteger code, NSString *msg) {
        if (failure) {
            failure(code, msg);
        }
    }];
}

- (void)appList:(NSString *)api_token
        success:(void (^)(NSArray <FRApp *>*))success
        failure:(void (^)(NSInteger code, NSString *msg))failure {
    [self get:[NSString stringWithFormat:@"%@/apps", SERVER_URL] params:@{@"api_token": api_token} success:^(id data) {
        NSArray *apps = [FRApp mj_objectArrayWithKeyValuesArray:data];
        if (success) {
            success(apps);
        }
    } failure:^(NSInteger code, NSString *msg) {
        if (failure) {
            failure(code, msg);
        }
    }];
}

- (void)appInfo:(NSString *)api_token
         app_id:(NSString *)app_id
        success:(void (^)(FRApp *app))success
        failure:(void (^)(NSInteger code, NSString *msg))failure {
    [self get:[NSString stringWithFormat:@"%@/apps/%@", SERVER_URL, app_id] params:@{@"api_token": api_token} success:^(id data) {
        FRApp *app = [FRApp mj_objectWithKeyValues:data];
        if (success) {
            success(app);
        }
    } failure:^(NSInteger code, NSString *msg) {
        if (failure) {
            failure(code, msg);
        }
    }];
}

- (void)updateAppInfo:(NSString *)api_token
                  app:(FRApp *)app
              success:(void (^)(FRApp *app))success
              failure:(void (^)(NSInteger, NSString *))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[app mj_keyValues]];
    [params setValue:api_token forKey:@"api_token"];
    [self put:[NSString stringWithFormat:@"%@/apps/%@", SERVER_URL, app.app_id] params:params success:^(id data) {
        FRApp *app = [FRApp mj_objectWithKeyValues:data];
        if (success) {
            success(app);
        }
    } failure:^(NSInteger code, NSString *msg) {
        if (failure) {
            failure(code, msg);
        }
    }];
}

@end
