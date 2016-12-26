//
//  EAProtocolDefault.m
//  YXLibraryOA
//
//  Created by eazytec on 15/8/7.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAProtocolDefault.h"

#import "EAUserDefault.h"

@implementation EAProtocolDefault

+ (AFHTTPRequestOperationManager *)createAsynManageRequest {
    AFHTTPRequestOperationManager *manager            = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:REQUEST_CONTENT_TYPE];
    manager.requestSerializer                         = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer                        = [AFHTTPResponseSerializer serializer];
    return manager;
}


+ (NSString *)loadRequestServiceUrlWithName:(REQUEST_SERVICE_NAME)name {
    NSString *plistPath            = [[NSBundle mainBundle] pathForResource:@"ProtocolDefaultUrl" ofType:@"plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    
    NSString *serviceName          = [plistDict objectForKey:[NSString stringWithFormat:@"%ld",(long)name]];
    return [[REQUEST_SERVICE_URL stringByAppendingString:serviceName]stringByAppendingString:REQUEST_SERVICE_NAME_SUFFIX];
}


+ (NSDictionary *)doRequestJSONSerializationdDecode:(AFHTTPRequestOperation *) operation {
    NSString *request = [NSString stringWithString:operation.responseString];
    NSData *data      = [[NSData alloc]initWithData:[request dataUsingEncoding:NSUTF8StringEncoding]];

    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
}

+ (BOOL)isRequestJSONSerializationSuccess:(NSDictionary *)result {
    NSNumber *code = [result objectForKey:@"Code"];
    
    if(code == nil || [code intValue] != 0){
        return NO;
    }
    return YES;
}


+ (NSMutableDictionary *)doPackingLoginUserServiceParams:(NSDictionary *) params {
    NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
    
    NSString *sessionname = [EAUserDefault loadSessionIdIfUserHasLogin];
    [result setObject:sessionname forKey:REQUEST_SESSION_ID];
    if (params != nil) {
        [result addEntriesFromDictionary: params];
    }
    return result;
}

@end
