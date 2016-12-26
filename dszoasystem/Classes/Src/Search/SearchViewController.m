//
//  SearchViewController.m
//  YXLibraryOA
//
//  Created by eazytec on 16/1/12.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "SearchViewController.h"


@interface SearchViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

@property (nonatomic,retain) HZQDatePickerView *datepicker;

@property (nonatomic,assign) UILabel *startlabel;
@property (nonatomic,assign) UILabel *endlabel;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableview = [[EAUITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_CONTENT_HEIGHT) style:UITableViewStyleGrouped];
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
    
    self.navigationItem.title = @"工作查询";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


// 返回上一页
- (void)doNavigationLeftBarButtonItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else if (section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SearchTableViewCell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
        cell.detailTextLabel.textColor  = COLOR_LABEL_GRAY;
        cell.detailTextLabel.text = @"点击选择日期";
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];

        if (indexPath.row == 0) {
            cell.textLabel.text = @"查询开始时间";
            _startlabel = cell.detailTextLabel;
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"查询结束时间";
            _endlabel = cell.detailTextLabel;
        }
        return cell;
        
    } else {
        UITableViewCell *cell = cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchButtonTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = @"确认查询";
        return cell;
    }
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        _datepicker = [HZQDatePickerView instanceDatePickerView];
        _datepicker.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_datepicker setBackgroundColor:[UIColor clearColor]];
        _datepicker.delegate = self;
        
        if (indexPath.row == 0) {
            _datepicker.type = DateTypeOfStart;
        }else if(indexPath.row == 1){
            _datepicker.type = DateTypeOfEnd;
        }
        [self.view addSubview:_datepicker];
    }
    else if(indexPath.section == 1) {
        
        //前置检查
        if ([NSString isEqualToString:_startlabel.text andOrigin:@"点击选择日期"] || [NSString isEqualToString:_endlabel.text andOrigin:@"点击选择日期"]) {
            [EAlertDefault alertWarningInfoWithTitle:@"系统提醒" andMessage:@"请选择开始时间和结束时间" andTarget:self];
            [_tableview deselectRowAtIndexPath:indexPath animated:YES];
            return;
        }
        [self performSegueWithIdentifier:@"SearchToListSegue" sender:self];
        
    }
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 45;
    }else {
        return 45;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 30;
    } else {
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        UILabel *textlabel = [[UILabel alloc]init];
        textlabel.frame = CGRectMake(15, 14, SCREEN_WIDTH - 30, 12);
        textlabel.font = [UIFont systemFontOfSize:12];
        textlabel.textColor = COLOR_LABEL_GRAY;
        textlabel.text = @"查询条件";
        
        UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
        [sectionview setBackgroundColor:[UIColor clearColor]];
        [sectionview addSubview:textlabel];
        return sectionview;
    } else {

        UILabel *textlabel = [[UILabel alloc]init];
        textlabel.frame = CGRectMake(15, 34, SCREEN_WIDTH - 30, 12);
        textlabel.font = [UIFont systemFontOfSize:12];
        textlabel.textColor = COLOR_LABEL_GRAY;
        textlabel.text = @"相关操作";
        
        UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
        [sectionview setBackgroundColor:[UIColor clearColor]];
        [sectionview addSubview:textlabel];
        return sectionview;
    }
    return nil;
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

#pragma mark - Date Picker

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    switch (type) {
        case DateTypeOfStart:
            _startlabel.text = date;
            break;
        case DateTypeOfEnd:
            _endlabel.text = date;
            break;    
        default:
            break;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [segue.destinationViewController setValue:_startlabel.text forKey:@"startdate"];
    [segue.destinationViewController setValue:_endlabel.text forKey:@"enddate"];
}


@end
