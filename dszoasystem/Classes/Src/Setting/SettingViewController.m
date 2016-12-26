//
//  SettingViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/26.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "SettingViewController.h"
#import "HomeHeadTableViewCell.h"

@interface SettingViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableview = [[EAUITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.delegate    = self;
    _tableview.dataSource  = self;
    
    [self.view addSubview:_tableview];
    
    // 自定义后退按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Common_Back"] style:UIBarButtonItemStylePlain target:self action:@selector(doNavigationLeftBarButtonItemAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"个人中心";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO];
}

// 返回上一页
- (void)doNavigationLeftBarButtonItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        // 只有一行,起始图片行
        HomeHeadTableViewCell *cell = [[HomeHeadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeHeadTableViewCell"];
        return cell;
        
    } else if (indexPath.section == 1) {
        
        UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        if(indexPath.row == 0) { // 登陆名
            cell.textLabel.text = @"登陆名";
            cell.detailTextLabel.text = [[EAUserDefault loadUserLoginHasRemember] login_id];
            cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
        } else { // 登陆时间
            cell.textLabel.text = @"登陆时间";
            AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
            cell.detailTextLabel.text = [appdelegate loginTime];
            cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
        }
        return cell;
    }
    else {
        UITableViewCell *cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingTableViewCell"];
        cell.imageView.image = [UIImage imageNamed:@"Setting_time"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.text = @"重新登陆";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        UIAlertAction *logout_action   = [UIAlertAction actionWithTitle:@"确认退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [EAUserDefault clearLoginUserInfo];
            [self performSegueWithIdentifier:@"SettingToLoginSegue" sender:self];   
        }];
        [EAlertDefault alertWarningInfoWithTitle:@"系统提示" andMessage:@"是否需要重新登陆" andTarget:self andOtherAction:logout_action];
        [_tableview deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SCREEN_WIDTH * 3/5 + 75;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return TABLE_SECTION_MIN_HEIGHT;
    }
    return 20;
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

@end
