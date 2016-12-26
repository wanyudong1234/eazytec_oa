//
//  EAWork.h
//  YXLibraryOA
//
//  Created by eazytec on 15/8/5.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ProcessTypeEnum){
    ProcessTypeToDo   = 1,// 待办事项
    ProcessTypeToRead = 3,// 阅办事项
};

typedef NS_ENUM(NSInteger, ProcessElementDisplayType){
    ElementForReadToDisplay        = 0,
    ElementForWriteToDisplay       = 1,
    ElementForCounterSignToDisplay = 2,
};

/**
 *  流程模型, 并提供处理流程的一切相关工具方法
 */
@interface EAProcessor : NSObject

// 流程相关属性
@property (nonatomic, retain) NSString   *run_id;
@property (nonatomic, retain) NSString   *flow_id;
@property (nonatomic, retain) NSString   *prcs_id;
@property (nonatomic, retain) NSString   *flow_prcs;
@property (nonatomic, retain) NSString   *op_flag;

// 流程选择器属性
@property (nonatomic, assign) BOOL       is_read;
@property (nonatomic, assign) BOOL       is_hurry;
@property (nonatomic, retain) NSArray    *next_work;

@property (nonatomic, retain) NSString   *is_work_end;

// 流程名称
@property (nonatomic, retain) NSString   *title;


@property (nonatomic,assign) ProcessTypeEnum type;  //流程类型


- (instancetype)initWithDictionaryFromService:(NSDictionary *)dict;   //根据服务回执(NSDictionary)构造流程模型
- (NSMutableDictionary *)createDictionaryFromProcessorForRequest;     //根据流程模型,创建服务请求参数
- (NSMutableDictionary *)createDictionaryFromProcessorForEndProcess;  //根据流程模型,创建服务请求参数
- (NSMutableDictionary *)createDictionaryFromProcessorForFlowSubmitProcess;  //根据流程模型,创建服务请求参数

- (void)setProcessContentAnalysisWithRequest:(NSArray *)array;
- (NSMutableArray *)getProcessContentForDisplay;
- (BOOL)isUserAssumeProcessSponsor; // 此流程是否为主办人流程

- (void)setProcessSelectorAnalysisWithRequest:(NSDictionary *)request;   //设置流程选择器属性



+ (ProcessElementDisplayType)getProcessContentElementTypeForDisplay:(NSDictionary *)element;
+ (BOOL)isProcessorFormElementLegalForDisplay:(NSDictionary *)element;  // 一些参数历史原因是不需要展示的,这里删除掉

@end
