//
//  SearchContentTableViewCell.h
//  YXLibraryOA
//
//  Created by eazytec on 16/1/13.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchContentTableViewCell : UITableViewCell

@property (nonatomic,retain) UILabel *readtextlabel;

- (void)setTextHeight:(NSString *)text;

@end
