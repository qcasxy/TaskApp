//
//  BassBarViewController.m
//  Vpay
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BassBarViewController.h"
#import "HomeViewController.h"
#import "TaskViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
@interface BassBarViewController ()
@property(nonatomic,assign)NSInteger  type;
@end

@implementation BassBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setBarTintColor:BassColor(241, 241,241)];
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setBarTintColor:BassColor(255, 255,255)];
    HomeViewController * homeVC = [[HomeViewController alloc]init];
    [self addChildViewController:homeVC  normalImg:@"shouye" seleImg:@"shouyexuan" title:@"首页"];
    TaskViewController * taskVC = [[TaskViewController alloc]init];
    [self addChildViewController:taskVC  normalImg:@"renwu3" seleImg:@"renwuxuan" title:@"任务大厅"];
    MessageViewController * messageVC = [[MessageViewController alloc]init];
    [self addChildViewController:messageVC  normalImg:@"xiaoxi12" seleImg:@"xiaoxixuan" title:@"消息"];
    MineViewController * mineVC = [[MineViewController alloc]init];
    [self addChildViewController:mineVC normalImg:@"wodewei" seleImg:@"wodexuan" title:@"我的"];
    
}
-(void)setIndesType:(NSInteger)indesType{
    
}
-(void)addChildViewController:(UIViewController*)childController normalImg:(NSString*)normalImg seleImg:(NSString*)seleImg title:(NSString*)title{
    childController.tabBarItem.image = [[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:seleImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController * bassNav = [[UINavigationController alloc]initWithRootViewController:childController];
    bassNav.tabBarItem.title = title;
    
    [bassNav.navigationBar setBarTintColor: BassColor(255,255, 255)];//BassColor(6, 19, 28)
    bassNav.navigationBar.translucent = NO;
    [bassNav.navigationBar setBackgroundImage:[[UIImage alloc] init]forBarMetrics:UIBarMetricsDefault];
    [bassNav.navigationBar setShadowImage:[[UIImage alloc] init]];
    [bassNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:BassColor(142, 142, 147)} forState:UIControlStateNormal];
    [bassNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:BassColor(0, 138, 255)} forState:UIControlStateSelected];
    [self addChildViewController:bassNav];
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
