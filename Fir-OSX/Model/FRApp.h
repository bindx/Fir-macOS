//
//  FRApp.h
//  Fir-OSX
//
//  Created by gejw on 16/6/20.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Master_Release;

@interface FRApp : NSObject
// 应用id
@property (nonatomic, copy) NSString *app_id;
// 是否公开
@property (nonatomic, assign) BOOL is_opened;
// 应用bundle_id
@property (nonatomic, copy) NSString *bundle_id;
//
@property (nonatomic, strong) Master_Release *master_release;
// 创建时间(UTC 时间)
@property (nonatomic, assign) NSInteger created_at;
// ios 或者 android
@property (nonatomic, copy) NSString *type;
// app 短链接
@property (nonatomic, copy) NSString *short_url;
// icon的地址
@property (nonatomic, copy) NSString *icon_url;
// 是否有 combo app
@property (nonatomic, assign) BOOL has_combo;
// 类别 id
@property (nonatomic, assign) NSInteger genre_id;
// app 名称
@property (nonatomic, copy) NSString *name;
// 应用市场链接是否显示
@property (nonatomic, assign) BOOL store_link_visible;
// 是否展示在广场页
@property (nonatomic, assign) BOOL is_show_plaza;
// 是否是当前用户的 app
@property (nonatomic, assign) BOOL is_owner;
// app 详细描述
@property (nonatomic, copy) NSString *desc;
// 应用密码参数 密码访问(不能和is_opened is_show_plaza联合使用)
@property (nonatomic, copy) NSString *passwd;

- (NSString *)url;

@end

@interface Master_Release : NSObject

@property (nonatomic, copy) NSString *build;

@property (nonatomic, copy) NSString *distribution_name;

@property (nonatomic, copy) NSString *release_type;

@property (nonatomic, assign) NSInteger created_at;

@property (nonatomic, copy) NSString *supported_platform;

@property (nonatomic, copy) NSString *version;

@end

