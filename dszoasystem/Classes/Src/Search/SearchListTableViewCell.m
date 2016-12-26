//
//  SearchListTableViewCell.m
//  YXLibraryOA
//
//  Created by eazytec on 16/1/13.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "SearchListTableViewCell.h"

@implementation SearchListTableViewCell

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
        UIImageView *titlesignimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Common_Title"]];
        titlesignimage.frame = CGRectMake(12, 10, 40, 40);
        [self.contentView addSubview:titlesignimage];
        
        _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(52 + 10, 15, SCREEN_WIDTH - 100, 16)];
        _titlelabel.textColor = COLOR_LABEL_BLACK;
        _titlelabel.font = [UIFont boldSystemFontOfSize:16];
        
        _titlelabel.numberOfLines = 1;
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_titlelabel];
        
        //2. time
        _timelabel = [[UILabel alloc]initWithFrame:CGRectMake(52 + 10, 35, SCREEN_WIDTH - 100, 12)];
        _timelabel.textColor = COLOR_LABEL_GRAY;
        _timelabel.font = [UIFont systemFontOfSize:12];
        
        _timelabel.numberOfLines = 1;
        _timelabel.textAlignment = NSTextAlignmentLeft;
        _timelabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_timelabel];
    }
    return  self;
}


@end
