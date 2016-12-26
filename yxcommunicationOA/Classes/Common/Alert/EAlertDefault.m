//
//  EAlertDefault.m
//  YXLibraryOA
//
//  Created by eazytec on 15/8/7.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAlertDefault.h"

@implementation EAlertDefault


+ (void)alertWarningInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target {
    UIAlertController *alert   = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // 加入取消按钮
    UIAlertAction *canelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:canelAction];
    [target presentViewController:alert animated:YES completion:nil];
}


+ (void)alertWarningInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target andOtherAction:(UIAlertAction *)action {
    UIAlertController *alert   = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:action];
    // 加入取消按钮
    UIAlertAction *canelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:canelAction];
    [target presentViewController:alert animated:YES completion:nil];
}


+ (void)alertWarningInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target andAction:(UIAlertAction *)action {
    UIAlertController *alert   = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:action];
    [target presentViewController:alert animated:YES completion:nil];
}


+ (void)alertWarningInfoBecauseNetworkWithTarget:(id)target {
    [self alertWarningInfoWithTitle:@"网络错误" andMessage:@"请检查相关网络设置或稍后再试" andTarget:target];
}


+ (void)alertWarningInfoNullAttachmentWithTarget:(id)target {
    [EAlertDefault alertWarningInfoWithTitle:@"系统提醒" andMessage:@"没有相关附件" andTarget:target];
}


+ (void)alertSelectorInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target andActions:(UIAlertAction *)action,...NS_REQUIRES_NIL_TERMINATION
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleActionSheet];
    
    // 取消功能
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    va_list params;
    va_start(params,action);
    
    UIAlertAction *current_action = action;
    [alert addAction:current_action];
    if (action) {
        while ((current_action = va_arg(params, UIAlertAction *))) {
            [alert addAction:current_action];
        }
    }
    va_end(params);
    [target presentViewController:alert animated:YES completion:nil];
}

+ (void)alertSelectorInfoWithTitle:(NSString *)title andMessage: (NSString *)message andTarget:(id)target andArrayActions:(NSMutableArray *)actions {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleActionSheet];
    
    // 取消功能
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    for (int index = 0;index < [actions count];index++) {
        UIAlertAction *current_action = [actions objectAtIndex:index];
        [alert addAction:current_action];
    }
    [target presentViewController:alert animated:YES completion:nil];
    
}

@end
