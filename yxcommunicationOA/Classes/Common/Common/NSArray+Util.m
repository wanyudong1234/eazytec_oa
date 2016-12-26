//
//  NSArray+Util.m
//  YXLibraryOA
//
//  Created by eazytec on 15/8/10.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "NSArray+Util.h"

@implementation NSArray (Util)

+ (BOOL)isArrayNull :(NSArray *)array {
    
    if(array == nil  || (NSNull *)array == [NSNull null]){
        return true;
    }
    return false;
}

@end
