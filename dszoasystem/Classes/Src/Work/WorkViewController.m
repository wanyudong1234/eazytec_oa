//
//  WorkViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/25.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "WorkViewController.h"

#import "WorkTableViewCell.h"

@interface WorkViewController ()

@property (nonatomic,retain) EAUITableView *tableview;
@property (nonatomic,retain) NSNumber *worktype;

@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableview = [[EAUITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.delegate    = self;
    _tableview.dataSource  = self;
    _tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [_tableview registerClass:[WorkTableViewCell class] forCellReuseIdentifier:@"WorkTableViewCell"];
    [self.view addSubview:_tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"我的工作";
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"WorkTableViewCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.titlelabel.text = @"待办事项";
        cell.detaillabel.text = @"处理局上级文件以及相关发文文件,包括事项查看,填写审批意见和相关流程等.";
        cell.imageview.image  = [UIImage imageNamed:@"Work_Todo"];
    }
    else if (indexPath.row == 1) {
        cell.titlelabel.text  = @"待阅事项";
        cell.detaillabel.text = @"处理局相关工作中的阅办件,包括事项查看,填写审批意见和相关流程等.";
        cell.imageview.image  = [UIImage imageNamed:@"Work_Toread"];
    }
    else if(indexPath.row == 2) {
        cell.titlelabel.text  = @"通知公告";
        cell.detaillabel.text = @"查看相关局通知公告内容,以及所属相关附件.";
        cell.imageview.image  = [UIImage imageNamed:@"Work_Notice"];
        
    }
    else if(indexPath.row == 3) {
        cell.titlelabel.text  = @"我的邮件";
        cell.detaillabel.text = @"处理与我相关的邮件,包括查看邮件和回复邮件等内容.";
        cell.imageview.image  = [UIImage imageNamed:@"Work_Email"];
    }
    else if(indexPath.row == 4) {
        cell.titlelabel.text  = @"主题动态";
        cell.detaillabel.text = @"查看局主题信息和相关动态,以及所属相关附件.";
        cell.imageview.image  = [UIImage imageNamed:@"Work_Study"];  
    }
    else if(indexPath.row == 5) {
        cell.titlelabel.text  = @"工作查询";
        cell.detaillabel.text = @"查询相关发文文件,查看文件内容,检查相关审批信息和处理意见.";
        cell.imageview.image  = [UIImage imageNamed:@"Work_Search"];
    }
    
    return cell;
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        _worktype = [NSNumber one];
        [self performSegueWithIdentifier:@"WorkToProcessListSegue" sender:self];
    }
    else if (indexPath.row == 1) {
        _worktype = [NSNumber numberWithInt:3];
        [self performSegueWithIdentifier:@"WorkToProcessListSegue" sender:self];
    }
    else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"WorkToNotifyListSegue" sender:self];
    }
    else if (indexPath.row == 3) {
         [self performSegueWithIdentifier:@"WorkToEmailListSegue" sender:self];
    }
    else if(indexPath.row == 4) {
         [self performSegueWithIdentifier:@"WorkToStudyListSegue" sender:self];
    }
    else if(indexPath.row == 5) {
         [self performSegueWithIdentifier:@"WorkToSearchSegue" sender:self];
    }
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90 + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TABLE_SECTION_MIN_HEIGHT;
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
    if ([segue.identifier isEqualToString:@"WorkToProcessListSegue"]) {
        [segue.destinationViewController setValue:_worktype forKey:@"type"];

    }
}

@end
