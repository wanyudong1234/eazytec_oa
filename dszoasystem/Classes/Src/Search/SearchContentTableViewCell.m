//
//  SearchContentTableViewCell.m
//  YXLibraryOA
//
//  Created by eazytec on 16/1/13.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "SearchContentTableViewCell.h"

@implementation SearchContentTableViewCell

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
        
        self.readtextlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 15)];
        self.readtextlabel.textColor = COLOR_LABEL_BLACK;
        self.readtextlabel.font = [UIFont systemFontOfSize:15];
        
        self.readtextlabel.numberOfLines = 0;
        self.readtextlabel.textAlignment = NSTextAlignmentLeft;
        self.readtextlabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.readtextlabel];
    }
    return self;
}

- (void)setTextHeight:(NSString *)text {
    
    NSDictionary *detailTextSizeAttirbute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGSize detailTextSize = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -30 , ELEMENT_HEIGHT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes:detailTextSizeAttirbute context:nil].size;
    CGFloat textHeight = detailTextSize.height;
    
    self.readtextlabel.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30, textHeight);
    self.readtextlabel.text = text;
}


@end
