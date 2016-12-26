//
//  EmailReplyTitleTableViewCell.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/29.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EmailReplyTitleTableViewCell.h"

@implementation EmailReplyTitleTableViewCell

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
       
        _textfield =[EAUITextField instanceTextField];
        _textfield.frame = CGRectMake(15, 0, SCREEN_WIDTH, 45);
        _textfield.borderStyle = UITextBorderStyleNone;
        _textfield.font = [UIFont systemFontOfSize:15];
        _textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"点击输入主题"
                                              attributes:@{
                                                  NSFontAttributeName : [UIFont systemFontOfSize:15],
                                                  NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                              }];
        [self.contentView addSubview:_textfield];        
    }
    return  self;
}


@end
