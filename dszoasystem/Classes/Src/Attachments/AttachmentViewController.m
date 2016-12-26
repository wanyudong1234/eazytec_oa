//
//  AttachmentViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/28.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "AttachmentViewController.h"

@interface AttachmentViewController ()

@property (nonatomic,retain) UIWebView *webview;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicator;

@end

@implementation AttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_CONTENT_HEIGHT)];
    _webview.scalesPageToFit = YES;
    _webview.delegate = self;
    [self.view addSubview:_webview];
    
    // 自定义后退按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Common_Back"] style:UIBarButtonItemStylePlain target:self action:@selector(doNavigationLeftBarButtonItemAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
     self.navigationItem.title = @"附件查看";
    
    // 判断文件类型
    if ([self.attachmenturl hasSuffix:@".doc"]  || [self.attachmenturl hasSuffix:@".DOC"] ||
        [self.attachmenturl hasSuffix:@".docx"] || [self.attachmenturl hasSuffix:@".DOCX"]||
        [self.attachmenturl hasSuffix:@".pdf"]  || [self.attachmenturl hasSuffix:@".PDF"] ||
        [self.attachmenturl hasSuffix:@".xlsx"] || [self.attachmenturl hasSuffix:@".XLSX"]||
        [self.attachmenturl hasSuffix:@".xls"]  || [self.attachmenturl hasSuffix:@".XLS"] ||
        [self.attachmenturl hasSuffix:@".txt"]  || [self.attachmenturl hasSuffix:@".TXT"]) {
       
        // 在线加载文档
        NSURL *url            = [NSURL URLWithString:[self.attachmenturl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request]; // 清除缓存
        [self.webview loadRequest:request];
    } else {
        [EAlertDefault alertWarningInfoWithTitle:@"系统提示" andMessage:@"该文件类型不支持在线查看" andTarget:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

// 返回上一页
- (void)doNavigationLeftBarButtonItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 获取指定URL的MIMEType类型

- (NSString *)mimeType:(NSURL *)url {
    //1NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //2NSURLConnection
    
    //3 在NSURLResponse里，服务器告诉浏览器用什么方式打开文件。
    //使用同步方法后去MIMEType
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

#pragma mark - Web view setting

- (void)webViewDidStartLoad:(UIWebView *)webView {
   [MMProgressHUD showWithTitle:@"系统加载中,可能因文件较大加载速度稍慢,请稍后..."];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
   [MMProgressHUD dismiss];
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
