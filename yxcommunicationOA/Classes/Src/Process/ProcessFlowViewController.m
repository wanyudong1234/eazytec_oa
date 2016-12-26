//
//  ProcessFlowViewController.m
//  YXTourismOA
//
//  Created by eazytec on 16/1/5.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "ProcessFlowViewController.h"

static NSMutableArray* departKeys;

@interface ProcessFlowViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

@property (nonatomic,assign) BOOL mainmemberenabled;
@property (nonatomic,assign) NSInteger selectedtabletag;

// 流程选择部分
@property (nonatomic,retain) NSString *selectedflow;
@property (nonatomic,retain) UILabel  *selectedflowlabel;

// 人员选择
@property (nonatomic,retain) UILabel  *selectedmemberlabel;
@property (nonatomic,retain) NSMutableArray *selectedmember;

// 主办人员选择
@property (nonatomic,retain) UILabel  *selectedmainmemberlabel;
@property (nonatomic,retain) NSMutableArray *selectedmainmember;

// 当前选择流程后得到的人员
@property (nonatomic,retain) NSMutableDictionary *members;

// 短信模块提醒
@property (nonatomic,assign) BOOL issmsremind;
@property (nonatomic,retain) NSString *smscontent;
@property (nonatomic,retain) UILabel *smslabel;

// 阅办模块提醒
@property (nonatomic,assign) BOOL isreadflow;
@property (nonatomic,retain) UILabel *readflowlabel;

@end

@implementation ProcessFlowViewController

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
    
    // 是否默认主办人标志
    _mainmemberenabled = YES;
    
    // 初始化短信内容
    NSMutableString *string = [[NSMutableString alloc]initWithString:@"待办提交:"];
    [string appendString:self.processor.title];
    [string appendString:@"--"];
    [string appendString:[EAUserDefault loadUserLoginNameHasRemember]];
    _smscontent = [NSString stringWithString:string];
    
    // 初始化数组
    _selectedmainmember = [[NSMutableArray alloc]init];
    _selectedmember = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"流程提交";
    
    departKeys = [[NSMutableArray alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

// 返回上一页
- (void)doNavigationLeftBarButtonItemAction:(UIBarButtonItem *)item {
     [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[[self.navigationController viewControllers]indexOfObject:self]-2]animated:YES];
}

- (void)doNavigationRightBarButtonItemAction:(UIBarButtonItem *)item {
    [self didSubmitProcessFlow];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.processor.is_read == YES) {
        return 5;  // 如果可以称为阅办件, 则多一个阅办件选择
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ProcessFlowTableViewCell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
    
    if (indexPath.row == 0) {
        // 流程选择器
        cell.textLabel.text = @"转交流程选择";
        cell.detailTextLabel.textColor  = COLOR_LABEL_GRAY;
        cell.detailTextLabel.text = @"点击选择流程";
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        _selectedflowlabel = cell.detailTextLabel;
    }
    
    else if(indexPath.row == 1) {
        // 办理人员选择
        cell.textLabel.text = @"办理人员选择";
        cell.detailTextLabel.textColor  = COLOR_LABEL_GRAY;
        cell.detailTextLabel.text = @"点击选择人员";
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        _selectedmemberlabel = cell.detailTextLabel;

    }
    
    else if(indexPath.row == 2) {
        // 办理人员选择
        cell.textLabel.text = @"主办人员选择";
        cell.detailTextLabel.textColor  = COLOR_LABEL_GRAY;
        cell.detailTextLabel.text = @"点击选择人员";
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        _selectedmainmemberlabel = cell.detailTextLabel;
        
    }
    
    else if(indexPath.row == 3) {
        // 短信模块
        cell.textLabel.text = @"是否短信提醒";
        cell.detailTextLabel.textColor  = COLOR_LABEL_BLUE;
        cell.detailTextLabel.text = @"否";
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        _issmsremind = NO;
        _smslabel = cell.detailTextLabel;
    }
    
    else if(indexPath.row == 4) {
        // 阅办件模块
        cell.textLabel.text = @"是否阅办件";
        cell.detailTextLabel.textColor  = COLOR_LABEL_BLUE;
        cell.detailTextLabel.text = @"否";
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        _isreadflow = NO;
        _readflowlabel = cell.detailTextLabel;
    }
    return cell;
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedtabletag = indexPath.row;
    if (indexPath.row == 0) {
        [self doProcessorFlowPicker]; // 流程选择器
    }
    // 人员选择器
    else if (indexPath.row == 1 || (indexPath.row  == 2 && _mainmemberenabled == YES)) {
        if ([NSString isStringBlank:_selectedflow] ) {
            [EAlertDefault alertWarningInfoWithTitle:@"系统提醒" andMessage:@"请先选择流程" andTarget:self];
        } else {
            [self doloadingFlowMorHandlerBySelectedProcessor];
            [self performSegueWithIdentifier:@"FlowToMemberPickerSegue" sender:self];
 
        }
    }
    // 短信模块选择器
    else if (indexPath.row == 3 || indexPath.row == 4) {
        [self doLoadingSelectorInfo]; //展示选择列表框
    }
    
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

#pragma mark - 流程选择部分

- (void)doProcessorFlowPicker {
    
    NSArray *nextworks = self.processor.next_work;
    NSMutableArray *actions = [[NSMutableArray alloc]init];
    for (int index = 0;index < [nextworks count];index++) {
        NSDictionary *nextwork = [nextworks objectAtIndex:index];
        
        NSString *nextworkid   = [nextwork objectForKey:@"NextWorkId"];
        NSString *nextworkname = [[NSString alloc]init];
        if ([self.processor.flow_prcs intValue] > [nextworkid intValue]) {
            nextworkname      = [@"退回: " stringByAppendingString:[nextwork objectForKey:@"NextWorkName"]];
        } else {
            nextworkname      = [nextwork objectForKey:@"NextWorkName"];
        }
        UIAlertAction *action   = [UIAlertAction actionWithTitle:nextworkname style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 判断一下跟前一个流程是否一样, 如果是一样的就不瞎折腾了
            if ([NSString isEqualToString:self.selectedflow andOrigin:nextworkid]) {
                return;
            }
            // 清除老的人员选择数据
            _selectedmainmember = [[NSMutableArray alloc]init];
            _selectedmember = [[NSMutableArray alloc]init];
            _selectedmemberlabel.text = @"点击选择人员";
            _selectedmemberlabel.textColor  = COLOR_LABEL_GRAY;
            
            self.selectedflow = nextworkid;
            self.selectedflowlabel.textColor = COLOR_LABEL_BLUE;
            self.selectedflowlabel.text = nextworkname;
            
            // 判断是否需要默认的主办人
            int prcsOpType = [[nextwork objectForKey:@"PrcsOpType"]intValue];
            int opFlag     = [self.processor.op_flag intValue];
            //  是否需要默认主办人
            //  根据安卓端的规则来判断,具体为什么这个样子...不知道^ ^
            if ((prcsOpType == 0  &&  opFlag == 1) || (prcsOpType == 1  &&  opFlag == 0 && [nextworkid intValue] == 1) || (prcsOpType == 2 && [self.processor.is_work_end intValue] == 0)) {
                
                _mainmemberenabled = YES;
                _selectedmainmemberlabel.text = @"点击选择人员";
                _selectedmainmemberlabel.textColor  = COLOR_LABEL_GRAY;
            
            } else {
                
                _mainmemberenabled = NO;
                _selectedmainmemberlabel.text = @"存在默认主办人";
                _selectedmainmemberlabel.textColor  = COLOR_LABEL_BLUE;
            }
        }];
        [actions addObject:action];
    }
    [EAlertDefault alertSelectorInfoWithTitle:nil andMessage:@"请选择流程" andTarget:self andArrayActions:actions];
}

#pragma mark - 人员选择器

- (void)doloadingFlowMorHandlerBySelectedProcessor{
    NSMutableDictionary *params = [self.processor createDictionaryFromProcessorForRequest];
    [params setObject:_selectedflow forKey:@"Prcs_To_Choose"];
    
    [self didSyncLoadingUserDataWithParamsNoError:params andService:SERVICE_NAME_TODO_MORE_HANDLER];
}

#pragma mark - Picker代理事件

- (void)pickMembers:(NSMutableArray * )members{
    NSEnumerator* enumerator = members.objectEnumerator;
    NSString* text           = [[NSString alloc]init];
    
    EAMember *value;
    int index = 0;
    while ((value = enumerator.nextObject)) {
        text                     = [text stringByAppendingString:value.user_name];
        text                     = [text stringByAppendingString:@","];
        index++;
    }
    
    if (_selectedtabletag == 1) {
        _selectedmemberlabel.text = text;
        _selectedmember = members;
        _selectedmemberlabel.textColor = COLOR_LABEL_BLUE;
        
        // 如果只有一个办理人员
        if (index == 1 &&  _mainmemberenabled == YES) {
            _selectedmainmemberlabel.text = text;
            _selectedmainmember = members;
            _selectedmainmemberlabel.textColor = COLOR_LABEL_BLUE;
        }else{
            //默认取办理人员的第一个为主办人
            _selectedmainmemberlabel.text = [[[text componentsSeparatedByString:@","] objectAtIndex:0] stringByAppendingString:@","];
            [_selectedmainmember addObject:[members objectAtIndex:0]];
            _selectedmainmemberlabel.textColor = COLOR_LABEL_BLUE;
        }
        
    } else {
        _selectedmainmemberlabel.text = text;
        _selectedmainmember = members;
        _selectedmainmemberlabel.textColor = COLOR_LABEL_BLUE;
    }
}

#pragma mark - 短信,阅办模块操作

- (void)doLoadingSelectorInfo  {
    UILabel *displaylabel = _selectedtabletag == 3 ? _smslabel: _readflowlabel;
    // 如果是短信通知的话, 则还需要输入输入短信内容
    UIAlertAction *sure_action   = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        displaylabel.text = @"是";
        //弹出一个填写短信内容的填写框
        if (_selectedtabletag == 3) {
            [self doDisplayTextInfoForMsm];
            _issmsremind = YES;
        } else  _isreadflow = YES;
    }];
    UIAlertAction *unsure_action = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
        displaylabel.text = @"否";
        if (_selectedtabletag == 3) _issmsremind = NO; else  _isreadflow = NO;
    }];
    [EAlertDefault alertSelectorInfoWithTitle:nil andMessage:@"请选择" andTarget:self andActions:sure_action,unsure_action, nil];
}


- (void)doDisplayTextInfoForMsm {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"短信内容" message:@"请输入短信内容" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = _smscontent;
    }];
    
    UIAlertAction *msm_action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _smscontent = alert.textFields.firstObject.text;
    }];
    [alert addAction:msm_action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 流程提交

- (void)didSubmitProcessFlow {
    
    // 前置检查
    // 1. 是否选择了流程
    if ([NSString isStringBlank:_selectedflow]) {
        [EAlertDefault alertWarningInfoWithTitle:@"系统提醒" andMessage:@"请选择转交流程" andTarget:self];
        return;
    }
    
    // 2. 是否选择了办理人
    if ([_selectedmember count] <= 0) {
        [EAlertDefault alertWarningInfoWithTitle:@"系统提醒" andMessage:@"请选择办理人" andTarget:self];
        return;
    }
    
    // 3. 是否选择了主办人
    if ([_selectedmainmember count] <= 0 && _mainmemberenabled == YES) {
        [EAlertDefault alertWarningInfoWithTitle:@"系统提醒" andMessage:@"请选择主办人" andTarget:self];
        return;
    }
    
    // 流程提交
    NSMutableDictionary *params = [self.processor createDictionaryFromProcessorForFlowSubmitProcess];
    [params setObject:[self doLoadingMembersNoStringWithMembers:_selectedmember] forKey:@"Prcs_user"]; // 加入办理人
    [params setObject:_selectedflow forKey:@"Prcs_To_Choose"];
    // 加入主办人
    if (_mainmemberenabled == YES) {
        [params setObject:[self doLoadingMembersNoStringWithMembers:_selectedmainmember] forKey:@"Prcs_op_user"];
    }else {
        [params setObject:@"" forKey:@"Prcs_op_user"];
    }
    
    // 加入短信提醒标志
    if (_issmsremind == YES) {
        [params setObject:[NSNumber zero] forKey:@"Mobile_sms_remind"];
        [params setObject:_smscontent forKey:@"RemindCotent"];
    }else {
        [params setObject:[NSNumber one] forKey:@"Mobile_sms_remind"];
        [params setObject:[NSString blank] forKey:@"RemindCotent"];
    }
    
    // 加入阅办件
    if (self.processor.is_read == YES) {
        if (_isreadflow == YES) {
            [params setObject:[NSNumber zero] forKey:@"IsReadTodo"];
        }else {
            [params setObject:[NSNumber one]  forKey:@"IsReadTodo"];
        }
    }
    [self didLoadingUserDataWithParamsNoError:params andService:SERVICE_NAME_TODO_FLOW_SUBMIT];
}

- (NSString *)doLoadingMembersNoStringWithMembers:(NSMutableArray *)members {
    
    NSEnumerator* enumerator = members.objectEnumerator;
    NSMutableString *text    = [[NSMutableString alloc]init];
    
    EAMember *value;
    while ((value            = enumerator.nextObject)) {
        [text appendString:value.user_id];
        [text appendString:@","];
    }
    [text deleteCharactersInRange:[text rangeOfComposedCharacterSequenceAtIndex:text.length-1]];
    return [NSString stringWithString:text];
}

#pragma mark - 数据回执 

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    if (name == SERVICE_NAME_TODO_MORE_HANDLER) {
        self.members = [EAMember arrangementUserDictionaryByDepartmentName:[result objectForKey:@"List"] :departKeys];
    }
    
    if (name == SERVICE_NAME_TODO_FLOW_SUBMIT) {
        UIAlertAction *canelAction = [UIAlertAction actionWithTitle:@"返回列表" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[[self.navigationController viewControllers]indexOfObject:self]-2]animated:YES];// 回到列表
        }];
        [EAlertDefault alertWarningInfoWithTitle:@"提交成功" andMessage:@"请点击返回列表" andTarget:self andAction:canelAction];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"FlowToMemberPickerSegue"]) {
        
        UINavigationController *view = segue.destinationViewController;
        [view.topViewController setValue:self forKey:@"delegate"];
        [view.topViewController setValue:self.members forKey:@"members"];
        [view.topViewController setValue:departKeys forKey:@"departKeys"];
    }
}


@end
