//
//  EAUser.h
//  YXLibraryOA
//
//  Created by eazytec on 15/8/7.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const USER_DEFAULTS_LOGIN = @"login_user";

/**
 *  登陆用户信息维护, 维护用户登录信息和相关属性
 */
@interface EAUserDefault : NSObject<NSCoding>

@property (nonatomic, retain) NSString *login_id;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *login_name;

- (instancetype)initWithLoginId:(NSString *)loginId andPassword:(NSString *)password;  // 默认构造函数
+ (instancetype)loadUserLoginHasRemember;  // 加载已登陆的用户信息
+ (void)persistenceLoginUserIntoUserDefaults: (EAUserDefault *)user;  // 设置已登陆的用户信息
+ (NSString *)loadUserLoginNameHasRemember;
+ (NSString *)loadSessionIdIfUserHasLogin;  // 加载已登陆用户的SessionId
+ (void)clearLoginUserInfo;  //清除登陆信息

// 获取当前时间
+ (NSString *)getNowTime;




@end