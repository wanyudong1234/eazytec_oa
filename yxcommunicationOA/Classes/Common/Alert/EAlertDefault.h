//
//  EAlertDefault.h
//  YXLibraryOA
//
//  Created by eazytec on 15/8/7.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  EAlert的集合方法, 用于统一管理项目中的所有Alert
 */
@interface EAlertDefault : NSObject


+ (void)alertWarningInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target;   // 提示警告信息(自带Action)
+ (void)alertWarningInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target andAction:(UIAlertAction *)action;   // 提示警告信息
+ (void)alertWarningInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target andOtherAction:(UIAlertAction *)action;  //提示警告信息(自带Action),可以新增action

+ (void)alertSelectorInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target andActions:(UIAlertAction *)action,...NS_REQUIRES_NIL_TERMINATION;   // 提示下拉选择信息(自带取消Action)

+ (void)alertSelectorInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target andArrayActions:(NSMutableArray *)actions;   // 提示下拉选择信息(自带取消Action)

+ (void)alertWarningInfoBecauseNetworkWithTarget:(id)target;   // 提示网络错误警告信息
+ (void)alertWarningInfoNullAttachmentWithTarget:(id)target;   // 提示没有相关附件警告信息


@end
