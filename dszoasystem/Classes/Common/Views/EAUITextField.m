//
//  EAUITextField.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/23.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAUITextField.h"

@implementation EAUITextField

- (void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.spellCheckingType = UITextSpellCheckingTypeDefault;
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

+ (instancetype) instanceTextField
{
    EAUITextField *textField = [[EAUITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor whiteColor];
    textField.returnKeyType = UIReturnKeyDone;
    return textField;
}


@end
