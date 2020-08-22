
//
//  TiXianViewController.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "TiXianViewController.h"
#import "UIButton+LXMImagePosition.h"
@interface TiXianViewController ()
@property(nonatomic,strong)UITextField * moneyField;
@property(nonatomic,strong)UILabel * moneyLable;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString *aliAccount;
@property(nonatomic,copy)NSString *aliName;

@property(nonatomic,strong)UIView   *croveView2;
@property(nonatomic,strong)UILabel  *aliAccountLbl;
@property(nonatomic,strong)UILabel  *aliNameLbl;
@end

@implementation TiXianViewController
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    self.type=@"0";
    [super viewDidLoad];
    [self setNavTitle:@"提现"];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self createView];
    // Do any additional setup after loading the view.
}
-(void)createView{
    UIView * line =[[UIView alloc]init];
    line.backgroundColor =BassColor(248, 248, 248);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(height(15));
    }];
    UILabel * tilable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Medium", 18) textAlignmen:NSTextAlignmentLeft text:@"提现金额"];
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
    [sureBtn setTitle:@"全部提现" forState:0];
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
    
    self.moneyLable =[HttpTool createLable:BassColor(166, 166, 166) font:VPFont(@"PingFangSC-Regular", 11) textAlignmen:NSTextAlignmentLeft text:[NSString stringWithFormat:@"当前剩余可提现金额¥%@",self.money]];
    
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
    UILabel * xuanlable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Medium", 18) textAlignmen:NSTextAlignmentLeft text:@"选择提现账户"];
    [self.view addSubview:xuanlable];
    [xuanlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.height.mas_equalTo(height(18));
        make.width.mas_equalTo(width(110));
        make.top.mas_equalTo(line1.mas_bottom).offset(height(20));
    }];


    UIView  *croveView1 = [[UIView alloc]init];
    [self.view addSubview:croveView1];
    [croveView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(xuanlable.mas_bottom).offset(20);
        make.height.mas_equalTo(45);
    }];

    CGFloat spacing = 10;
    UIButton *zhiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhiBtn setTitle:@"支付宝" forState:0];
    zhiBtn.backgroundColor = UIColor.whiteColor;
    [zhiBtn setTitleColor:BassColor(0, 0,0) forState:0];
    [zhiBtn setImage:[UIImage imageNamed:@"zhifubaoxin"] forState:0];
    [croveView1 addSubview:zhiBtn];
    [zhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(croveView1);
    }];
    zhiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
    zhiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
    
    zhiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
    zhiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
    
    [zhiBtn setImagePosition:LXMImagePositionLeft spacing:spacing];
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor =[UIColor whiteColor];
    [rightBtn setImage:[UIImage imageNamed:@"weixian"] forState:0];
    [croveView1 addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.centerY.mas_equalTo(zhiBtn.mas_centerY);
    }];
    UIView * line3 =[[UIView alloc]init];
    line3.backgroundColor =BassColor(248, 248, 248);
    [croveView1 addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(croveView1);
        make.height.mas_equalTo(1);
    }];

    self.croveView2 = [[UIView alloc]init];
    [self.view addSubview:self.croveView2];
    UITapGestureRecognizer  *tapRegister = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bindAliAccount)];
    [self.croveView2 addGestureRecognizer:tapRegister];

    self.aliAccountLbl = [HttpTool createLable:BassColor(51, 51, 51) font:[UIFont systemFontOfSize:15] textAlignmen:NSTextAlignmentLeft text:@""];
    [self.croveView2 addSubview:self.aliAccountLbl];
    [self.aliAccountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.croveView2);
        make.left.mas_equalTo(15);
    }];

    self.aliNameLbl = [HttpTool createLable:BassColor(51, 51, 51) font:[UIFont systemFontOfSize:15] textAlignmen:NSTextAlignmentLeft text:@""];
    [self.croveView2 addSubview:self.aliNameLbl];
    [self.aliNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.croveView2);
        make.left.equalTo(self.aliAccountLbl.mas_right).offset(10);
    }];

    UIView * line5 =[[UIView alloc]init];
    line5.backgroundColor =BassColor(248, 248, 248);
    [self.croveView2 addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.croveView2);
        make.height.mas_equalTo(1);
    }];

    CGFloat  croveView2Height = 0.0;
    self.aliAccount = [[NSUserDefaults standardUserDefaults] objectForKey:@"aliAccount"];
    self.aliName = [[NSUserDefaults standardUserDefaults] objectForKey:@"aliName"];
    if (self.aliAccount.length > 0) {
        croveView2Height = 45;
        self.aliAccountLbl.text = self.aliAccount;
        self.aliNameLbl.text = self.aliName;
    }
    [self.croveView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(croveView1.mas_bottom);
        make.height.mas_equalTo(croveView2Height);
    }];


    UIView  *croveView3 = [[UIView alloc]init];
    [self.view addSubview:croveView3];
    [croveView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.croveView2.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    UIButton *weiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiBtn setTitle:@"微信" forState:0];
    weiBtn.backgroundColor = UIColor.whiteColor;
    [weiBtn setTitleColor:BassColor(0, 0,0) forState:0];
    [weiBtn setImage:[UIImage imageNamed:@"weixin"] forState:0];
    [croveView3 addSubview:weiBtn];
    [weiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(croveView3);
    }];
    weiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
    weiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
    
    weiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
    weiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
    [weiBtn setImagePosition:LXMImagePositionLeft spacing:spacing];

    UIButton * rightBtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.backgroundColor =[UIColor whiteColor];
    [rightBtn1 setImage:[UIImage imageNamed:@"weixian"] forState:0];
    [croveView3 addSubview:rightBtn1];
    [rightBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.centerY.equalTo(weiBtn.mas_centerY);
    }];
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.type=@"1";
        [rightBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:0];
        [rightBtn1 setImage:[UIImage imageNamed:@"weixian"] forState:0];
    }];
    [[rightBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.type=@"2";
        [rightBtn setImage:[UIImage imageNamed:@"weixian"] forState:0];
        [rightBtn1 setImage:[UIImage imageNamed:@"xuanzhong"] forState:0];
        
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
        make.top.equalTo(croveView3.mas_bottom).offset(height(25));
    }];
    tiBtn.layer.masksToBounds = YES;
    tiBtn.layer.cornerRadius = height(17);
    [tiBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
}
-(void)clickLoginBtn{
    if (self.moneyField.text.length==0) {
        [self showToastInView:self.view message:@"请输入金额" duration:0.8];
        return;
    }
    if (self.type.length==0) {
        [self showToastInView:self.view message:@"请选择要提现的账户类型" duration:0.8];
        return;
    }
    if ([self.type isEqualToString:@"1"]) {//支付宝
        if (self.aliAccount.length == 0) {//绑定支付宝
            [self bindAliAccount];
        }else{
            [HttpTool post:API_POST_withdraw dic:@{@"type":self.type,@"price":self.moneyField.text} success:^(id  _Nonnull responce) {
                if ([responce[@"code"] intValue]==200) {
                    [self showToastInView:self.view message:responce[@"message"] duration:0.8];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                   [self showToastInView:self.view message:responce[@"message"] duration:0.8];

                }
            } faile:^(NSError * _Nonnull erroe) {

            }];
        }
    }else{//微信
        [HttpTool post:API_POST_withdraw dic:@{@"type":self.type,@"price":self.moneyField.text} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                [self showToastInView:self.view message:responce[@"message"] duration:0.8];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
               [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            }
        } faile:^(NSError * _Nonnull erroe) {
            
        }];
    }
}
//绑定支付宝
-(void)bindAliAccount{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"绑定支付宝" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.aliAccount.length == 0) {
            [self showToastInView:self.view message:@"请输入支付宝账号" duration:0.8];
            return;
        }
        if (self.aliName.length == 0) {
            [self showToastInView:self.view message:@"请输入名称" duration:0.8];
            return;
        }
        [HttpTool post:API_POST_bindAlipay dic:@{@"account":self.aliAccount,@"username":self.aliName} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                [self.croveView2 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(45);
                }];
                self.aliAccountLbl.text = self.aliAccount;
                self.aliNameLbl.text = self.aliName;
                [[NSUserDefaults standardUserDefaults] setObject:self.aliAccount forKey:@"aliAccount"];
                [[NSUserDefaults standardUserDefaults] setObject:self.aliName forKey:@"aliName"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
            }
        } faile:^(NSError * _Nonnull erroe) {

        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入支付宝账号";
        textField.text = self.aliAccount;
        [[textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            self.aliAccount = x;
        }];
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"支付宝姓名";
        textField.text = self.aliName;
        [[textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            self.aliName = x;
        }];
    }];
    [alert addAction:conform];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
