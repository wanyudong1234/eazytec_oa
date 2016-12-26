//
//  NewsDetailViewController.h
//  yxcommunicationOA
//
//  Created by Yudong WAN on 16/11/3.
//  Copyright © 2016年 eazytec. All rights reserved.
//

#import "EAUIViewController.h"

@interface NewsDetailViewController : EAUIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSString *newsno;

@end
