//
//  EAUIViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAUIViewController.h"
#import "LoginViewController.h"

@interface EAUIViewController ()

@property (nonatomic, retain) LoginViewController *controller;
@property (nonatomic, retain) AppDelegate *appdelegate;

@end

@implementation EAUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Root_Iphone" bundle:nil];
    _controller = [storyboard instantiateInitialViewController];
    _appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 服务交互

- (void)didLoadingUserDataWithParams:(NSMutableDictionary *)params andService:(REQUEST_SERVICE_NAME)name {
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleNone];
    [MMProgressHUD showWithTitle:@"系统处理中,请稍后..."];
    
    AFHTTPRequestOperationManager *manager = [EAProtocolDefault createAsynManageRequest];
    // 包装请求参数
    NSMutableDictionary *dict              = [EAProtocolDefault doPackingLoginUserServiceParams:params];
    [manager GET:[EAProtocolDefault loadRequestServiceUrlWithName:name] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result                   = [EAProtocolDefault doRequestJSONSerializationdDecode:operation];
        if([EAProtocolDefault isRequestJSONSerializationSuccess:result]){
            // 新增判断session失效代码
            NSNumber *code = [result objectForKey:@"Code"];
            if([code intValue] == 2){
                _appdelegate.window.rootViewController = _controller;
            }else{
                [self didAnalysisRequestResultWithData:result andService:name];
                [MMProgressHUD dismiss];
            }
        }else {
            // 这里暂时也是网络错误
            [MMProgressHUD updateTitle:@"处理失败" status:nil];
            [MMProgressHUD dismissWithError:[result objectForKey:@"ErrorMsg"] afterDelay:1.0]; //防止恶意登陆
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD updateTitle:@"处理失败" status:nil];
        [MMProgressHUD dismissWithError:@"请检查网络设置是否正确" afterDelay:1.0]; //防止恶意登陆
    }];
}


- (void)didLoadingUserDataWithParamsNoError:(NSMutableDictionary *)params andService:(REQUEST_SERVICE_NAME)name {
    
    [MMProgressHUD showWithTitle:@"系统处理中,请稍后..."];
    
    AFHTTPRequestOperationManager *manager = [EAProtocolDefault createAsynManageRequest];
    // 包装请求参数
    NSMutableDictionary *dict              = [EAProtocolDefault doPackingLoginUserServiceParams:params];
    [manager GET:[EAProtocolDefault loadRequestServiceUrlWithName:name] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result                   = [EAProtocolDefault doRequestJSONSerializationdDecode:operation];
        if([EAProtocolDefault isRequestJSONSerializationSuccess:result]){
            // 新增判断session失效代码
            NSNumber *code = [result objectForKey:@"Code"];
            if([code intValue] == 2){
                _appdelegate.window.rootViewController = _controller;
            }else{
                [self didAnalysisRequestResultWithData:result andService:name];
                [MMProgressHUD dismissAfterDelay:0.2];
            }
        }else {
            // 这里暂时也是网络错误
            [MMProgressHUD dismissAfterDelay:0.2];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD updateTitle:@"处理失败" status:nil];
        [MMProgressHUD dismissWithError:@"请检查网络设置是否正确" afterDelay:1.0]; //防止恶意登陆
    }];
}


- (void)didSyncLoadingUserDataWithParamsNoError:(NSMutableDictionary *)params andService:(REQUEST_SERVICE_NAME)name {
    [MMProgressHUD showWithTitle:@"系统处理中,请稍后..."];
    
    AFJSONRequestSerializer *requestSerializer   = [AFJSONRequestSerializer serializer];
    
    NSMutableURLRequest *request =[requestSerializer requestWithMethod:@"GET" URLString:[EAProtocolDefault loadRequestServiceUrlWithName:name] parameters:params error:nil];
    AFHTTPRequestOperation *requestOperation     = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [requestOperation setResponseSerializer:responseSerializer];
    [requestOperation start];
    [requestOperation waitUntilFinished];
    
    NSString *result_request = [NSString stringWithString:requestOperation.responseString];
    NSData *data             = [[NSData alloc]initWithData:[result_request dataUsingEncoding:NSUTF8StringEncoding]];
    NSDictionary *result     = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    if([EAProtocolDefault isRequestJSONSerializationSuccess:result]){
        // 新增判断session失效代码
        NSNumber *code = [result objectForKey:@"Code"];
        if([code intValue] == 2){
            _appdelegate.window.rootViewController = _controller;
        }else{
            [self didAnalysisRequestResultWithData:result andService:name];
            [MMProgressHUD dismissAfterDelay:0.2];
        }
    }else {
        // 这里暂时也是网络错误
        [MMProgressHUD dismissAfterDelay:0.2];
    }
}


- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    // 待子类实现
}

@end
