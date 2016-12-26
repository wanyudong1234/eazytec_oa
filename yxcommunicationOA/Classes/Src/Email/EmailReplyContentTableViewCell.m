//
//  EmailReplyContentTableViewCell.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/29.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EmailReplyContentTableViewCell.h"

@implementation EmailReplyContentTableViewCell

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
        
        _textview = [EAUITextView instanceTextView];
        
        _textview.frame = CGRectMake(10, 0, SCREEN_WIDTH, 200);
        [self.contentView addSubview:_textview];
    }
    return  self;
}

@end
