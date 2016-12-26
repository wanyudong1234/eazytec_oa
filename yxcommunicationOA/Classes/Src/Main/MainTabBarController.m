//
//  MainTabBarController.m
//  YXTourismOA
//
//  Created by eazytec on 15/12/24.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    UITabBarItem *item_home     = [self.tabBar.items objectAtIndex:0];
    item_home.selectedImage     = [[UIImage imageNamed:@"Tab_Home_On"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item_home.image             = [[UIImage imageNamed:@"Tab_Home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    UITabBarItem *item_work     = [self.tabBar.items objectAtIndex:1];
    item_work.selectedImage     = [[UIImage imageNamed:@"Tab_Work_On"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item_work.image             = [[UIImage imageNamed:@"Tab_Work"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    UITabBarItem *item_contact     = [self.tabBar.items objectAtIndex:2];
    item_contact.selectedImage     = [[UIImage imageNamed:@"Tab_Contact_On"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item_contact.image             = [[UIImage imageNamed:@"Tab_Contact"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    UITabBarItem *item_setting     = [self.tabBar.items objectAtIndex:3];
    item_setting.selectedImage     = [[UIImage imageNamed:@"Tab_Setting_On"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item_setting.image             = [[UIImage imageNamed:@"Tab_Setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
