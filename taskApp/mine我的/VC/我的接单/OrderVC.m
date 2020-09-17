
//
//  OrderVC.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "OrderVC.h"
#import "JohnTopTitleView.h"
#import "DFSegmentView.h"
#import "OrderAllVC.h"

@interface OrderVC ()
@property (nonatomic,strong) JohnTopTitleView *titleView;
@end

@implementation OrderVC

-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTitle:@"我的接单"];
    self.view.backgroundColor = BassColor(241, 241, 241);
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self createUI];
}

- (void)createUI{
    NSArray *titleArray = [NSArray arrayWithObjects:@"全部",@"待提交",@"审核中",@"不合格",@"已完成",nil];
    self.titleView.A = _typeIndex;
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
}

- (NSArray <UIViewController *>*)setChildVC{
    return @[[[OrderAllVC alloc] initType:1],
             [[OrderAllVC alloc] initType:2],
             [[OrderAllVC alloc] initType:3],
             [[OrderAllVC alloc] initType:4],
             [[OrderAllVC alloc] initType:5]];
}

#pragma mark - getter
- (JohnTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _titleView;
}

@end
