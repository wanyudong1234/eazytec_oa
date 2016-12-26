//
//  Contact.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/25.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "Contact.h"

@implementation Contact


- (instancetype)initWithNo:(NSString *)no name:(NSString *)name tel:(NSString *)tel {
    
    self = [super init];
    if (self) {
        self.noOfContact = no;
        self.nameOfContact = name;
        self.telOfContact = tel;
    }
    return  self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
    [coder encodeObject:self.noOfContact forKey:@"noOfContact"];
    [coder encodeObject:self.nameOfContact forKey:@"nameOfContact"];
    [coder encodeObject:self.telOfContact forKey:@"telOfContact"];
}


- (id)initWithCoder: (NSCoder *)decoder {
    if (self = [super init]) {
        self.noOfContact    = [decoder decodeObjectForKey:@"noOfContact"];
        self.nameOfContact  = [decoder decodeObjectForKey:@"nameOfContact"];
        self.telOfContact   = [decoder decodeObjectForKey:@"telOfContact"];
    }
    return self;
}

@end
