//
//  NSNumber+Util.h
//  YXLibraryOA
//
//  Created by eazytec on 15/8/11.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Util)

/**
 *  判断Number是否为空
 *
 *  @param number number
 *
 *  @return BOOL
 */
+ (BOOL)isNumberNil:(NSNumber *)number;


/**
 *  根据NSString获取number
 *
 *  @param string string
 *
 *  @return NSNumber
 */
+ (NSNumber *)getNumberWithString:(NSString *)string;


/**
 *  得到一个1
 *
 *  @return NSNumber
 */
+ (NSNumber *)one;


/**
 *  得到一个0
 *
 *  @return NSNumber
 */
+ (NSNumber *)zero;

@end
