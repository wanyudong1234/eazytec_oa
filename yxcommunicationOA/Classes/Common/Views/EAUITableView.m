//
//  EAUITableView.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAUITableView.h"

@implementation EAUITableView

- (void)setUp
{
    //self.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.sectionHeaderHeight = 0;
    self.sectionFooterHeight = 0;
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, 0.01f)];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    frame.size.height = frame.size.height - 44;
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

@end
