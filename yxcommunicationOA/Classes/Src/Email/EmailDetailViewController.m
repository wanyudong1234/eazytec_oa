//
//  EmailDetailViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/29.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EmailDetailViewController.h"

#import "EmailContentTableViewCell.h"

@interface EmailDetailViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

@property (nonatomic,retain) NSString *titleofemail;
@property (nonatomic,retain) NSString *contentofemail;
@property (nonatomic,retain) NSString *timeofsemail;
@property (nonatomic,retain) NSString *sendernameofemail;
@property (nonatomic,retain) NSString *senderidofemail;

@property (nonatomic,retain) NSArray  *attachmentsofemail;
@property (nonatomic,retain) NSString *attachmenturl;

@end

@implementation EmailDetailViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
    
    self.navigationItem.title = @"我的邮件";
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
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.emailno forKey:TABLE_PARMS_ID];
    
    [self didLoadingUserDataWithParamsNoError:dict andService:SERVICE_NAME_MAIL_DETAIL];
}

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    // 常规属性
    _titleofemail = [result objectForKey:@"Title"];
    _contentofemail = [result objectForKey:@"Content"];
    _timeofsemail = [result objectForKey:@"Time"];
    _senderidofemail = [result objectForKey:@"SenderId"];
    _sendernameofemail = [result objectForKey:@"SenderName"];
    
    // 其他属性
    _attachmentsofemail = [result objectForKey:@"AttachmentList"];
    [_tableview reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([NSArray isArrayNull:_attachmentsofemail]) {
        return 3;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    } else {
        if([NSArray isArrayNull:_attachmentsofemail]) {
            return 0;
        }
        return _attachmentsofemail.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        // 不做处理
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }
    else {
        
        UILabel *textlabel = [[UILabel alloc]init];
        textlabel.frame = CGRectMake(15, 34, 100, 12);
        textlabel.font = [UIFont systemFontOfSize:12];
        textlabel.textColor = COLOR_LABEL_GRAY;
        if (section == 1) {
            textlabel.text = @"主题内容";
        }else if(section == 2) {
            textlabel.text = @"相关操作";
        }else {
            textlabel.text = @"其他附件";
        }
        UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
        [sectionview setBackgroundColor:[UIColor clearColor]];
        [sectionview addSubview:textlabel];
        return sectionview;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"EmailDetailCommonTableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"EmailDetailCommonTableViewCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"主题";
            cell.detailTextLabel.text = _titleofemail;
        } else if(indexPath.row == 1) {
            cell.textLabel.text = @"发送人";
            cell.detailTextLabel.text = _sendernameofemail;
        } else {
            cell.textLabel.text = @"发送日期";
            cell.detailTextLabel.text = _timeofsemail;
        }
        return cell;
    } else if (indexPath.section == 1) {
        
        EmailContentTableViewCell *cell = [[EmailContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmailContentTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.webview loadHTMLString:_contentofemail baseURL:nil];
        return cell;
    } else if (indexPath.section == 2) {
        
        UITableViewCell *cell = cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmailDetailReplyTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = @"回复此邮件";
        return cell;
        
    } else {
        UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"EmailDetailAttachTableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmailDetailAttachTableViewCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
        
        NSDictionary *attachments = _attachmentsofemail[indexPath.row];
        cell.textLabel.text = [attachments objectForKey:@"AttachmentName"];
        return cell;
    }
    return nil;
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"EmailDetailToReplySegue" sender:self];
    }
    else if(indexPath.section == 3) {
        NSDictionary *attachments = _attachmentsofemail[indexPath.row];
        _attachmenturl = [attachments objectForKey:@"AttachmentUrl"];
        [self performSegueWithIdentifier:@"EmailToAttachSegue" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 3) {
        return 40;
    } else if (indexPath.section == 2) {
        return 45;
    }
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"EmailToAttachSegue"]) {
        [segue.destinationViewController setValue:self.attachmenturl forKey:@"attachmenturl"];
    }
    
    if ([segue.identifier isEqualToString:@"EmailDetailToReplySegue"]) {
        [segue.destinationViewController setValue:self.senderidofemail forKey:@"toid"];
        [segue.destinationViewController setValue:self.sendernameofemail forKey:@"toname"];
        [segue.destinationViewController setValue:self.titleofemail forKey:@"totitle"];
    }
    
}

@end
