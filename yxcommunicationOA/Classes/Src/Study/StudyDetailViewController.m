//
//  StudyDetailViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/28.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "StudyDetailViewController.h"
#import "StudyContentTableViewCell.h"

@interface StudyDetailViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

@property (nonatomic,retain) NSString *titleofstudy;
@property (nonatomic,retain) NSString *contentofstudy;
@property (nonatomic,retain) NSString *timeofstudy;
@property (nonatomic,retain) NSString *workerofstudy;

@property (nonatomic,retain) NSArray  *attachmentsofstudy;
@property (nonatomic,retain) NSString *attachmenturl;

@end

@implementation StudyDetailViewController

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
    
    self.navigationItem.title = @"主题动态";
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
    [dict setObject:self.studyno forKey:TABLE_PARMS_ID];
    
    [self didLoadingUserDataWithParamsNoError:dict andService:SERVICE_NAME_STUDY_DETAIL];
}

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    // 常规属性
    _titleofstudy = [result objectForKey:@"Title"];
    _contentofstudy = [result objectForKey:@"Content"];
    _timeofstudy = [result objectForKey:@"Time"];
    _workerofstudy = [result objectForKey:@"PublisherName"];
    
    // 其他属性
    _attachmentsofstudy = [result objectForKey:@"AttachmentList"];
    [_tableview reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([NSArray isArrayNull:_attachmentsofstudy]) {
        return 2;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 1;
    } else {
        if([NSArray isArrayNull:_attachmentsofstudy]) {
            return 0;
        }
        return _attachmentsofstudy.count;
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
        UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"StudyDetailCommonTableViewCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"StudyDetailCommonTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"主题";
            cell.detailTextLabel.text = _titleofstudy;
        } else if(indexPath.row == 1) {
            cell.textLabel.text = @"发布人";
            cell.detailTextLabel.text = _workerofstudy;
        } else {
            cell.textLabel.text = @"发布日期";
            cell.detailTextLabel.text = _timeofstudy;
        }
        return cell;
    } else if (indexPath.section == 1) {
        StudyContentTableViewCell *cell = [[StudyContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StudyContentTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.webview loadHTMLString:_contentofstudy baseURL:nil];
        return cell;     
    } else if (indexPath.section == 2) {
        UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"StudyDetailAttachTableViewCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StudyDetailAttachTableViewCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"Setting_name"];
        
        NSDictionary *attachments = _attachmentsofstudy[indexPath.row];
        cell.textLabel.text = [attachments objectForKey:@"AttachmentName"];
        return cell;
    }
    return nil;
}

// 点击跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 2) {
        
        NSDictionary *attachments = _attachmentsofstudy[indexPath.row];
        _attachmenturl = [attachments objectForKey:@"AttachmentUrl"];
        
        [self performSegueWithIdentifier:@"StudyToAttachSegue" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 2) {
        return 40;
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
    [segue.destinationViewController setValue:self.attachmenturl forKey:@"attachmenturl"];
}

@end
