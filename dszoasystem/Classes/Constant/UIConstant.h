//
//  UIConstant.h
//  YXTourismOA
//
//  Created by eazytec on 15/12/23.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#ifndef UIConstant_h
#define UIConstant_h

static const CGFloat  KEYBOARD_HEIGHT = 252;
static const CGFloat  KEYBOARD_RESIZE_CORRECTION = 70;

static const CGFloat  ELEMENT_HEIGHT_MAX = 2000.f;

static NSString * const PAGING_TABLE_PAGE_SIZE   = @"PageSize";
static NSString * const PAGING_TABLE_PAGE_INDEX  = @"PageIndex";
static NSString * const TABLE_PARMS_ID  = @"Id";
static NSString * const TITLE_LABLE  = @"宜兴市丁蜀镇办公自动化系统";
static NSString * const WELCOME_TITLE_LABLE  = @"欢迎使用宜兴市丁蜀镇办公自动化系统！";


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_CONTENT_HEIGHT [UIScreen mainScreen].bounds.size.height - 44


#define COLOR_LABEL_BLUE  [UIColor colorWithRed:55.0 / 255.0 green:132.0 / 255.0 blue:255.0 / 255.0 alpha:1]
#define COLOR_LABEL_BLACK [UIColor colorWithRed:38.0 / 255.0 green:37.0 / 255.0 blue:37.0 / 255.0 alpha:1]
#define COLOR_LABEL_GRAY [UIColor colorWithRed:137.0 / 255.0 green:137.0 / 255.0 blue:137.0 / 255.0 alpha:1]
#define COLOR_LABEL_LIGHT_GRAY [UIColor colorWithRed:229.0 / 255.0 green:237.0 / 255.0 blue:245.0 / 255.0 alpha:1]

#define TABLE_SECTION_MIN_HEIGHT 0.0001

#define HEAD_STATUS_HEIGHT  22

#define HOME_DOWN_SIZE 10

#endif /* UIConstant_h */
