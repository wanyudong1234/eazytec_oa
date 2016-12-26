//
//  EAMember.h
//  YXTourismOA
//
//  Created by eazytec on 16/1/5.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAMember : NSObject

// 成员所属部门信息
@property (nonatomic,retain) NSString *department_id;
@property (nonatomic,retain) NSString *department_name;

// 成员相关信息
@property (nonatomic,retain) NSString *user_id;
@property (nonatomic,retain) NSString *user_name;


/**
 *  根据DepartmentName分组数据
 *
 *  @param array <#array description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableDictionary *) arrangementUserDictionaryByDepartmentName:(NSArray *)array :(NSMutableArray *)depKeys;

@end
