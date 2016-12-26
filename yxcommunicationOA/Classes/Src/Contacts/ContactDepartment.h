//
//  ContactDepartment.h
//  YXTourismOA
//
//  Created by eazytec on 15/12/25.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactDepartment : NSObject<NSCoding>

@property (nonatomic,retain) NSString* noOfDepartment;
@property (nonatomic,retain) NSString* nameOfDepartment;


- (instancetype)initWithNo:(NSString *)no name:(NSString *)name;

@end
