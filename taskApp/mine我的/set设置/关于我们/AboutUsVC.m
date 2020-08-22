//
//  AboutUsVC.m
//  taskApp
//
//  Created by per on 2019/11/15.
//  Copyright © 2019 per. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setNavTitle:@"关于我们"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    UIImageView * logoImg =[[UIImageView alloc]init];
    logoImg.image =[UIImage imageNamed:@"120"];
    [self.view addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view).offset(height(139));
        make.width.mas_equalTo(width(125));
        make.height.mas_equalTo(width(125));
    }];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]);
    UILabel * numlanle =[[UILabel alloc]init];
    numlanle.textColor = BassColor(153, 153, 153);
    numlanle.font = VFont;
    numlanle.textAlignment = NSTextAlignmentCenter;
    numlanle.text =[NSString stringWithFormat:@"版本号:%@",  [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [self.view addSubview:numlanle];
    [numlanle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(height(18));
        make.width.mas_equalTo(width(200));
        make.top.mas_equalTo(logoImg.mas_bottom).offset(height(25));
    }];
    
    
    // Do any additional setup after loading the view.
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
