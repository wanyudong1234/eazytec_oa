//
//  LoginViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/23.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeContentTableViewCell.h"
#import "JPUSHService.h"

#define TEXT_FIELD_X 10
#define TEXT_FIELD_HEGHT 45

#define NAME_FIELD_Y SCREEN_HEIGHT/2
#define PASSWORD_FIELD_Y NAME_FIELD_Y + TEXT_FIELD_HEGHT
#define TEXT_FIELD_WIDTH SCREEN_WIDTH - TEXT_FIELD_X * 2

#define NAME_FIELD_PLACEHOLD @"请输入用户名"
#define PASSWORD_FIELD_PLACEHOLD @"请输入密码"

#define BUTTON_X 30
#define BUTTON_Y PASSWORD_FIELD_Y + TEXT_FIELD_HEGHT + 30
#define BUTTON_WIDTH SCREEN_WIDTH - BUTTON_X * 2
#define BUTTON_HEIGHT 40


@interface LoginViewController ()

@property (nonatomic,retain) EAUITextField *namefield;
@property (nonatomic,retain) EAUITextField *passwordfield;

@property (nonatomic,retain) EAUIButton *loginbutton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 加载背景图片
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageview.image = [UIImage imageNamed:@"Login_Bg"];
    imageview.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageview];
    
    // 输入框: 用户名
    _namefield = [EAUITextField instanceTextField];
    _namefield.frame = CGRectMake(TEXT_FIELD_X, NAME_FIELD_Y, TEXT_FIELD_WIDTH, TEXT_FIELD_HEGHT);
    _namefield.placeholder = NAME_FIELD_PLACEHOLD;
    _namefield.delegate = self;
    [self.view addSubview:_namefield];
    
    // 输入框: 密码
    _passwordfield = [EAUITextField instanceTextField];
    _passwordfield.frame = CGRectMake(TEXT_FIELD_X, PASSWORD_FIELD_Y, TEXT_FIELD_WIDTH, TEXT_FIELD_HEGHT);
    _passwordfield.placeholder = PASSWORD_FIELD_PLACEHOLD;
    _passwordfield.delegate = self;
    [_passwordfield setSecureTextEntry:YES];
    [self.view addSubview:_passwordfield];
    
    // 登陆按钮
    _loginbutton = [EAUIButton instanceButtonWithTitle:@"登  录"];
    _loginbutton.frame = CGRectMake(BUTTON_X, BUTTON_Y, BUTTON_WIDTH, BUTTON_HEIGHT);
    [_loginbutton addTarget:self action:@selector(userWillLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginbutton];
    
    // 验证用户是否已登陆
    [self checkUserDidAutoLogin];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 首页的状态栏前景色为白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Login Button

- (void)checkUserDidAutoLogin {
    
    EAUserDefault *user = [EAUserDefault loadUserLoginHasRemember];
    if (user == nil) {
        // 没有自动登录过, 或者说用户手动退出了登陆
        return;
    }
   
    _namefield.text = user.login_id;
    _passwordfield.text = user.password;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:user.login_id forKey:@"User"];
    [dict setObject:user.password forKey:@"Password"];
    
    [self didLoadingUserDataWithParams:dict andService:SERVICE_NAME_LOGIN];
}



- (void)userWillLogin:(UIButton *)button {
    
    NSString *username = _namefield.text;
    NSString *password = _passwordfield.text;
    
    if ([NSString isStringBlank:username]) {
        [EAlertDefault alertWarningInfoWithTitle:@"登陆提醒" andMessage:@"请输入用户名" andTarget:self];
        return;
    }
    
//    if ([NSString isStringBlank:password]) {
//        [EAlertDefault alertWarningInfoWithTitle:@"登陆提醒" andMessage:@"请输入密码" andTarget:self];
//        return;
//    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:username forKey:@"User"];
    [dict setObject:password forKey:@"Password"];

    [self didLoadingUserDataWithParams:dict andService:SERVICE_NAME_LOGIN];
}

- (void)didAnalysisRequestResultWithData:(NSDictionary *)result andService:(REQUEST_SERVICE_NAME)name {
    
    //  持久化用户登录信息
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.sessionId = [result objectForKey:@"SessionId"];
    myDelegate.loginTime = [EAUserDefault getNowTime];
    myDelegate.alias = [result objectForKey:@"UserId"];
    
    // 设置推送别名
    [JPUSHService setAlias:myDelegate.alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    
    EAUserDefault *user = [[EAUserDefault alloc]initWithLoginId:_namefield.text andPassword:_passwordfield.text];
    user.login_name = [result objectForKey:@"UserName"];
    [EAUserDefault persistenceLoginUserIntoUserDefaults:user];
    [self performSegueWithIdentifier:@"LoginToMainSegue" sender:self];
}

#pragma mark - TextView

//开始编辑输入框的时候，软键盘出现，执行此事件
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect frame = textField.frame;
    int offset = frame.origin.y + KEYBOARD_RESIZE_CORRECTION - self.view.frame.size.height + KEYBOARD_HEIGHT; //键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

// 别名设置成功回调函数
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

@end
