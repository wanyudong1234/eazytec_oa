//
//  HomeHeadImageTableViewCell.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "HomeHeadTableViewCell.h"

@implementation HomeHeadTableViewCell

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
        
        UIImageView *blankimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 3/5)];
        blankimage.image = [UIImage imageNamed:@"Home_Head_Bg"];
        [self.contentView addSubview:blankimage];
        
        // 头像imageview
        UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(30, SCREEN_WIDTH * 3/5 - 35, 70, 70)];
        headimage.image = [UIImage imageNamed:@"Common_Man"];
        [self.contentView addSubview:headimage];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, SCREEN_WIDTH * 3/5 + 20, 200 ,20)];
        titleLabel.text = [EAUserDefault loadUserLoginNameHasRemember];
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textColor = COLOR_LABEL_BLACK;
        
        titleLabel.numberOfLines = 1;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;  //截去尾部
        [self.contentView addSubview:titleLabel];
        
        UILabel *msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_WIDTH * 3/5 + 50, SCREEN_WIDTH - 50, 12)];
        msgLabel.text = WELCOME_TITLE_LABLE;
        
        msgLabel.font = [UIFont systemFontOfSize:12];
        msgLabel.textColor = COLOR_LABEL_GRAY;
        
        msgLabel.numberOfLines = 1;
        msgLabel.lineBreakMode = NSLineBreakByTruncatingTail;  //截去尾部
        [self.contentView addSubview:msgLabel];
    }
    return  self;
}


@end
