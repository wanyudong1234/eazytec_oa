//
//  ProcessFlowViewController.h
//  YXTourismOA
//
//  Created by eazytec on 16/1/5.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "EAUIViewController.h"

#import "MemberPickerViewController.h"

@interface ProcessFlowViewController : EAUIViewController<UITableViewDelegate, UITableViewDataSource,MemberPickerDelegate>

@property (nonatomic,retain) EAProcessor *processor;

@end
