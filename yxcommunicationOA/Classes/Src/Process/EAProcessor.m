//
//  EAWork.m
//  YXLibraryOA
//
//  Created by eazytec on 15/8/5.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAProcessor.h"

@interface EAProcessor()

@property (nonatomic,retain) NSMutableArray *content;  //流程内容

@end


@implementation EAProcessor


- (instancetype)initWithDictionaryFromService:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.run_id    = [dict objectForKey:@"Run_id"];
        self.flow_id   = [dict objectForKey:@"Flow_id"];
        self.prcs_id   = [dict objectForKey:@"Prcs_id"];
        self.flow_prcs = [dict objectForKey:@"Flow_prcs"];
        self.op_flag   = [dict objectForKey:@"OP_flag"];
        self.content   = [[NSMutableArray alloc]init];
    }
    return self;
}


- (NSMutableDictionary *)createDictionaryFromProcessorForRequest {
    NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
    
    if (![NSString isStringNil:self.run_id])    [result setObject:self.run_id    forKey:@"Run_id"];
    if (![NSString isStringNil:self.flow_id])   [result setObject:self.flow_id   forKey:@"Flow_id"];
    if (![NSString isStringNil:self.prcs_id])   [result setObject:self.prcs_id   forKey:@"Prcs_id"];
    if (![NSString isStringNil:self.flow_prcs]) [result setObject:self.flow_prcs forKey:@"Flow_prcs"];
    if (![NSString isStringNil:self.op_flag])   [result setObject:self.op_flag   forKey:@"OP_flag"];
    return result;
}


- (NSMutableDictionary *)createDictionaryFromProcessorForFlowSubmitProcess {
    
    NSMutableDictionary *result = [self createDictionaryFromProcessorForRequest];
    NSNumber *hurry             = self.is_hurry ? [NSNumber zero]:[NSNumber one];
    NSNumber *read              = self.is_read  ? [NSNumber zero]:[NSNumber one];
    
    [result setObject:hurry forKey:@"IsHurryTodo"];
    [result setObject:read forKey:@"IsReadTodo"];
    [result setObject:[NSString blank] forKey:@"LimitDate"];
    [result setObject:[NSString blank] forKey:@"LimitTime"];
    return result;
}


- (NSMutableDictionary *)createDictionaryFromProcessorForEndProcess {
    
    NSMutableDictionary *result = [self createDictionaryFromProcessorForRequest];
    [result setObject:[NSString blank] forKey:@"Prcs_user"];
    [result setObject:[NSString blank] forKey:@"Prcs_op_user"];
    [result setObject:[NSString blank] forKey:@"Prcs_To_Choose"];
    
    [result setObject:[NSString one] forKey:@"IsHurryTodo"];
    [result setObject:[NSString one] forKey:@"IsReadTodo"];
    
    [result setObject:[NSString blank] forKey:@"LimitDate"];
    [result setObject:[NSString blank] forKey:@"LimitTime"];
    
    [result setObject:[NSString one] forKey:@"Mobile_sms_remind"];
    [result setObject:[NSString blank] forKey: @"RemindCotent"];
    return result;
}


+ (BOOL)isProcessorFormElementLegalForDisplay:(NSDictionary *)element {
    if (![[element objectForKey:@"ElementTitle"] hasPrefix:@"日期控件"]) {
        return YES;
    }
    return NO;
}

+ (ProcessElementDisplayType)getProcessContentElementTypeForDisplay:(NSDictionary *)element {
    NSNumber *readOnly   = [element objectForKey:@"ElementReadOnly"];
    if ([readOnly longValue] == 0) {
        // 表示可修改,判断是否是会签字段
        if ([NSString isEqualToString:@"countersign" andOrigin:[element objectForKey:@"Countersign"]]) {
            return ElementForCounterSignToDisplay;
        }else {
            return ElementForWriteToDisplay;
        }
    }else{
        return ElementForReadToDisplay;
    }
}


- (void)setProcessContentAnalysisWithRequest:(NSArray *)array {
    self.content = [[NSMutableArray alloc]init]; // 首先初始化
    if ([NSArray isArrayNull:array]) return;
    for (NSUInteger index = 0; index < array.count; index++) {
        if (![EAProcessor isProcessorFormElementLegalForDisplay:[array objectAtIndex:index]]) {
            continue; //如果不符合要求
        }
        NSMutableDictionary *to_fill = [[NSMutableDictionary alloc]init];
        NSMutableDictionary *current = [array objectAtIndex:index];
        
        [to_fill setObject:[current objectForKey:@"ElementTitle"] forKey:@"ElementTitle"];
        if ([[current objectForKey:@"ElementValue"] isEqual:[NSNull null]]) {
            [to_fill setObject:@"" forKey:@"ElementValue"];
        }else{
            [to_fill setObject:[current objectForKey:@"ElementValue"] forKey:@"ElementValue"];
        }
        
        if (![NSString isStringNil:[current objectForKey:@"ElementId"]]) {
            [to_fill setObject:[current objectForKey:@"ElementId"] forKey:@"ElementId"];
        }
        if (![NSString isStringNil:[current objectForKey:@"AutoAddUserName"]]) {
            [to_fill setObject:[current objectForKey:@"AutoAddUserName"] forKey:@"AutoAddUserName"];
        }
        if (![NSString isStringNil:[current objectForKey:@"AutoAddTime"]]) {
            [to_fill setObject:[current objectForKey:@"AutoAddTime"] forKey:@"AutoAddTime"];
        }
        if (![NSString isStringNil:[current objectForKey:@"ElementReadOnly"]]) {
            [to_fill setObject:[current objectForKey:@"ElementReadOnly"] forKey:@"ElementReadOnly"];
        }
        if (![NSString isStringNil:[current objectForKey:@"Countersign"]]) {
            [to_fill setObject:[current objectForKey:@"Countersign"] forKey:@"Countersign"];
        }
        [self.content addObject:to_fill];
    }
}


- (NSMutableArray *)getProcessContentForDisplay {
    return self.content;
}


- (BOOL)isUserAssumeProcessSponsor {
    if ([NSString isEqualToString:[NSString one] andOrigin:self.op_flag]) {
        return YES;
    }else {
        return NO;
    }
}


- (void)setProcessSelectorAnalysisWithRequest:(NSDictionary *)request {
    
    self.next_work   = [request objectForKey:@"NextWorkList"];
    self.is_work_end = [request objectForKey:@"IsWorkFlowEnd"];
    if ([NSArray isArrayNull:self.next_work])  self.next_work = [[NSArray alloc]init];
    if ([NSString isEqualToString:[NSString zero] andOrigin:[request objectForKey:@"IsReadTodo"]])   self.is_read = YES;
    else   self.is_read = NO;
    if ([NSString isEqualToString:[NSString zero] andOrigin:[request objectForKey:@"IsHurryTodo"]])  self.is_hurry = YES;
    else   self.is_hurry = NO;
    
}

@end
