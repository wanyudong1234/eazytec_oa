//
//  HomeViewController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "HomeViewController.h"

#import "MyButton.h"

@interface HomeViewController ()

@property (nonatomic,retain) UIScrollView *scrollview;

@property (nonatomic,retain) NSMutableArray *notifyarray;
@property (nonatomic,retain) NSMutableArray *emailarray;

@property (nonatomic,retain) NSString *notifyno;
@property (nonatomic,retain) NSString *emailno;

@property (nonatomic,retain) MyButton *TodoBtn;
@property (nonatomic,retain) MyButton *ToReadBtn;
@property (nonatomic,retain) MyButton *ToSearchBtn;
@property (nonatomic,retain) MyButton *NoticeBtn;
@property (nonatomic,retain) MyButton *NewsBtn;
@property (nonatomic,retain) MyButton *EmailBtn;
@property (nonatomic,retain) MyButton *ThemesBtn;
@property (nonatomic,retain) MyButton *ContactBtn;
@property (nonatomic,retain) MyButton *ProfileBtn;

@property (nonatomic,retain) NSNumber *worktype;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    // 设置背景颜色
    _scrollview.backgroundColor = COLOR_LABEL_LIGHT_GRAY;
    _scrollview.delegate = self;
    _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH*3/5+SCREEN_WIDTH+HOME_DOWN_SIZE+60));
    
    UIImageView* homeBgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *3/5)];
    homeBgImg.image = [UIImage imageNamed:@"Home_Head_Bg"];
    
    [self initView];
    [_scrollview addSubview:homeBgImg];
    
    [self.view addSubview:_scrollview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = TITLE_LABLE;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:false];
}

// 首页的状态栏前景色为白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)initView{
    
    //待办工作 frame
    CGFloat todox = 0;
    CGFloat todoy = (SCREEN_WIDTH *3/5 + HOME_DOWN_SIZE);
    _TodoBtn = [[MyButton alloc] initWithButtonFrame:todox :todoy];
    [_TodoBtn setTitle:@"待办工作" forState:UIControlStateNormal];
    [_TodoBtn setImage:[UIImage imageNamed:@"Work_Todo"] forState:UIControlStateNormal];
    [_scrollview addSubview:_TodoBtn];
    [_TodoBtn setTag:0];
    [_TodoBtn addTarget:self action:@selector(onClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //待阅工作 frame
    CGFloat toReadx = (SCREEN_WIDTH/3);
    CGFloat toReady = (SCREEN_WIDTH *3/5 + HOME_DOWN_SIZE);
    _ToReadBtn = [[MyButton alloc] initWithButtonFrame:toReadx :toReady];
    [_ToReadBtn setTitle:@"待阅工作" forState:UIControlStateNormal];
    [_ToReadBtn setImage:[UIImage imageNamed:@"Work_Toread"] forState:UIControlStateNormal];
    [_scrollview addSubview:_ToReadBtn];
    [_ToReadBtn setTag:1];
    [_ToReadBtn addTarget:self action:@selector(onClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //查询工作 frame
    CGFloat toSearchx = 2*(SCREEN_WIDTH/3);
    CGFloat toSearchy = (SCREEN_WIDTH *3/5 + HOME_DOWN_SIZE);
    _ToSearchBtn = [[MyButton alloc] initWithButtonFrame:toSearchx :toSearchy];
    [_ToSearchBtn setTitle:@"工作查询" forState:UIControlStateNormal];
    [_ToSearchBtn setImage:[UIImage imageNamed:@"Work_Search"] forState:UIControlStateNormal];
    [_scrollview addSubview:_ToSearchBtn];
    [_ToSearchBtn setTag:2];
    [_ToSearchBtn addTarget:self action:@selector(onClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //通知公告 frame
    CGFloat noticex = 0;
    CGFloat noticey = (SCREEN_WIDTH *3/5)+(SCREEN_WIDTH/3) + HOME_DOWN_SIZE;
    _NoticeBtn = [[MyButton alloc] initWithButtonFrame:noticex :noticey];
    [_NoticeBtn setTitle:@"通知公告" forState:UIControlStateNormal];
    [_NoticeBtn setImage:[UIImage imageNamed:@"Work_Notice"] forState:UIControlStateNormal];
    [_scrollview addSubview:_NoticeBtn];
    [_NoticeBtn setTag:3];
    [_NoticeBtn addTarget:self action:@selector(onClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //新闻中心 frame
    CGFloat newsx = (SCREEN_WIDTH /3);
    CGFloat newsy = (SCREEN_WIDTH *3/5)+(SCREEN_WIDTH/3) + HOME_DOWN_SIZE;
    _NewsBtn = [[MyButton alloc] initWithButtonFrame:newsx :newsy];
    [_NewsBtn setTitle:@"新闻中心" forState:UIControlStateNormal];
    [_NewsBtn setImage:[UIImage imageNamed:@"Work_News"] forState:UIControlStateNormal];
    [_scrollview addSubview:_NewsBtn];
    [_NewsBtn setTag:4];
    [_NewsBtn addTarget:self action:@selector(onClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //我的邮件 frame
    CGFloat emailx = 2*(SCREEN_WIDTH/3);
    CGFloat emaily = (SCREEN_WIDTH *3/5)+(SCREEN_WIDTH/3) + HOME_DOWN_SIZE;
    _EmailBtn = [[MyButton alloc] initWithButtonFrame:emailx :emaily];
    [_EmailBtn setTitle:@"我的邮件" forState:UIControlStateNormal];
    [_EmailBtn setImage:[UIImage imageNamed:@"Work_Email"] forState:UIControlStateNormal];
    [_scrollview addSubview:_EmailBtn];
    [_EmailBtn setTag:5];
    [_EmailBtn addTarget:self action:@selector(onClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //主题动态 frame
    CGFloat themesx = 0;
    CGFloat themesy =(SCREEN_WIDTH *3/5)+2*(SCREEN_WIDTH/3) + HOME_DOWN_SIZE;
    _ThemesBtn = [[MyButton alloc] initWithButtonFrame:themesx :themesy];
    [_ThemesBtn setTitle:@"主题动态" forState:UIControlStateNormal];
    [_ThemesBtn setImage:[UIImage imageNamed:@"Work_Study"] forState:UIControlStateNormal];
    [_scrollview addSubview:_ThemesBtn];
    [_ThemesBtn setTag:6];
    [_ThemesBtn addTarget:self action:@selector(onClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //填充按钮1
    CGFloat contactx = (SCREEN_WIDTH /3);;
    CGFloat contacty =(SCREEN_WIDTH *3/5)+2*(SCREEN_WIDTH/3) + HOME_DOWN_SIZE;
    _ContactBtn = [[MyButton alloc] initWithButtonFrame:contactx :contacty];
    [_ContactBtn setTitle:@"通讯录" forState:UIControlStateNormal];
    [_ContactBtn setImage:[UIImage imageNamed:@"Work_Contact"] forState:UIControlStateNormal];
    [_scrollview addSubview:_ContactBtn];
    [_ContactBtn setTag:7];
    [_ContactBtn addTarget:self action:@selector(onClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //填充按钮2
    CGFloat profilex = 2*(SCREEN_WIDTH /3);;
    CGFloat profiley =(SCREEN_WIDTH *3/5)+2*(SCREEN_WIDTH/3) + HOME_DOWN_SIZE;
    _ProfileBtn = [[MyButton alloc] initWithButtonFrame:profilex :profiley];
    [_ProfileBtn setTitle:@"个人中心" forState:UIControlStateNormal];
    [_ProfileBtn setImage:[UIImage imageNamed:@"Work_Profile"] forState:UIControlStateNormal];
    [_scrollview addSubview:_ProfileBtn];
    [_ProfileBtn setTag:8];
    [_ProfileBtn addTarget:self action:@selector(onClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)onClickHomeBtn:(id)sender{
    int tag = (int)[sender tag];
    
    switch (tag) {
        case 0:
            _worktype = [NSNumber one];
            [self performSegueWithIdentifier:@"WorkToProcessListSegue" sender:self];
            break;
        
        case 1:
            _worktype = [NSNumber numberWithInt:3];
            [self performSegueWithIdentifier:@"WorkToProcessListSegue" sender:self];
            break;
        
        case 2:
            [self performSegueWithIdentifier:@"WorkToSearchSegue" sender:self];
            break;
        
        case 3:
            [self performSegueWithIdentifier:@"WorkToNotifyListSegue" sender:self];
            break;
            
        case 4:
            [self performSegueWithIdentifier:@"WorkToNewsListSegue" sender:self];
            break;
            
        case 5:
            [self performSegueWithIdentifier:@"WorkToEmailListSegue" sender:self];
            break;
            
        case 6:
            [self performSegueWithIdentifier:@"WorkToStudyListSegue" sender:self];
            break;
            
        case 7:
            [self performSegueWithIdentifier:@"WorkToContactListSegue" sender:self];
            break;
            
        case 8:
            [self performSegueWithIdentifier:@"WorkToProfileSegue" sender:self];
            break;
            
        default:
            break;
    }
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"WorkToProcessListSegue"]) {
        [segue.destinationViewController setValue:_worktype forKey:@"type"];
        
    }
}




@end
