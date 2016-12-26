//
//  SearchDetailViewController.m
//  YXLibraryOA
//
//  Created by eazytec on 16/1/12.
//  Copyright © 2016年 Eazytec. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "SearchContentTableViewCell.h"

@interface SearchDetailViewController ()

@property (nonatomic,retain) EAUITableView *tableview;

@property (nonatomic,retain) NSArray  *attachments;
@property (nonatomic,retain) NSString *attachmenturl;

@property (nonatomic,retain) NSMutableDictionary *detailresult;

@end

@implementation SearchDetailViewController

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
    
    self.navigationItem.title = @"工作详情";
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
    
    _detailresult = [[NSMutableDictionary alloc]init];
    _attachments = [[NSArray alloc]init];
    [self didLoadingUserDataWithParamsNoError:[self.processor createDictionaryFromProcessorForRequest] andService:SERVICE_NAME_PROCESS_LIST_DETAIL];
}


- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    
        self.attachments          = [result objectForKey:@"AttachmentList"];//设置附件列表
        self.processor.op_flag    = [result objectForKey:@"OP_flag"];//设置主办人标志
        self.processor.title      = [result objectForKey:@"Title"];//设置标题
        
        [self.processor setProcessContentAnalysisWithRequest:[result objectForKey:@"FormList"]];
        [_tableview reloadData];
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
        SearchContentTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"SearchContentTableViewCell"];
        if (cell == nil) {
            cell = [[SearchContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchContentTableViewCell"];
        }
        [cell setTextHeight:[display objectForKey:@"ElementValue"]];
        return cell;
        
    } else {
        // 附件
        UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"SearchDetailAttachTableViewCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchDetailAttachTableViewCell"];
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
        
        [self performSegueWithIdentifier:@"SearchToAttachSegue" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section < [[self.processor getProcessContentForDisplay] count]) {
        
        NSMutableDictionary *display   = [self.processor getProcessContentForDisplay][indexPath.section];
        NSString *detailText = [display objectForKey:@"ElementValue"];
        NSDictionary *detailTextSizeAttirbute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        CGSize detailTextSize = [detailText boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30 , ELEMENT_HEIGHT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes:detailTextSizeAttirbute context:nil].size;
        return detailTextSize.height + 20;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SearchToAttachSegue"]) {
        [segue.destinationViewController setValue:self.attachmenturl forKey:@"attachmenturl"];
    }
}


@end
