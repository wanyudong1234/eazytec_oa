//
//  NSString+Util.h
//  YXLibraryOA
//
//  Created by eazytec on 15/8/7.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSString工具方法, 创建这个类别的目的是使所有的NSString可以被安全的使用防止空指针
 */
@interface NSString (Util)

// 去除所有的HTML标签
+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;

/**
 *  比较两个NSString是否相等
 *
 *  @param string  待比较的NSString
 *  @param origin  被比较的NSString
 *
 *  @return  BOOL
 */
+ (BOOL)isEqualToString: (NSString *)string andOrigin: (NSString *)origin;

/**
 *  判断NSString是否为空(包括内容为空)
 *
 *  @param string 被判断的SString
 *
 *  @return BOOL
 */
+ (BOOL)isStringBlank: (NSString *)string;

/**
 *  判断NSString是否为空
 *
 *  @param string 被判断的SString
 *
 *  @return BOOL
 */
+ (BOOL)isStringNil: (NSString *)string;


/**
 *  得到一个空的NSString
 *
 *  @return NSString
 */
+ (NSString *)blankToFill;

/**
 *  得到一个空的NSString
 *
 *  @return NSString
 */
+ (NSString *)blank;


/**
 *  得到一个@"1"
 *
 *  @return NSString
 */
+ (NSString *)one;


/**
 *  得到一个@"0"
 *
 *  @return NSString
 */
+ (NSString *)zero;

@end
