//
//  HomeViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeHeadTableViewCell.h"
#import "HomeContentTitleTableViewCell.h"
#import "HomeContentTableViewCell.h"

@interface HomeViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

@property (nonatomic,retain) NSMutableArray *notifyarray;
@property (nonatomic,retain) NSMutableArray *emailarray;

@property (nonatomic,retain) NSString *notifyno;
@property (nonatomic,retain) NSString *emailno;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableview = [[EAUITableView alloc]initWithFrame:CGRectMake(0, -HEAD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT + HEAD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
    
    _tableview.delegate    = self;
    _tableview.dataSource  = self;
    
    [_tableview registerClass:[HomeContentTableViewCell class] forCellReuseIdentifier:@"HomeContentTableViewCell"];
    [_tableview registerClass:[HomeContentTitleTableViewCell class] forCellReuseIdentifier:@"HomeContentTitleTableViewCell"];
    [_tableview registerClass:[HomeHeadTableViewCell class] forCellReuseIdentifier:@"HomeHeadTableViewCell"];
    
    [self.view addSubview:_tableview];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];   // 隐藏状态栏
    //刷新最新邮件与通知
    [self initData];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false];
}

// 首页的状态栏前景色为白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - init data

- (void)initData {
    
    _notifyarray = [[NSMutableArray alloc]init];
    _emailarray  = [[NSMutableArray alloc]init];
   [self didLoadingUserDataWithParamsNoError:nil andService:SERVICE_NAME_HOME];
}

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    // 其他属性
    _notifyarray = [result objectForKey:@"NList"];
    _emailarray =  [result objectForKey:@"EList"];
    
    if ([NSArray isArrayNull:_notifyarray]) {
        _notifyarray = [[NSMutableArray alloc]init];
    }
    
    if ([NSArray isArrayNull:_emailarray]) {
        _emailarray  = [[NSMutableArray alloc]init];
    }  
    [_tableview reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
    // 1.头部固定
    // 2.通知公告
    // 3.最新邮件
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 1 + _notifyarray.count;
    }
    else if(section == 2) {
        return 1 + _emailarray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 只有一行,起始图片行
        HomeHeadTableViewCell *cell = [[HomeHeadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeHeadTableViewCell"];
        return cell;
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            HomeContentTitleTableViewCell *cell = [[HomeContentTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeContentTitleTableViewCell"];
            cell.titlelabel.text = @"最新公告";
            return cell;
        }else {
            HomeContentTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"HomeContentTableViewCell" forIndexPath:indexPath];
    
            if (_notifyarray.count < indexPath.row - 1) {
                return cell;
            }
            cell.titlelabel.text = [_notifyarray[indexPath.row - 1] objectForKey:@"Title"];
            cell.contentlabel.text = [NSString flattenHTML:[_notifyarray[indexPath.row - 1] objectForKey:@"Content"] trimWhiteSpace:YES];
            cell.timelabel.text = [_notifyarray[indexPath.row - 1] objectForKey:@"Time"];
            return cell;
        }
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            HomeContentTitleTableViewCell *cell = [[HomeContentTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeContentTitleTableViewCell"];
            cell.titlelabel.text = @"最新邮件";
            return cell;
        }else {
            HomeContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeContentTableViewCell" forIndexPath:indexPath];
        
            if (_emailarray.count < indexPath.row - 1) {
                return cell;
            }
            cell.titlelabel.text = [_emailarray[indexPath.row - 1] objectForKey:@"Title"];
            cell.contentlabel.text = [NSString flattenHTML:[_emailarray[indexPath.row - 1] objectForKey:@"Content"] trimWhiteSpace:YES];
            cell.timelabel.text = [_emailarray[indexPath.row - 1] objectForKey:@"Time"];
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return SCREEN_WIDTH * 3/5 + 75;
    }
    else if (indexPath.section  > 0) {
        if (indexPath.row == 0) {
            return  40;
        }else {
            return  70;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return TABLE_SECTION_MIN_HEIGHT;
    }
    else {
        return 15;
    }
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"HomeToNotifyListSegue" sender:self];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"HomeToEmailListSegue" sender:self];
    }
    if (indexPath.section == 1 && indexPath.row > 0) {
        _notifyno = [_notifyarray[indexPath.row - 1] objectForKey:@"Id"];
        [self performSegueWithIdentifier:@"HomeToNotifyDetailSegue" sender:self];
    }
    if (indexPath.section == 2 && indexPath.row > 0) {
        _emailno = [_emailarray[indexPath.row - 1] objectForKey:@"Id"];
        [self performSegueWithIdentifier:@"HomeToEmailDetailSegue" sender:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    if ([segue.identifier isEqualToString:@"HomeToNotifyDetailSegue"]) {
          [segue.destinationViewController setValue:_notifyno forKey:@"notifyno"];
    }
    else if ([segue.identifier isEqualToString:@"HomeToEmailDetailSegue"]) {
        [segue.destinationViewController setValue:_emailno forKey:@"emailno"];
    }
}

@end
