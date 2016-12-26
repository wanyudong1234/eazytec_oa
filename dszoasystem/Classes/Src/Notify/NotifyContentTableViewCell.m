//
//  NotifyContentTableViewCell.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/30.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "NotifyContentTableViewCell.h"

@implementation NotifyContentTableViewCell

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
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        [self.contentView addSubview:_webview];
    }
    return  self;
}

@end
