//
//  HomeContentTitleTableViewCell.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "HomeContentTitleTableViewCell.h"

@implementation HomeContentTitleTableViewCell

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
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 200, 16)];;
        self.titlelabel.font = [UIFont boldSystemFontOfSize:16];
        self.titlelabel.textColor = COLOR_LABEL_BLUE;
        
        [self.contentView addSubview: self.titlelabel];
    }
    return  self;
}

@end
