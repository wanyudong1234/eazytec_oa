//
//  ProcessWriteTableViewCell.m
//  YXTourismOA
//
//  Created by eazytec on 16/1/5.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "ProcessWriteTableViewCell.h"

@implementation ProcessWriteTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.textfield = [EAUITextField instanceTextField];
        self.textfield.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30, 30);
        self.textfield.placeholder = @"点击输入信息";
        self.textfield.font = [UIFont systemFontOfSize:15];
        self.textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"点击输入内容"
                                                                           attributes:@{
                                                                                        NSFontAttributeName : [UIFont systemFontOfSize:15],
                                                                                        NSForegroundColorAttributeName : [UIColor lightGrayColor],                                                                                        }];
        [self.contentView addSubview:self.textfield];
    }
    return  self;
}

@end
