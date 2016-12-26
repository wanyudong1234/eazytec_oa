//
//  NSString+Util.m
//  YXLibraryOA
//
//  Created by eazytec on 15/8/7.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    // trim off whitespace
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}


+ (BOOL)isEqualToString: (NSString *)string andOrigin: (NSString *)origin {
    if ([NSString isStringNil:string] || [NSString isStringNil:origin]) {
        return NO;
    }
    return [origin isEqualToString:string];
}


+ (BOOL)isStringBlank: (NSString *)string {
    if ([NSString isStringNil:string]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] <= 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isStringNil: (NSString *)string {
    if (string == nil || [string isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

+ (NSString *)blankToFill {
    return @" ";
}

+ (NSString *)blank {
    return @"";
}


+ (NSString *)one {
    return @"1";
}

+ (NSString *)zero {
    return @"0";
}

@end
