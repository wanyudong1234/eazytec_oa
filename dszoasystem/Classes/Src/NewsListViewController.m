//
//  NewsListViewController.m
//  yxcommunicationOA
//
//  Created by Yudong WAN on 16/11/3.
//  Copyright © 2016年 eazytec. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsListTableViewCell.h"

@interface NewsListViewController ()

@property (nonatomic, retain) EAUITableView *tableView;
@property (nonatomic, retain) NSMutableArray *newsArr;

@property (nonatomic, assign) int pageindex;
@property (nonatomic, assign) int pagesize;

@property (nonatomic, retain) NSString *newsno;

@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _tableView = [[EAUITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(didStartHeaderNormalRefresh)];
    
    [_tableView registerClass:[NewsListTableViewCell class] forCellReuseIdentifier:@"NewsListTableViewCell"];
    [self.view addSubview:_tableView];
    
    // 自定义后退按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Common_Back"] style:UIBarButtonItemStylePlain target:self action:@selector(doNavigationLeftBarButtonItemAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
    
    self.navigationItem.title = @"新闻中心";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

// 返回上一页
- (void)doNavigationLeftBarButtonItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - init data

- (void)initData {
    
    _newsArr = [[NSMutableArray alloc]init];
    _pageindex = 1;
    _pagesize  = _tableView.frame.size.height/60 + 5;
    
    [self didLoadingDataWithPaging];
}

- (void)didLoadingDataWithPaging {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)_pagesize] forKey:PAGING_TABLE_PAGE_SIZE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)_pageindex] forKey:PAGING_TABLE_PAGE_INDEX];
    
    [self didLoadingUserDataWithParamsNoError:dict andService:SERVICE_NAME_NEWS_LIST];
}

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    
    NSArray*  dataList = [result objectForKey:@"List"];
    NSNumber* totalNum = [result objectForKey:@"totalNum"];
    
    // 如果已经没有足够的数据加载了, 则取消上拉加载
    // 这里有一个兼容逻辑: 如果加载出来的数据小于page_size,则也取消上拉加载
    if ( dataList.count >= [totalNum intValue] || dataList.count < _pagesize) {
        _tableView.footer = nil;
    }else{
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(didStartFooterNormalRefresh)];
    }
    [_newsArr addObjectsFromArray:[result objectForKey:@"List"]];
    [_tableView reloadData];
}

//  开始进入下拉状态
- (void)didStartHeaderNormalRefresh {
    _pageindex = 1;
    
    [self initData];
    [_tableView.header endRefreshing];
}

//  开始进入上拉状态
- (void)didStartFooterNormalRefresh {
    _pageindex = _pageindex + 1;
    
    [self didLoadingDataWithPaging];
    [_tableView.footer endRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListTableViewCell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (_newsArr.count < indexPath.row) {
        return cell;
    }
    cell.titlelabel.text = [_newsArr[indexPath.row] objectForKey:@"SUBJECT"];
    cell.timelabel.text  = [_newsArr[indexPath.row] objectForKey:@"NEWS_TIME"];
    return cell;
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _newsno = [_newsArr[indexPath.row] objectForKey:@"NEWS_ID"];
    [self performSegueWithIdentifier:@"NewsListToDetailSegue" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

#pragma mark - Table view setting

// 自定义TableViewCell分割线, 清除前面15PX的空白
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [segue.destinationViewController setValue:self.newsno forKey:@"newsno"];
}


@end
