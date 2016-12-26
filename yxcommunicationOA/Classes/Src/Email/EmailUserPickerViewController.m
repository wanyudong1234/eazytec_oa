//
//  EmailUserPickerViewController.m
//  YXTourismOA
//
//  Created by eazytec on 16/3/8.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "EmailUserPickerViewController.h"

#import "MemberPickTableViewCell.h"

static NSMutableArray * depKeys;

@interface EmailUserPickerViewController ()

@property (nonatomic,retain) EAUITableView *tableview;
@property (nonatomic,retain) NSMutableArray *selectedmembers;
@property (nonatomic,retain) NSDictionary *members;

@property (nonatomic,retain) NSMutableArray *checkRecordArr;

@end

@implementation EmailUserPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    depKeys = [[NSMutableArray alloc] init];
    
    _tableview = [[EAUITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.delegate    = self;
    _tableview.dataSource  = self;
    
    [self.view addSubview:_tableview];
    
    // 自定义后退按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Common_Back"] style:UIBarButtonItemStylePlain target:self action:@selector(doNavigationLeftBarButtonItemAction:)];
    
    // 自定义前进按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Common_Sure"] style:UIBarButtonItemStylePlain target:self action:@selector(doNavigationRightBarButtonItemAction:)];
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"人员选择";
    
    _selectedmembers = [[NSMutableArray alloc]init];
    _members = [[NSDictionary alloc]init];
    _checkRecordArr = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [self didLoadingUserDataWithParams:dict andService:SERVICE_NAME_MAIL_USER_LOAD];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

// 返回上一页
- (void)doNavigationLeftBarButtonItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doNavigationRightBarButtonItemAction:(UIBarButtonItem *)item {
    [self.delegate pickMembers:_selectedmembers];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
   
    if (name == SERVICE_NAME_MAIL_USER_LOAD) {
        self.members = [EAMember arrangementUserDictionaryByDepartmentName:[result objectForKey:@"List"] :depKeys];
        [self.tableview reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.members.count;
}

#pragma mark 第section组显示的头部标题

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *textlabel = [[UILabel alloc]init];
    textlabel.frame = CGRectMake(15, 14, 200, 12);
    textlabel.font = [UIFont systemFontOfSize:12];
    textlabel.textColor = COLOR_LABEL_GRAY;
    
    textlabel.text = depKeys[section];
    
    UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
    [sectionview setBackgroundColor:[UIColor clearColor]];
    [sectionview addSubview:textlabel];
    return sectionview;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key   = depKeys[section];
    NSArray *values = [self.members objectForKey:key];
    
    return values.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemberPickTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MemberPickTableViewCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 提取数据
    NSString *key          = depKeys[indexPath.section];
    NSArray *values        = [self.members objectForKey:key];
    
    EAMember *member       = values[indexPath.row];
    cell.selectionStyle    = UITableViewCellSelectionStyleNone;
    cell.textLabel.text    = member.user_name;
    cell.imageView.image   = [UIImage imageNamed:@"Common_UnCheck"];
    
    if ([_checkRecordArr containsObject:indexPath]){
        [cell setPickerDisplay];
    }
    return cell;
}


#pragma mark 点击跳转事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MemberPickTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *key          = depKeys[indexPath.section];
    NSArray *values        = [self.members objectForKey:key];
    EAMember *member       = values[indexPath.row];
    
    if(cell.picked == NO){ // 没有被选中, 现在被选中了
        [cell setPickerDisplay];
        [_selectedmembers addObject:member];
        [_checkRecordArr addObject:indexPath];
    } else{
        [cell setUnPickerDisplay];
        [_selectedmembers removeObject:member];
        [_checkRecordArr removeObject:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
