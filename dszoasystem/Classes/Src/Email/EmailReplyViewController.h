//
//  EmailReplyViewController.h
//  YXTourismOA
//
//  Created by eazytec on 15/12/29.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAUIViewController.h"

@interface EmailReplyViewController : EAUIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic,retain) NSString *toid;
@property (nonatomic,retain) NSString *toname;

@end
