//
//  MemberPickTableViewCell.m
//  YXTourismOA
//
//  Created by eazytec on 16/1/5.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "MemberPickTableViewCell.h"

@implementation MemberPickTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 用于显示选中和非选中的状态
- (void)setUnPickerDisplay {
    self.picked = NO;
    
    self.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageNamed:@"Common_UnCheck"];
}

- (void)setPickerDisplay {
    self.picked = YES;
    
    self.backgroundColor = COLOR_LABEL_BLUE;
    self.imageView.image = [UIImage imageNamed:@"Common_Check"];
}

@end
