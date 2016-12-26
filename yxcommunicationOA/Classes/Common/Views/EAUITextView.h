//
//  EAUITextView.h
//  YXTourismOA
//
//  Created by eazytec on 15/12/30.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAUITextView : UITextView

@property(nonatomic,retain) UILabel   *placeHolderLabel;
@property(nonatomic,retain) NSString  *placeholder;
@property(nonatomic,retain) UIColor   *placeholderColor;

+ (instancetype) instanceTextView;

@end
