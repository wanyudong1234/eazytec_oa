//
//  ContactsViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/25.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "ContactsViewController.h"

#import "ContactDepartment.h"
#import "Contact.h"

@interface ContactsViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

@property (nonatomic,retain) NSMutableDictionary *constacts;
@property (nonatomic,retain) NSMutableArray *departments;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableview = [[EAUITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.delegate    = self;
    _tableview.dataSource  = self;
    [self.view addSubview:_tableview];
    
    [self initData];
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
    self.tabBarController.navigationItem.title = @"通讯录";
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - init data

- (void)initData {
    
    _constacts = [[NSMutableDictionary alloc]init];
    _departments = [[NSMutableArray alloc]init];
    
    //加载所有的部门
    [self didLoadingUserDataWithParamsNoError:nil andService:SERVICE_NAME_ADDRESS_DEPARTMENT_LIST];
}

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    
    if (name == SERVICE_NAME_ADDRESS_DEPARTMENT_LIST) {
        NSArray *arrays = [result objectForKey:@"List"];
        for (int index = 0; index < arrays.count; index++) {
            
            NSString *no   = [arrays[index] objectForKey:@"Id"];
            NSString *name = [arrays[index] objectForKey:@"Name"];
            ContactDepartment *department = [[ContactDepartment alloc]initWithNo:no name:name];
            
            [self.departments addObject:department];
            
            NSArray *contactarrays = [arrays[index] objectForKey:@"Contact"];
            
            if (contactarrays == nil) {
                continue;
            }
            NSMutableArray *contactsOfDep = [[NSMutableArray alloc]init];
            for (int index = 0; index < contactarrays.count; index++) {
                NSString *no   = [contactarrays[index] objectForKey:@"Id"];
                NSString *name = [contactarrays[index] objectForKey:@"Name"];
                NSString *tel =  [contactarrays[index] objectForKey:@"Tel"];
                
                Contact *contact = [[Contact alloc]initWithNo:no name:name tel:tel];
                [contactsOfDep addObject:contact];
            }
            [self.constacts setObject:contactsOfDep forKey:no];
        }
        [self.tableview reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _departments.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ContactDepartment *department = [self.departments objectAtIndex:section];
    
    if (department == nil) {
        return 0;
    }
    NSString *depno  = department.noOfDepartment;
    NSMutableArray *contacts = [self.constacts objectForKey:depno];
    return contacts.count;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *textlabel = [[UILabel alloc]init];
    textlabel.frame = CGRectMake(15, 8, 100, 14);
    textlabel.font = [UIFont systemFontOfSize:14];
    
    ContactDepartment *department = [_departments objectAtIndex:section];
    textlabel.text = department.nameOfDepartment;
    
    UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [sectionview setBackgroundColor:[UIColor clearColor]];
    [sectionview addSubview:textlabel];
    return sectionview;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"ContactsTableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ContactsTableViewCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    ContactDepartment *department = [self.departments objectAtIndex:indexPath.section];
    NSString *depno  = department.noOfDepartment;
    NSMutableArray *contacts = [self.constacts objectForKey:depno];
    Contact *contact = [contacts objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:@"Common_Worker"];
    cell.textLabel.text = contact.nameOfContact;
    cell.detailTextLabel.text = contact.telOfContact;
    return cell;
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContactDepartment *department = [self.departments objectAtIndex:indexPath.section];
    NSString *depno  = department.noOfDepartment;
    NSMutableArray *contacts = [self.constacts objectForKey:depno];
    Contact *contact = [contacts objectAtIndex:indexPath.row];
      
    // 如果是短信通知的话, 则还需要输入输入短信内容
    UIAlertAction *tel_action   = [UIAlertAction actionWithTitle:@"拨打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:contact.telOfContact]]];
    }];
    UIAlertAction *sms_action   = [UIAlertAction actionWithTitle:@"发送短信" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"sms://" stringByAppendingString:contact.telOfContact]]];
    }];
    [EAlertDefault alertSelectorInfoWithTitle:nil andMessage:contact.telOfContact andTarget:self andActions:tel_action,sms_action, nil];
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
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
