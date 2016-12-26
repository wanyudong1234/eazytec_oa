//
//  MyButton.m
//  yxcommunicationOA
//
//  Created by Yudong WAN on 16/11/2.
//  Copyright © 2016年 eazytec. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//构造按钮frame
-(id)initWithButtonFrame:(CGFloat)x :(CGFloat)y{
    
    CGRect rButton = CGRectMake(x, y+0.5f, SCREEN_WIDTH/3-0.5f, SCREEN_WIDTH/3-0.5f);
    
    self = [super initWithFrame:rButton];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
}


//按钮内图片与标题的子布局
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.bounds;
    
    CGRect rImage={{r.size.width/4,r.size.width/8},{r.size.width/2,r.size.width/2}};
    
    self.imageView.frame = rImage;
    
    CGRect rTitle = {{0,r.size.height/2},{r.size.width,r.size.height/2}};
    
    self.titleLabel.frame = rTitle;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
