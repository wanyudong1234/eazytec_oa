//
//  SearchDetailViewController.h
//  YXLibraryOA
//
//  Created by eazytec on 16/1/12.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "EAUIViewController.h"

@interface SearchDetailViewController : EAUIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,retain) EAProcessor *processor;

@end
