//
//  ProcessListViewController.h
//  YXTourismOA
//
//  Created by eazytec on 15/12/31.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAUIViewController.h"

@interface ProcessListViewController : EAUIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,retain) NSNumber *type;  //流程类型

@end
