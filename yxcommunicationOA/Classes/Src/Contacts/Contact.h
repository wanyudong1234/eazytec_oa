//
//  Contact.h
//  YXTourismOA
//
//  Created by eazytec on 15/12/25.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject<NSCoding>

@property (nonatomic,retain) NSString* noOfContact;

@property (nonatomic,retain) NSString* nameOfContact;
@property (nonatomic,retain) NSString* telOfContact;

- (instancetype)initWithNo:(NSString *)no name:(NSString *)name tel:(NSString *)tel;

@end
