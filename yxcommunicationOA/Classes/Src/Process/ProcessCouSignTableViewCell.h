//
//  ProcessCouSignTableViewCell.h
//  YXTourismOA
//
//  Created by eazytec on 16/1/5.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessCouSignTableViewCell : UITableViewCell

@property (nonatomic,retain) UILabel *readtextlabel;
@property (nonatomic,retain) EAUITextField *textfield;

- (void)setTextHeight:(NSString *)text;

@end
