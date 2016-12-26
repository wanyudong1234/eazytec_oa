//
//  WorkTableViewCell.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/26.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "WorkTableViewCell.h"

@implementation WorkTableViewCell

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
        
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        // view
        self.view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 90)];
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.layer.masksToBounds = YES;
        self.view.layer.cornerRadius = 8;
        self.view.layer.borderWidth = 1.0f;
        self.view.layer.borderColor = [COLOR_LABEL_BLUE CGColor];
        [self.contentView addSubview:self.view];
         
        // 头像
        self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.height / 5 * 3, self.view.frame.size.height / 5 * 3)];
        [self.view addSubview:self.imageview];

        CGFloat title_index_x = 10 + self.view.frame.size.height / 5 * 3 + 10;
        
        // 名字
        self.titlelabel = [[UILabel alloc]init];
    
        self.titlelabel.frame = CGRectMake(title_index_x, 15, 100, 18);
        self.titlelabel.font = [UIFont boldSystemFontOfSize:18];
        self.titlelabel.textColor = COLOR_LABEL_BLACK;
        
        self.titlelabel.numberOfLines = 1;
        self.titlelabel.lineBreakMode = NSLineBreakByTruncatingTail;  //截去尾部
        [self.view addSubview: self.titlelabel];
        
        // 角标
        self.badgeNumlabel = [[UILabel alloc] init];
        // 设置字体
        [self.badgeNumlabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        
        self.badgeNumlabel.frame = CGRectMake(self.view.frame.size.width - 10 - 18 - 35, 15, 30, 18);
        self.badgeNumlabel.backgroundColor = [UIColor redColor];
        self.badgeNumlabel.textColor = [UIColor whiteColor];
        self.badgeNumlabel.layer.masksToBounds = YES;
        self.badgeNumlabel.layer.cornerRadius = 8;
        self.badgeNumlabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview: self.badgeNumlabel];
        
        // 箭头
        UIImageView *jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 18, 15, 8, 18)];
        jiantou.image = [UIImage imageNamed:@"Work_Jiantou"];
        [self.view addSubview: jiantou];
        // 下划线
        UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(title_index_x, 46, self.view.frame.size.width - title_index_x - 10, 0.5)];
        sectionview.backgroundColor = COLOR_LABEL_BLUE;
        [self.view addSubview: sectionview];

        // 内容
        self.detaillabel = [[UILabel alloc]init];
        self.detaillabel.frame = CGRectMake(title_index_x, 50, self.view.frame.size.width - title_index_x - 10, 30);
        self.detaillabel.font = [UIFont systemFontOfSize:12];
        self.detaillabel.textColor = COLOR_LABEL_GRAY;
        self.detaillabel.numberOfLines = 2;
        [self.view addSubview: self.detaillabel];
        
        
    }
    return  self;
}


@end
