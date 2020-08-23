//
//  BindPhoneVC.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "BindPhoneVC.h"
#import "VerifyButtonUtils.h"
#import "BassBarViewController.h"
#import "SuccessViewController.h"
@interface BindPhoneVC ()
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *yanField;
@property (nonatomic, strong) VerifyButtonUtils *verifyBtn;
@end

@implementation BindPhoneVC
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
//    [self setNavTitle:@"绑定手机号"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self createUI];
}
-(void)createUI {
    UILabel * logLable =[HttpTool createLable:BassColor(51,51,51) font:VPFont(@"PingFang-SC-Bold", height(20)) textAlignmen:NSTextAlignmentLeft text:@""];
    logLable.text = @"绑定手机号";
    [self.view addSubview:logLable];
    [logLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(30));
        make.top.mas_equalTo(self.view).offset(height(106));
        make.height.mas_equalTo(height(25));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(30));
    }];
    UILabel * phoneLable =[HttpTool createLable:BassColor(51,51,51) font:VPFont(@"PingFang-SC-Medium", height(15)) textAlignmen:NSTextAlignmentLeft text:@"手机号码"];
    [self.view addSubview:phoneLable];
    [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(18.5));
        make.top.mas_equalTo(logLable.mas_bottom).offset(height(80));
        make.width.mas_equalTo(width(100));
        make.height.mas_equalTo(height(16));
    }];
    self.phoneField=[HttpTool createField:@"请输入手机号" font:VPFont(@"PingFang-SC-Medium",height(15)) color:BassColor(51,51,51) ishidden:NO];
    self.phoneField.keyboardType=UIKeyboardTypePhonePad;
//    NSString *holder = @"请输入手机号";
//    NSMutableAttributedString *place = [[NSMutableAttributedString alloc] initWithString:holder];
//    [place addAttribute:NSForegroundColorAttributeName
//                  value:[UIColor whiteColor]
//                  range:NSMakeRange(0, holder.length)];
//    self.phoneField.attributedPlaceholder = place;
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(18.5));
        make.height.mas_equalTo(height(45));
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(phoneLable.mas_bottom).offset(height(5));
    }];
    UIView * line =[[UIView alloc]init];
    line.backgroundColor =BassColor(233, 233, 233);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(18.5));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(18.5));
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.phoneField.mas_bottom);
    }];
    UILabel * yanLable =[HttpTool createLable:BassColor(51, 51,51) font:VPFont(@"PingFang-SC-Medium", height(15)) textAlignmen:NSTextAlignmentLeft text:@"邀请码"];
    [self.view addSubview:yanLable];
    [yanLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(25));
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(height(30));
        make.width.mas_equalTo(width(100));
        make.height.mas_equalTo(height(16));
    }];
    self.yanField=[HttpTool createField:@"非邀请用户请输入20001" font:VPFont(@"PingFang-SC-Medium",height(15)) color:BassColor(51,51,51) ishidden:NO];
  //  self.yanField.keyboardType=UIKeyboardTypePhonePad;
//    NSString *holderText = @"请输入邀请码";
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
//    [placeholder addAttribute:NSForegroundColorAttributeName
//                        value:[UIColor whiteColor]
//                        range:NSMakeRange(0, holderText.length)];
//    self.yanField.attributedPlaceholder = placeholder;
    [self.view addSubview:self.yanField];
    [self.yanField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(18.5));
        make.height.mas_equalTo(height(45));
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(yanLable.mas_bottom).offset(height(5));
    }];
    UIView * line1 =[[UIView alloc]init];
    line1.backgroundColor =BassColor(233, 233, 233);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(18.5));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(18.5));
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.yanField.mas_bottom);
    }];
//    [self.view addSubview:self.verifyBtn];
//    [self.verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height(26));
//        make.width.mas_equalTo(width(81));
//        make.centerY.mas_equalTo(self.yanField.mas_centerY);
//        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
//    }];
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor = BassColor(17, 151, 255);
    [sureBtn setTitle:@"立即绑定" forState:0];
    sureBtn.titleLabel.font = VPFont(@"PingFang-SC-Medium", height(17));
    [sureBtn setTitleColor:UIColor.whiteColor forState:0];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(width(302));
        make.height.mas_equalTo(height(40));
        make.top.mas_equalTo(self.yanField.mas_bottom).offset(height(70));
    }];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = height(20);
    [sureBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    
}
- (VerifyButtonUtils *)verifyBtn {
    if (!_verifyBtn) {
        _verifyBtn = [VerifyButtonUtils buttonWithType:UIButtonTypeCustom];
        //        _verifyBtn.frame = CGRectMake(ScreenWidth - Relative(28) - Relative(81), self.verifyTextField.frame.origin.y, Relative(81), Relative(26));
        _verifyBtn.layer.masksToBounds = YES;
        _verifyBtn.layer.cornerRadius = 3;
        _verifyBtn.backgroundColor = BassColor(17, 151, 255);;
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//[UIColor colorWithHexString:@"#3A71EE"]
        _verifyBtn.titleLabel.font = [UIFont systemFontOfSize:height(15)];
        [_verifyBtn addTarget:self action:@selector(verifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyBtn;
}
//点击获取验证码
- (void)verifyBtnClick {
    
    NSString *checkPhone = [StringUtils checkPhone:self.phoneField.text];
    if (nil != checkPhone) {
        [self showToastInView:self.view message:checkPhone duration:0.8];
        return;
    }
    
    [HttpTool get:nil dic:@{@"phone":self.phoneField.text} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            
            [self.verifyBtn startCountDown:60 normalTitle:@"重新发送" countDownTitle:@"s" normalColor:[UIColor clearColor] countDownColor:[UIColor clearColor]];
            //
            //                NSInteger code = [response.result integerValue];
            //                self.verifyCode = [NSString stringWithFormat:@"%ld",(long)code];
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        } else {
            
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        }
    } faile:^(NSError * _Nonnull erroe) {
        
    }];
}

-(void)clickLoginBtn {
    NSString *checkPhone = [StringUtils checkPhone:self.phoneField.text];
    if (nil != checkPhone) {
        [self showToastInView:self.view message:checkPhone duration:0.8];
        return;
    }
    if (self.yanField.text.length==0) {
        [self showToastInView:self.view message:@"请输入邀请码" duration:0.8];
        return;
    }

    [HttpTool noHeardsPost:API_POST_register dic:@{@"openid":self.resp.openid,@"nickname":self.resp.name,@"headimg":self.resp.iconurl,@"phone":self.phoneField.text,@"invite":self.yanField.text} success:^(id  _Nonnull responce) {
      
        if ([responce[@"code"] intValue]==200) {
            [[NSUserDefaults standardUserDefaults] setObject:responce[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIWindow * window =[UIApplication sharedApplication].delegate.window;
            BassBarViewController * barVC =[[BassBarViewController alloc]init];
            window.rootViewController=barVC;
        }else{
              [self showToastInView:self.view message:responce[@"message"] duration:0.8];
//            SuccessViewController *VC =[[SuccessViewController alloc]init];
//            VC.imgName = @"shibai";
//            VC.status = @"绑定失败";
//            VC.beiZhu = @"绑定失败，请检查自己的网络以及从新绑定，感谢配合～";
//            VC.btnStr = @"确定";
//            VC.indexType=1;
//            [self.navigationController pushViewController:VC animated:YES];
           
        }
    } faile:^(NSError * _Nonnull erroe) {
        
    }];
}

@end
