//
//  EAProtocolDefault.h
//  YXLibraryOA
//
//  Created by eazytec on 15/8/7.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPRequestOperationManager.h"

// 服务相关常量
static NSString * const REQUEST_CONTENT_TYPE        = @"text/html";
//static NSString * const REQUEST_SERVICE_URL         = @"http://192.168.1.117:8081/wap/Mobile/";
// 丁蜀镇 服务器IP
static NSString * const REQUEST_SERVICE_URL         = @"http://58.215.198.210:8086/wap/Mobile/";
static NSString * const REQUEST_SERVICE_NAME_SUFFIX = @".php";


static NSString * const REQUEST_SESSION_ID        = @"SessionId";

// 服务名称枚举
typedef NS_ENUM(NSInteger, REQUEST_SERVICE_NAME) {
    //以下是枚举成员
    SERVICE_NAME_LOGIN                   = 0,
    SERVICE_NAME_NOTICE_LIST             = 1,
    SERVICE_NAME_NOTICE_DETAIL           = 2,
    SERVICE_NAME_STUDY_LIST              = 3,
    SERVICE_NAME_STUDY_DETAIL            = 4,
    SERVICE_NAME_MAIL_LIST               = 5,
    SERVICE_NAME_MAIL_DETAIL             = 6,
    SERVICE_NAME_MAIL_REPLY              = 7,
    SERVICE_NAME_ADDRESS_DEPARTMENT_LIST = 8,
    SERVICE_NAME_ADDRESS_MEMBER_LIST     = 9,
    SERVICE_NAME_WORK_PLAN_LIST          = 10,
    SERVICE_NAME_WORK_PLAN_DETAIL        = 11,
    SERVICE_NAME_PROCESS_LIST_LIST       = 12,
    SERVICE_NAME_PROCESS_LIST_DETAIL     = 13,
    SERVICE_NAME_TODO_LIST               = 14,
    SERVICE_NAME_TODO_DETAIL             = 15,
    SERVICE_NAME_TODO_SUBMIT             = 16,
    SERVICE_NAME_TODO_MORE_HANDLER       = 17,
    SERVICE_NAME_TODO_FLOW_SUBMIT        = 18,
    SERVICE_NAME_HOME                    = 19,
    
    SERVICE_NAME_MAIL_NEW                = 20,
    SERVICE_NAME_MAIL_USER_LOAD          = 21,
    
    SERVICE_NAME_NEWS_LIST               = 22,
    SERVICE_NAME_NEWS_DETAIL             = 23,
};

/**
 *  服务协议接口引擎
 *  封装了一部分标准的方法和工具, 主要提供与服务器之间的数据交换引擎
 */
@interface EAProtocolDefault : NSObject

+ (AFHTTPRequestOperationManager *)createAsynManageRequest; // 初始化异步服务协议引擎

+ (NSString *)loadRequestServiceUrlWithName:(REQUEST_SERVICE_NAME) name;  // 根据服务枚举加载服务地址
+ (NSDictionary *)doRequestJSONSerializationdDecode:(AFHTTPRequestOperation *) operation;  // 解析服务返回结果JSON
+ (BOOL)isRequestJSONSerializationSuccess:(NSDictionary *) result;        //  判断业务上是否返回正确
+ (NSMutableDictionary *)doPackingLoginUserServiceParams:(NSDictionary *) params;  // 包装服务参数

@end
