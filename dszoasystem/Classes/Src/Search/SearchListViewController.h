//
//  SearchListViewController.h
//  YXLibraryOA
//
//  Created by eazytec on 16/1/12.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "EAUIViewController.h"

@interface SearchListViewController : EAUIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,retain) NSString *startdate;
@property (nonatomic,retain) NSString *enddate;

@end
