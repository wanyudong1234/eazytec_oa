//
//  ProcessDetailViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/31.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "ProcessDetailViewController.h"

#import "ProcessReadTableViewCell.h"
#import "ProcessWriteTableViewCell.h"
#import "ProcessCouSignTableViewCell.h"

@interface ProcessDetailViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

@property (nonatomic,retain) NSArray  *attachments;
@property (nonatomic,retain) NSString *attachmenturl;

@property (nonatomic,retain) NSMutableDictionary *detailresult;

@end

@implementation ProcessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self initData];
    
    self.navigationItem.title = @"工作详情";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

// 返回上一页
- (void)doNavigationLeftBarButtonItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doNavigationRightBarButtonItemAction:(UIBarButtonItem *)item {
    [self didSumbitDetailToView:item];
}

#pragma mark - init data

- (void)initData {
    
   _detailresult = [[NSMutableDictionary alloc]init];
   _attachments = [[NSArray alloc]init];
   [self didLoadingUserDataWithParamsNoError:[self.processor createDictionaryFromProcessorForRequest] andService:SERVICE_NAME_TODO_DETAIL];
}


- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    
    // SERVICE_NAME_TODO_DETAIL
    if (name == SERVICE_NAME_TODO_DETAIL) {    
        self.attachments          = [result objectForKey:@"AttachmentList"];//设置附件列表
        self.processor.op_flag    = [result objectForKey:@"OP_flag"];//设置主办人标志
        self.processor.title      = [result objectForKey:@"Title"];//设置标题
        
        [self.processor setProcessContentAnalysisWithRequest:[result objectForKey:@"FormList"]];
        [_tableview reloadData];
    }
    
    // SERVICE_NAME_TODO_SUBMIT
    if (name == SERVICE_NAME_TODO_SUBMIT) {
        
        // 如果是经办人
        if (![self.processor isUserAssumeProcessSponsor]) {
            UIAlertAction *canelAction = [UIAlertAction actionWithTitle:@"返回列表" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [EAlertDefault alertWarningInfoWithTitle:@"提交成功" andMessage:@"此工作已提交到办公室" andTarget:self andAction:canelAction];
            return;
        }
        
        // 如果是主办人
        NSNumber *work_end   = [result objectForKey:@"IsWorkFlowEnd"];
        NSString *enable_end = [result objectForKey:@"EnableEndFlow"];
        NSArray *next_work_list = [result objectForKey:@"NextWorkList"];
        if ([NSNumber isNumberNil:work_end]|| [NSString isStringNil:enable_end]) {
            // 这里的这个逻辑不是很明白, 但是安卓客户端拥有这个逻辑, 所以这里先暂时保留着
            UIAlertAction *canelAction = [UIAlertAction actionWithTitle:@"返回列表" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [EAlertDefault alertWarningInfoWithTitle:@"提交成功" andMessage:@"请点击返回列表" andTarget:self andAction:canelAction];
        }
        else if ([work_end isEqual:0] || [NSArray isArrayNull:next_work_list] || [next_work_list count] == 0) {
            UIAlertAction *overAction = [UIAlertAction actionWithTitle:@"结束流程" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self didLoadingUserDataWithParamsNoError:[self.processor createDictionaryFromProcessorForEndProcess] andService:SERVICE_NAME_TODO_FLOW_SUBMIT];
            }];
            [EAlertDefault alertWarningInfoWithTitle:@"提交成功" andMessage:@"是否结束流程" andTarget:self andOtherAction:overAction];
        }
        else{
            [self.processor setProcessSelectorAnalysisWithRequest:result];
            [self performSegueWithIdentifier:@"ProcessDetailToFlowSegue" sender:self];
        }
    }
    
    // SERVICE_NAME_TODO_FLOW_SUBMIT
    if (name == SERVICE_NAME_TODO_FLOW_SUBMIT) {
       [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 提交信息

- (void)didSumbitDetailToView:(UIBarButtonItem *)item {
    
    // 创建提交信息
    NSMutableDictionary  *params = [self.processor createDictionaryFromProcessorForRequest];
    NSMutableArray *jsonArray    = [[NSMutableArray alloc]init];
    
    NSMutableArray *content      = [self.processor getProcessContentForDisplay];
    for (NSUInteger index = 0; index < content.count; index++) {
        
        NSMutableDictionary *display   = [self.processor getProcessContentForDisplay][index];
        ProcessElementDisplayType type = [EAProcessor getProcessContentElementTypeForDisplay:display];
        
        if (type == ElementForReadToDisplay) continue;
        NSMutableDictionary *to_fill   = [[NSMutableDictionary alloc]init];
        [to_fill setObject:[display objectForKey:@"ElementId"] forKey:@"ElementId"];
        
        NSMutableString *text          = [NSMutableString new];
        UITextField *field             = [_detailresult objectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)index]];
        
        NSString *file_text            = [NSString isStringNil:field.text]? @"":field.text;
        
        if (type == ElementForCounterSignToDisplay) {
            [text appendString:[display objectForKey:@"ElementValue"]];
            [text appendString:[NSString blankToFill]];
        }
        // 检测是否有填写签阅信息
        if(![file_text isEqualToString:@""]){
            [text appendString:file_text];
            [text appendString:[NSString blankToFill]];
            [self didAutoAddUserNameWithText:text andDisplay:display];
            [self didAutoAddTimeWithText:text andDisplay:display];
        }
        
        [to_fill setObject:[NSString stringWithString:text] forKey:@"ElementValue"];
        [jsonArray addObject:to_fill];
    }
    [params setObject:[[[SBJson4Writer alloc]init] stringWithObject:jsonArray] forKey: @"JsonStr"];
    [params setObject:[NSString one] forKey: @"IsSubmit"];  //确认提交标志
    [self didLoadingUserDataWithParamsNoError:params andService:SERVICE_NAME_TODO_SUBMIT];
}

- (void)didAutoAddUserNameWithText:(NSMutableString *)text andDisplay:(NSMutableDictionary *)display {
    NSNumber *autoUser = [display objectForKey:@"AutoAddUserName"];
    if ([autoUser longValue] == 1) {
        [text appendString:[EAUserDefault loadUserLoginNameHasRemember]];
        [text appendString:[NSString blankToFill]];
    }
}

- (void)didAutoAddTimeWithText:(NSMutableString *)text andDisplay:(NSMutableDictionary *)display {
    NSNumber *autoUser = [display objectForKey:@"AutoAddTime"];
    if ([autoUser longValue] == 1) {
        NSDate *  now_date              = [NSDate date];
        NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        [text appendString:[dateformatter stringFromDate:now_date]];
        [text appendString:[NSString blankToFill]];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([NSArray isArrayNull:_attachments]) {
        return [[self.processor getProcessContentForDisplay] count];
    }
    return [[self.processor getProcessContentForDisplay] count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < [[self.processor getProcessContentForDisplay] count]) {
        return 1;
    } else {
        return [_attachments count]; //附件数量
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section < [[self.processor getProcessContentForDisplay] count]) {
        UILabel *textlabel = [[UILabel alloc]init];
        textlabel.frame = CGRectMake(15, 14, SCREEN_WIDTH - 30, 12);
        textlabel.font = [UIFont systemFontOfSize:12];
        textlabel.textColor = COLOR_LABEL_GRAY;
        
        NSMutableDictionary *dict = [[self.processor getProcessContentForDisplay] objectAtIndex:section];
        textlabel.text = [dict objectForKey:@"ElementTitle"];
        
        UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
        [sectionview setBackgroundColor:[UIColor clearColor]];
        [sectionview addSubview:textlabel];
        return sectionview;
        
    } else {
        
        UILabel *textlabel = [[UILabel alloc]init];
        textlabel.frame = CGRectMake(15, 34, 100, 12);
        textlabel.font = [UIFont systemFontOfSize:12];
        textlabel.textColor = COLOR_LABEL_GRAY;
        textlabel.text = @"相关附件";
        
        UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
        [sectionview setBackgroundColor:[UIColor clearColor]];
        [sectionview addSubview:textlabel];
        return sectionview;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section < [[self.processor getProcessContentForDisplay] count]) {
        
        NSMutableDictionary *display   = [self.processor getProcessContentForDisplay][indexPath.section];
        ProcessElementDisplayType type = [EAProcessor getProcessContentElementTypeForDisplay:display];
        
        if (type == ElementForReadToDisplay){
            ProcessReadTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"ProcessReadTableViewCell"];
            if (cell == nil) {
                cell = [[ProcessReadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProcessReadTableViewCell"];
            }
            [cell setTextHeight:[display objectForKey:@"ElementValue"]];
            return cell;
            
        } else if(type == ElementForWriteToDisplay) {
           ProcessWriteTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"ProcessWriteTableViewCell"];
           if (cell == nil) {
                cell = [[ProcessWriteTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProcessWriteTableViewCell"];
           }
           cell.textfield.delegate = self;
           [_detailresult setObject:cell.textfield forKey:[NSString stringWithFormat:@"%li",(long)indexPath.section]];
           return cell;
            
        } else {
            ProcessCouSignTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"ProcessCouSignTableViewCell"];
            if (cell == nil) {
                cell = [[ProcessCouSignTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProcessCouSignTableViewCell"];
            }
            [cell setTextHeight:[display objectForKey:@"ElementValue"]];
            [_detailresult setObject:cell.textfield forKey:[NSString stringWithFormat:@"%li",(long)indexPath.section]];
            cell.textfield.delegate = self;
            return cell;
        }
    } else {
        // 附件
        UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"ProcessDetailAttachTableViewCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProcessDetailAttachTableViewCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
        
        NSDictionary *attachments = _attachments[indexPath.row];
        cell.textLabel.text = [attachments objectForKey:@"AttachmentName"];
        return cell;
    }
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == [[self.processor getProcessContentForDisplay] count]) {
        
        NSDictionary *attachments = _attachments[indexPath.row];
        _attachmenturl = [attachments objectForKey:@"AttachmentUrl"];
        
        [self performSegueWithIdentifier:@"ProcessToAttachSegue" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section < [[self.processor getProcessContentForDisplay] count]) {
        
        NSMutableDictionary *display   = [self.processor getProcessContentForDisplay][indexPath.section];
        ProcessElementDisplayType type = [EAProcessor getProcessContentElementTypeForDisplay:display];
        
        if (type == ElementForReadToDisplay){
            NSString *detailText = [display objectForKey:@"ElementValue"];
            NSDictionary *detailTextSizeAttirbute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
            CGSize detailTextSize = [detailText boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30 , ELEMENT_HEIGHT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes:detailTextSizeAttirbute context:nil].size;
            return detailTextSize.height + 20;
        } else if(type == ElementForWriteToDisplay) {
            return 20 + 30;
        } else {
            NSString *detailText = [display objectForKey:@"ElementValue"];
            NSDictionary *detailTextSizeAttirbute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
            CGSize detailTextSize = [detailText boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30 , ELEMENT_HEIGHT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes:detailTextSizeAttirbute context:nil].size;
            return detailTextSize.height + 60;
        }
    } else {
        return 50;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < [[self.processor getProcessContentForDisplay] count]) {
        return 30;
    } else {
        return 50;
    }
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

#pragma mark - TextView

//开始编辑输入框的时候，软键盘出现，执行此事件
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGPoint point = [textField convertPoint:textField.center toView:self.view];
    int offset = point.y + KEYBOARD_RESIZE_CORRECTION - _tableview.frame.size.height + KEYBOARD_HEIGHT; //键盘高度216
    
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
   _tableview.frame = CGRectMake(0, 0, _tableview.frame.size.width, _tableview.frame.size.height);
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ProcessToAttachSegue"]) {
        [segue.destinationViewController setValue:self.attachmenturl forKey:@"attachmenturl"];
    }
    
    if ([segue.identifier isEqualToString:@"ProcessDetailToFlowSegue"]) {
        [segue.destinationViewController setValue:self.processor forKey:@"processor"];
    }
}

@end
