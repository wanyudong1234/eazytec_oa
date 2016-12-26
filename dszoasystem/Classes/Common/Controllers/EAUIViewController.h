//
//  EAUIViewController.h
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EAProtocolDefault.h"

@interface EAUIViewController : UIViewController

- (void)didLoadingUserDataWithParams:(NSMutableDictionary *)params andService:(REQUEST_SERVICE_NAME)name;   // 已封装的交互数据服务
- (void)didLoadingUserDataWithParamsNoError:(NSMutableDictionary *)params andService:(REQUEST_SERVICE_NAME)name;   // 已封装的交互数据服务
- (void)didSyncLoadingUserDataWithParamsNoError:(NSMutableDictionary *)params andService:(REQUEST_SERVICE_NAME)name;   // 已封装的交互数据服务

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name;      // 分析服务器返回的成功状态下的数据回执



@end
