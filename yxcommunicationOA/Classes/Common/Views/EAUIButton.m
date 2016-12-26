//
//  EAUIButton.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAUIButton.h"

@implementation EAUIButton


- (void)setUp
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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

//工厂方法

+ (instancetype) instanceButtonWithTitle:(NSString *)title
{
    EAUIButton *button = [[EAUIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:@"Common_Button_Bg"] forState:UIControlStateNormal];
    [button setTitle:title forState: UIControlStateNormal];
    
    button.titleLabel.tintColor = [UIColor whiteColor];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    return button;
}

@end
