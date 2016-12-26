//
//  AppDelegate.h
//  YXTourismOA
//
//  Created by eazytec on 15/12/23.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 全局变量
@property (nonatomic, retain) NSString *sessionId;
@property (nonatomic,retain) NSString *loginTime;
@property (nonatomic,retain) NSString *alias;

@end

