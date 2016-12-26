//
//  MemberPickTableViewCell.h
//  YXTourismOA
//
//  Created by eazytec on 16/1/5.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberPickTableViewCell : UITableViewCell

// 被选中的
@property (assign, nonatomic) BOOL picked;

// 用于显示选中和非选中的状态
- (void)setUnPickerDisplay;
- (void)setPickerDisplay;

@end
