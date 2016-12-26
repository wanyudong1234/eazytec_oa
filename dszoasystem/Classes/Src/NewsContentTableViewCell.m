//
//  NewsContentTableViewCell.m
//  yxcommunicationOA
//
//  Created by Yudong WAN on 16/11/3.
//  Copyright © 2016年 eazytec. All rights reserved.
//

#import "NewsContentTableViewCell.h"

@implementation NewsContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        [self.contentView addSubview:_webview];
    }
    return  self;
}

@end
