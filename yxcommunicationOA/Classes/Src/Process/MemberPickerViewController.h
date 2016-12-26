//
//  MemberPickerViewController.h
//  YXTourismOA
//
//  Created by eazytec on 16/1/5.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "EAUIViewController.h"

@protocol MemberPickerDelegate

-(void)pickMembers:(NSMutableArray * )members;

@end

@interface MemberPickerViewController : EAUIViewController<UITableViewDelegate, UITableViewDataSource>

// members : key = department_name  value = NSArray(EAMember)
@property (nonatomic,retain) NSDictionary *members;
@property (nonatomic,retain) NSMutableArray *departKeys;

@property (nonatomic,weak) id<MemberPickerDelegate> delegate;

@end
