//
//  ProcessDetailViewController.h
//  YXTourismOA
//
//  Created by eazytec on 15/12/31.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAUIViewController.h"

@interface ProcessDetailViewController : EAUIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,retain) EAProcessor *processor;

@end
