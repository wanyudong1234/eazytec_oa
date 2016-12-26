//
//  NSNumber+Util.m
//  YXLibraryOA
//
//  Created by eazytec on 15/8/11.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "NSNumber+Util.h"

@implementation NSNumber (Util)



+ (BOOL)isNumberNil:(NSNumber *)number {
    if (number == nil || [number isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}


+ (NSNumber *)getNumberWithString:(NSString *)string {
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    if ([format numberFromString:string]) {
        return [NSNumber numberWithInt:[string intValue]];
    }else{
        return [NSNumber zero];
    }
}


/**
 *  得到一个1
 *
 *  @return NSNumber
 */
+ (NSNumber *)one {
    return [NSNumber numberWithInt:1];
}


/**
 *  得到一个0
 *
 *  @return NSNumber
 */
+ (NSNumber *)zero {
    return [NSNumber numberWithInt:0];
}

@end
