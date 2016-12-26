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
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 90)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 8;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [COLOR_LABEL_BLUE CGColor];
        [self.contentView addSubview:view];
         
        // 头像
        self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, view.frame.size.height / 5 * 3, view.frame.size.height / 5 * 3)];
        [view addSubview:self.imageview];

        CGFloat title_index_x = 10 + view.frame.size.height / 5 * 3 + 10;
        
        // 名字
        self.titlelabel = [[UILabel alloc]init];
    
        self.titlelabel.frame = CGRectMake(title_index_x, 15, 100, 18);
        self.titlelabel.font = [UIFont boldSystemFontOfSize:18];
        self.titlelabel.textColor = COLOR_LABEL_BLACK;
        
        self.titlelabel.numberOfLines = 1;
        self.titlelabel.lineBreakMode = NSLineBreakByTruncatingTail;  //截去尾部
        [view addSubview: self.titlelabel];
        
        
        // 箭头
        UIImageView *jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width - 10 - 18, 15, 8, 18)];
        jiantou.image = [UIImage imageNamed:@"Work_Jiantou"];
        [view addSubview: jiantou];
        // 下划线
        UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(title_index_x, 46, view.frame.size.width - title_index_x - 10, 0.5)];
        sectionview.backgroundColor = COLOR_LABEL_BLUE;
        [view addSubview: sectionview];

        // 内容
        self.detaillabel = [[UILabel alloc]init];
        self.detaillabel.frame = CGRectMake(title_index_x, 50, view.frame.size.width - title_index_x - 10, 30);
        self.detaillabel.font = [UIFont systemFontOfSize:12];
        self.detaillabel.textColor = COLOR_LABEL_GRAY;
        self.detaillabel.numberOfLines = 2;
        [view addSubview: self.detaillabel];
        
        
    }
    return  self;
}


@end
