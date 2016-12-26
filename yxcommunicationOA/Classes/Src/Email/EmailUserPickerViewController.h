//
//  EmailUserPickerViewController.h
//  YXTourismOA
//
//  Created by eazytec on 16/3/8.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "EAUIViewController.h"

@protocol EmailMemberPickerDelegate

-(void)pickMembers:(NSMutableArray * )members;

@end

@interface EmailUserPickerViewController : EAUIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,weak) id<EmailMemberPickerDelegate> delegate;


@end
