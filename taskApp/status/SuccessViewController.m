//
//  SuccessViewController.m
//  taskApp
//
//  Created by per on 2019/11/14.
//  Copyright © 2019 per. All rights reserved.
//

#import "SuccessViewController.h"
#import "LoginViewController.h"
#import "MineViewController.h"
#import "TaskViewController.h"
#import "HomeViewController.h"
#import "OrderVC.h"
#import "XinVipVC.h"
@interface SuccessViewController ()

@end

@implementation SuccessViewController

-(void)clickBtn {
    if (self.indexType == 1) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[LoginViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
    }else if(self.indexType == 2) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MineViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
    }else if(self.indexType == 3) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[TaskViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
    }else if(self.indexType == 4) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[OrderVC class]]) {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
    }else if(self.indexType == 5) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[HomeViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
    }else if(self.indexType == 6) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[XinVipVC class]]) {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
    }
    [self.navigationController popToRootViewControllerAnimated: YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setNavTitle:self.status];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    // Do any additional setup after loading the view.
    UIImageView * img =[[UIImageView alloc]init];
    img.image =[UIImage imageNamed:self.imgName];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view).offset(height(80));
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    UILabel * nameLabel =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", height(18)) textAlignmen:NSTextAlignmentCenter text:self.status];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(height(18));
        make.width.mas_equalTo(width(130));
        make.top.mas_equalTo(img.mas_bottom).offset(height(25));
    }];
    UILabel * beiLabel =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", height(12)) textAlignmen:NSTextAlignmentCenter text:self.beiZhu];
    beiLabel.numberOfLines=2;
    [self.view addSubview:beiLabel];
    [beiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(height(45));
        make.width.mas_equalTo(width(180));
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(height(15));
    }];
    UIButton*sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:self.btnStr forState:0];
    sureBtn.backgroundColor =BassColor(28, 146, 255);
    [sureBtn setTitleColor:BassColor(255, 255,255) forState:0];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(width(280));
        make.top.mas_equalTo(beiLabel.mas_bottom).offset(height(60));
    }];
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self clickBtn];
    }];
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
