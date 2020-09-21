//
//  ZRYViewController.m
//  taskApp
//
//  Created by per on 2019/11/15.
//  Copyright © 2019 per. All rights reserved.
//

#import "ZRYViewController.h"

@interface ZRYViewController ()
@property(nonatomic,strong)UITextField * moneyField;
@property(nonatomic,strong)UILabel * moneyLable;
@end

@implementation ZRYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle:@"转入余额"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    
    UIView * line =[[UIView alloc]init];
    line.backgroundColor =BassColor(248, 248, 248);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(height(15));
    }];
    UILabel * tilable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Medium", 18) textAlignmen:NSTextAlignmentLeft text:@"转入钱包"];
    [self.view addSubview:tilable];
    [tilable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.height.mas_equalTo(height(18));
        make.width.mas_equalTo(width(110));
        make.top.mas_equalTo(line.mas_bottom).offset(height(20));
    }];
    self.moneyField =[HttpTool createField:@"请输入提现金额" font:VPFont(@"PingFangSC-Medium", 16) color:BassColor(51, 51, 51) name:@"￥" ishidden:NO foalt:width(30)];
    [self.view addSubview:self.moneyField];
    [self.moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.top.mas_equalTo(tilable.mas_bottom).offset(height(27));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(80));
        make.height.mas_equalTo(height(45));
    }];
    UIView * line2 =[[UIView alloc]init];
    line2.backgroundColor =BassColor(240, 240, 240);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.moneyField.mas_bottom).offset(height(4));
        make.height.mas_equalTo(2);
    }];
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"全部转入" forState:0];
    [sureBtn setTitleColor:BassColor(17, 151, 255) forState:0];
    sureBtn.backgroundColor =[UIColor whiteColor];
    sureBtn.titleLabel.font = VFont;
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-width(10));
        make.centerY.mas_equalTo(self.moneyField.mas_centerY);
        make.width.mas_equalTo(width(70));
        make.height.mas_equalTo(height(20));
    }];
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.moneyField.text = self.money;
    }];
    
    self.moneyLable =[HttpTool createLable:BassColor(166, 166, 166) font:VPFont(@"PingFangSC-Regular", 11) textAlignmen:NSTextAlignmentLeft text:[NSString stringWithFormat:@"当前剩余可转入佣金¥%@",self.money]];
    
    [self.view addSubview:self.moneyLable];
    [self.moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.top.mas_equalTo(self.moneyField.mas_bottom).offset(height(17));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(80));
        make.height.mas_equalTo(height(45));
    }];
    UIView * line1 =[[UIView alloc]init];
    line1.backgroundColor =BassColor(248, 248, 248);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.moneyLable.mas_bottom).offset(height(15));
        make.height.mas_equalTo(height(15));
    }];
    
    UIButton * tiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    tiBtn.backgroundColor = BassColor(17, 151, 255);
    [tiBtn setTitle:@"提 交" forState:0];
    tiBtn.titleLabel.font = VPFont(@"PingFang-SC-Medium", height(17));
    [tiBtn setTitleColor:UIColor.whiteColor forState:0];
    [self.view addSubview:tiBtn];
    [tiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(width(302));
        make.height.mas_equalTo(height(34));
        make.top.mas_equalTo(line1.mas_bottom).offset(height(25));
    }];
    tiBtn.layer.masksToBounds = YES;
    tiBtn.layer.cornerRadius = height(17);
    [tiBtn addTarget:self action:@selector(clickTiBtn) forControlEvents:UIControlEventTouchUpInside];
}
-(void)clickTiBtn{
    if (self.moneyField.text.length==0) {
        [self showToastInView:self.view message:@"请输入金额" duration:0.8];
        return;
    }
    [HttpTool post:API_POST_brokeragePrice dic:@{@"price":self.moneyField.text} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            self.moneyLable.text =[NSString stringWithFormat:@"当前剩余可提现金额¥%0.2f",([self.money floatValue] - [self.moneyField.text floatValue])];
            self.moneyField.text=@"";
            
            
        }else{
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
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
