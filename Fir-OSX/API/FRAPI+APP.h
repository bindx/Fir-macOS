//
//  FRAPI+APP.h
//  Fir-OSX
//
//  Created by gejw on 16/6/17.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRAPI.h"
#import "FRApp.h"
#import "FRCert.h"

@interface FRAPI (APP)

/**
 *  获取上传凭证
 *
 *  @param api_token 用户token
 *  @param bundle_id App 的 bundleId（发布新应用时必填）
 *  @param type      ios 或者 android（发布新应用时必填）
 *  @param success
 *  @param failure
 */
- (void)getUploadCert:(NSString *)api_token
            bundle_id:(NSString *)bundle_id
                 type:(NSString *)type
              success:(void (^)(FRCert *cert))success
              failure:(void (^)(NSInteger code, NSString *msg))failure;

/**
 *  上传文件
 *
 *  @param data         安装包文件
 *  @param upload_url   上传url
 *  @param key          七牛上传 key
 *  @param token        七牛上传 token
 *  @param name         应用名称（上传 ICON 时不需要）
 *  @param version      版本号（上传 ICON 时不需要）
 *  @param build        Build 号（上传 ICON 时不需要）
 *  @param release_type 打包类型，只针对 iOS (Adhoc, Inhouse)（上传 ICON 时不需要）
 *  @param changelog    更新日志（上传 ICON 时不需要）
 *  @param success
 *  @param failure
 */
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
       failure:(void (^)(NSInteger code, NSString *msg))failure;

/**
 *  app列表
 *
 *  @param api_token 用户token
 *  @param success
 *  @param failure
 */
- (void)appList:(NSString *)api_token
        success:(void (^)(NSArray <FRApp *>* apps))success
        failure:(void (^)(NSInteger code, NSString *msg))failure;

/**
 *  app详细信息
 *
 *  @param api_token 用户token
 *  @param app_id    appId
 *  @param success
 *  @param failure
 */
- (void)appInfo:(NSString *)api_token
         app_id:(NSString *)app_id
        success:(void (^)(FRApp *app))success
        failure:(void (^)(NSInteger code, NSString *msg))failure;

/**
 *  修改应用信息
 *
 *  @param api_token          用户token
 *  @param app                app对象
 *  @param store_link_visible 应用市场链接是否显示
 *  @param success
 *  @param failure
 */
- (void)updateAppInfo:(NSString *)api_token
                  app:(FRApp *)app
              success:(void (^)(FRApp *app))success
              failure:(void (^)(NSInteger code, NSString *msg))failure;

@end
