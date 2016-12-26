//
//  EmailReplyViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/29.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EmailReplyViewController.h"

#import "EmailReplyTitleTableViewCell.h"
#import "EmailReplyContentTableViewCell.h"

@interface EmailReplyViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

// 输入内容
@property (nonatomic,assign) EAUITextField *titlefield;
@property (nonatomic,assign) EAUITextView  *contentview;

@end

@implementation EmailReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableview = [[EAUITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.delegate    = self;
    _tableview.dataSource  = self;
    
    [self.view addSubview:_tableview];
    
    // 自定义后退按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Common_Back"] style:UIBarButtonItemStylePlain target:self action:@selector(doNavigationLeftBarButtonItemAction:)];
    
    // 自定义前进按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Common_Sure"] style:UIBarButtonItemStylePlain target:self action:@selector(doNavigationRightBarButtonItemAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"邮件回复";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

// 返回上一页
- (void)doNavigationLeftBarButtonItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

// 提交邮件回复
- (void)doNavigationRightBarButtonItemAction:(UIBarButtonItem *)item {
    [self dataReply];
}

#pragma mark - Data Reply

- (void) dataReply {
    
    // 前置校检
    if ([NSString isStringBlank:self.titlefield.text]) {
        [EAlertDefault alertWarningInfoWithTitle:@"系统提示" andMessage:@"请输入主题" andTarget:self];
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.toid forKey:@"User"];
    [dict setObject:self.titlefield.text forKey:@"Title"];
    [dict setObject:self.contentview.text forKey:@"Content"];
    [self didLoadingUserDataWithParamsNoError:dict andService:SERVICE_NAME_MAIL_REPLY];
}

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    UIAlertAction *canelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [EAlertDefault alertWarningInfoWithTitle:@"系统提示" andMessage:@"回复邮件成功,点击返回" andTarget:self andAction:canelAction];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        // 不做处理
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    } else {
        UILabel *textlabel = [[UILabel alloc]init];
        textlabel.frame = CGRectMake(15, 34, 100, 12);
        textlabel.font = [UIFont systemFontOfSize:12];
        textlabel.textColor = COLOR_LABEL_GRAY;
        
        if (section == 1) {
            textlabel.text = @"回复主题";
        } else {
            textlabel.text = @"回复内容";
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
            // 发件人收件人信息
            UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"EmailReplyCommonTableViewCell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"EmailReplyCommonTableViewCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
            if(indexPath.row == 0) {
                cell.textLabel.text = @"发送人";
                cell.detailTextLabel.text = [EAUserDefault loadUserLoginNameHasRemember];
            } else {
                cell.textLabel.text = @"收件人";
                cell.detailTextLabel.text = self.toname;
            }
            return cell;
    } else if(indexPath.section == 1) {
        EmailReplyTitleTableViewCell *cell = [[EmailReplyTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmailReplyTitleTableViewCell"];
        cell.textfield.delegate = self;
        _titlefield = cell.textfield;
        return cell;
    } else {
        EmailReplyContentTableViewCell *cell = [[EmailReplyContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmailReplyContentTableViewCell"];
        cell.textview.delegate = self;
        _contentview = cell.textview;
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 40;
    }else if (indexPath.section == 1) {
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

#pragma mark - UITextField setting

//开始编辑输入框的时候，软键盘出现，执行此事件
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    int offset = 195 + KEYBOARD_RESIZE_CORRECTION - _tableview.frame.size.height + KEYBOARD_HEIGHT; //键盘高度316
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        _tableview.frame = CGRectMake(0.0f, -offset, _tableview.frame.size.width, _tableview.frame.size.height);
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _tableview.frame =CGRectMake(0, 0, _tableview.frame.size.width, _tableview.frame.size.height);
}

#pragma mark - UITextView setting

//开始编辑输入框的时候，软键盘出现，执行此事件
- (void)textViewDidBeginEditing:(UITextView *)textView {
    int offset = 445 + KEYBOARD_RESIZE_CORRECTION - _tableview.frame.size.height + KEYBOARD_HEIGHT; //键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        _tableview.frame = CGRectMake(0.0f, -offset, _tableview.frame.size.width, _tableview.frame.size.height);
    [UIView commitAnimations];
}


//输入框编辑完成以后，将视图恢复到原始状态
- (void)textViewDidEndEditing:(UITextView *)textView {
    _tableview.frame =CGRectMake(0, 0, _tableview.frame.size.width, _tableview.frame.size.height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
