//
//  ContactDepartment.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/25.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "ContactDepartment.h"

@implementation ContactDepartment

- (instancetype)initWithNo:(NSString *)no name:(NSString *)name {
    
    self = [super init];
    if (self) {
        
        self.noOfDepartment = no;
        self.nameOfDepartment = name;
    }
    return  self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
    [coder encodeObject:self.noOfDepartment forKey:@"noOfDepartment"];
    [coder encodeObject:self.nameOfDepartment forKey:@"nameOfDepartment"];
}


- (id)initWithCoder: (NSCoder *)decoder {
    if (self = [super init]) {
        self.noOfDepartment    = [decoder decodeObjectForKey:@"noOfDepartment"];
        self.nameOfDepartment  = [decoder decodeObjectForKey:@"nameOfDepartment"];
    }
    return self;
}

@end
