//
//  EAMember.m
//  YXTourismOA
//
//  Created by eazytec on 16/1/5.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "EAMember.h"

@implementation EAMember

+ (NSMutableDictionary *)arrangementUserDictionaryByDepartmentName:(NSArray *)array :(NSMutableArray *)depKeys {
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
    
    NSEnumerator *enumerator = [array objectEnumerator];
    NSDictionary *value;
    
    while ((value  = enumerator.nextObject)) {
        
        NSString *depart        = [value objectForKey:@"DepartId"];
        EAMember *member        = [[EAMember alloc]init];
        member.department_name  = depart;
        member.user_id          = [value objectForKey:@"UserId"];
        member.user_name        = [value objectForKey:@"UserName"];
        
        NSMutableArray *members = [result objectForKey:depart];
        if (members != nil) {
            [members addObject:member];
        }else {
            members = [[NSMutableArray alloc]init];
            
            [members addObject:member];
            [result setObject:members forKey:depart];
            [depKeys addObject:depart];
        }
    }
    return result;
}

@end
