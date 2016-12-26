//
//  HomeContentTableViewCell.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "HomeContentTableViewCell.h"

@implementation HomeContentTableViewCell

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
        
        //1. title
        self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, SCREEN_WIDTH - 12 - 20 - 10 - 50, 16)];
        self.titlelabel.textColor = COLOR_LABEL_BLACK;
        self.titlelabel.font = [UIFont systemFontOfSize:16];
        
        self.titlelabel.numberOfLines = 1;
        self.titlelabel.textAlignment = NSTextAlignmentLeft;
        self.titlelabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.titlelabel];
            
        //2. content
        self.contentlabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 12 + 16 + 12, SCREEN_WIDTH - 12 - 20 - 10 - 50, 10)];
        self.contentlabel.textColor = [UIColor lightGrayColor];
        self.contentlabel.font = [UIFont systemFontOfSize:10];
        
        self.contentlabel.numberOfLines = 1;
        self.contentlabel.textAlignment = NSTextAlignmentLeft;
        self.contentlabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.contentlabel];
        
        //3. time
        self.timelabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 12 + 16 + 12 + 13, 200, 10)];
        self.timelabel.textColor = [UIColor lightGrayColor];
        self.timelabel.font = [UIFont systemFontOfSize:10];
        
        self.timelabel.numberOfLines = 1;
        self.timelabel.textAlignment = NSTextAlignmentLeft;
        self.timelabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.timelabel];
        
        //4. image
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Common_Man"]];
        imageview.frame = CGRectMake(SCREEN_WIDTH - 10 - 50, 10, 50, 48);
        imageview.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:imageview];
    }
    return  self;
}

@end
