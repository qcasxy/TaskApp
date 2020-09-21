

//
//  LoginViewController.m
//  taskApp
//
//  Created by 二恒 on 2019/11/7.
//  Copyright © 2019 per. All rights reserved.
//

#import "LoginViewController.h"
#import "UIButton+LXMImagePosition.h"
#import "BassBarViewController.h"
#import <UMShare/UMShare.h>
#import "BindPhoneVC.h"
#import "WebXieViewController.h"
#import "VerifyButtonUtils.h"
#import "PasswordViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UITextField *inviteField;
@property (nonatomic, strong) VerifyButtonUtils *verifyBtn;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, assign) BOOL isPassword;

@property(nonatomic,strong)UIButton * wechatLoginBtn;
@property(nonatomic,strong)UILabel * descLab;
@property(nonatomic,strong)UMSocialUserInfoResponse *resp;

@end

@implementation LoginViewController



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self isHidden];
    if (self.msg.length>0) {
        [self showToastInView:self.view message:self.msg duration:0.8];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIImageView * backImg =[[UIImageView alloc] init];
    backImg.image =[UIImage imageNamed:@"logoBack"];
    [self.view addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIImageView * logoImg =[[UIImageView alloc] init];
    logoImg.image =[UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view).offset(height(40.0) + NavHeight);
        make.height.mas_equalTo(150);
        make.width.mas_equalTo(logoImg.mas_height).multipliedBy(340.0 / 313.0);
    }];
    
    self.phoneField = [HttpTool createField:@"请输入手机号" font:[UIFont systemFontOfSize:height(15)] color:BassColor(233, 233, 233) ishidden:NO];
    self.phoneField.layer.borderColor = [BassColor(233, 233, 233) CGColor];
    self.phoneField.layer.borderWidth = 1.0;
    self.phoneField.layer.cornerRadius = 4.0;
    self.phoneField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes: @{NSForegroundColorAttributeName : BassColor(233, 233, 233)}];
    self.phoneField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width(10.0), height(44.0))];
    self.phoneField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).inset(width(34.0));
        make.height.mas_equalTo(height(34.0));
        make.top.mas_equalTo(logoImg.mas_bottom).offset(height(40));
    }];
    
    [self.view addSubview:self.verifyBtn];
    [self.verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.mas_equalTo(self.phoneField);
        make.width.mas_equalTo(width(120.0));
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(height(20));
    }];
    
    self.codeField = [HttpTool createField:@"请输入验证码" font:[UIFont systemFontOfSize:height(15)] color:BassColor(233, 233, 233) ishidden:NO];
    self.codeField.layer.borderColor = [BassColor(233, 233, 233) CGColor];
    self.codeField.layer.borderWidth = 1.0;
    self.codeField.layer.cornerRadius = 4.0;
    self.codeField.keyboardType = UIKeyboardTypePhonePad;
    self.codeField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes: @{NSForegroundColorAttributeName : BassColor(233, 233, 233)}];
    self.codeField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width(10.0), height(44.0))];
    self.codeField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.codeField];
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.mas_equalTo(self.phoneField);
        make.right.mas_equalTo(self.verifyBtn.mas_left).offset(width(-15.0));
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(height(20));
    }];
    
    self.inviteField = [HttpTool createField:@"请输入邀请码（非必填）" font:[UIFont systemFontOfSize:height(15)] color:BassColor(51,51,51) ishidden: YES];
    [self.inviteField setAlpha: 0.0];
    self.inviteField.layer.borderColor = [BassColor(233, 233, 233) CGColor];
    self.inviteField.layer.borderWidth = 1.0;
    self.inviteField.layer.cornerRadius = 4.0;
    self.inviteField.keyboardType = UIKeyboardTypePhonePad;
    self.inviteField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"非邀请用户请输入20001" attributes: @{NSForegroundColorAttributeName : BassColor(233, 233, 233)}];
    self.inviteField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width(10.0), height(44.0))];
    self.inviteField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.inviteField];
    [self.inviteField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.phoneField);
        make.top.mas_equalTo(self.codeField.mas_bottom).offset(height(20));
    }];

    self.loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.backgroundColor = BassColor(17, 151, 255);
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:height(17.0) weight:UIFontWeightMedium];
    [self.loginBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = height(4);
    [self.loginBtn addTarget: self action: @selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.phoneField);
        make.height.mas_equalTo(height(44.0));
        make.top.mas_equalTo(self.codeField.mas_bottom).offset(height(35.0));
    }];
    
    self.leftButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:height(15.0)];
    self.leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.leftButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.leftButton addTarget: self action: @selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneField).inset(width(5.0));
        make.height.mas_equalTo(height(20.0));
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(height(15.0));
    }];
    
    self.rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setTitle:@"账号密码登陆" forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:height(15.0)];
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.rightButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.rightButton addTarget: self action: @selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.phoneField).inset(width(5.0));
        make.centerY.height.mas_equalTo(self.leftButton);
    }];
    
    UILabel * xieLable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"", height(12)) textAlignmen:NSTextAlignmentCenter text:@"登陆即代表同意用户条款和隐私条款"];
    xieLable.font = [UIFont systemFontOfSize:height(12)];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"登陆即代表同意用户条款和隐私条款"];
    [attrStr setAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}
                     range:NSMakeRange(7, 4)];
    [attrStr setAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}
                     range:NSMakeRange(12, 4)];
    xieLable.attributedText = attrStr;
    [self.view addSubview:xieLable];
    [xieLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).inset(height(20.0) + kSafeAreaBottomHeight);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(width(200));
    }];
    UIButton * lognBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    lognBtn.titleLabel.font =[UIFont systemFontOfSize:height(12)];
//    [lognBtn setTitle:@"登陆即代表同意用户条款和隐私条款" forState:0];
    [lognBtn setTitleColor:UIColor.whiteColor forState:0];
    [self.view addSubview:lognBtn];
    [[lognBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [HttpTool NoHeardsGet:API_POST_website dic:@{} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                WebXieViewController * webVC =[[WebXieViewController alloc]init];
                webVC.name = @"用户协议";
                webVC.context = responce[@"data"][@"deal"];
                webVC.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:webVC animated:YES];
            }else {
                [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            }
        } faile:^(NSError * _Nonnull erroe) {
            [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
        }];
    }];
    [lognBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(xieLable);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(width(150));
    }];
    UIButton * lognBtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    lognBtn1.titleLabel.font =[UIFont systemFontOfSize:height(12)];
    //    [lognBtn setTitle:@"登陆即代表同意用户条款和隐私条款" forState:0];
    [lognBtn1 setTitleColor:UIColor.whiteColor forState:0];
    [self.view addSubview:lognBtn1];
    [[lognBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [HttpTool NoHeardsGet:API_POST_website dic:@{} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                WebXieViewController * webVC =[[WebXieViewController alloc]init];
                webVC.name = @"隐私协议";
                webVC.context = responce[@"data"][@"policy"];
                webVC.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:webVC animated:YES];
            }else {
                [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            }
            
        } faile:^(NSError * _Nonnull erroe) {
            
        }];
    }];
    [lognBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(xieLable);
        make.left.mas_equalTo(lognBtn.mas_right);
        make.width.mas_equalTo(width(150));
    }];
    
    self.descLab = [[UILabel alloc] init];
    self.descLab.font = [UIFont systemFontOfSize:height(12)];
    self.descLab.textColor = [UIColor whiteColor];
    self.descLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.descLab];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.right.equalTo(_phoneField);
        make.bottom.mas_equalTo(xieLable.mas_top).offset(-height(15.0));
    }];
    
    self.wechatLoginBtn = [UIButton buttonWithType: UIButtonTypeCustom];
//    self.wechatLoginBtn.layer.borderWidth = 2.0;
//    self.wechatLoginBtn.layer.borderColor = BassColor(56, 208, 47).CGColor;
    self.wechatLoginBtn.layer.masksToBounds = true;
    self.wechatLoginBtn.layer.cornerRadius = height(45.0 / 2.0);
    self.wechatLoginBtn.backgroundColor = BassColor(50, 189, 42);
    [self.wechatLoginBtn setImage: [UIImage imageNamed:@"wechatbai"] forState: UIControlStateNormal];
    [self.wechatLoginBtn setTitle:@"  微信登录" forState:UIControlStateNormal];
    [self.wechatLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.wechatLoginBtn.titleLabel.font = [UIFont systemFontOfSize:height(15.0)];
    [self.view addSubview:self.wechatLoginBtn];
    [self.wechatLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(width(150.0));
        make.height.mas_equalTo(height(45.0));
        make.bottom.mas_equalTo(_descLab.mas_top).offset(-height(10.0));
    }];
    [self.wechatLoginBtn addTarget:self action:@selector(getAuthWithUserInfoFromWechat) forControlEvents:UIControlEventTouchUpInside];
    
    self.isPassword = false;
    
    [self requestDesc];
}

- (void)setIsPassword:(BOOL)isPassword {
    _isPassword = isPassword;
    if (isPassword) {
        self.codeField.text = @"";
        if (self.inviteField.alpha == 1.0) {
            [self chagedInviteField: false];
        }
    }
    self.codeField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:isPassword ? @"请输入密码(不少于6位数字、字母或组合)" : @"请输入验证码" attributes: @{NSForegroundColorAttributeName : BassColor(233, 233, 233)}];
    [self.verifyBtn setHidden:isPassword];
    [self.leftButton setHidden:!isPassword];
    [self.rightButton setTitle:isPassword ? @"验证码登录" : @"账号密码登录" forState:UIControlStateNormal];
    self.codeField.keyboardType = isPassword ? UIKeyboardTypeDefault : UIKeyboardTypeNumberPad;
    [self.codeField setSecureTextEntry:isPassword];
    [self.codeField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.height.mas_equalTo(self.phoneField);
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(height(20));
        if (!isPassword) {
            make.right.mas_equalTo(self.verifyBtn.mas_left).offset(width(-15.0));
        }else {
            make.right.mas_equalTo(self.phoneField);
        }
    }];
    [self.view layoutIfNeeded];
}

- (void)chagedInviteField:(BOOL)isShow {
    [UIView animateWithDuration:0.25 animations:^{
        self.inviteField.alpha = isShow ? 1.0 : 0.0;
        [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.phoneField);
            make.height.mas_equalTo(height(44.0));
            if (isShow) {
                make.top.mas_equalTo(self.inviteField.mas_bottom).offset(height(35.0));
            }else {
                make.top.mas_equalTo(self.codeField.mas_bottom).offset(height(35.0));
            }
        }];
        [self.loginBtn.superview layoutIfNeeded];
    }];
}

- (VerifyButtonUtils *)verifyBtn {
    if (!_verifyBtn) {
        _verifyBtn = [VerifyButtonUtils buttonWithType:UIButtonTypeCustom];
        _verifyBtn.layer.masksToBounds = YES;
        _verifyBtn.layer.cornerRadius = 4.0;
        _verifyBtn.backgroundColor = BassColor(17, 151, 255);
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
    
    [HttpTool post:API_POST_sendSMS dic:@{@"phone": self.phoneField.text} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            [self.verifyBtn startCountDown:60 normalTitle:@"重新发送" countDownTitle:@"s" normalColor:BassColor(17, 151, 255) countDownColor:BassColor(210, 210, 210)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showToastInView:self.view message:responce[@"message"] duration:0.8];
                [self chagedInviteField: ([responce[@"data"][@"status"] intValue] == 0)];
            });
        } else {
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}

-(void)requestDesc {
    [HttpTool post:API_POST_getDesc dic:@{} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            self.descLab.text = responce[@"data"][@"content"];
        }else {
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message:@"网络错误！" duration:0.8];
    }];
}

-(void)clickLeftButton {
    PasswordViewController *passwordVC = [[PasswordViewController alloc] initWithType:YES];
    [self.navigationController pushViewController:passwordVC animated:YES];
}

-(void)clickRightButton {
    self.isPassword = !_isPassword;
}

-(void)clickLoginBtn {
    [self.view endEditing:true];

    NSString *checkPhone = [StringUtils checkPhone:self.phoneField.text];
    if (nil != checkPhone) {
        [self showToastInView:self.view message:checkPhone duration:0.8];
        return;
    }
    if (self.codeField.text.length == 0) {
        [self showToastInView:self.view message:self.codeField.placeholder duration:0.8];
        return;
    }

    NSString *host = API_POST_passwordLogin;
    NSDictionary *dic = @{@"phone": self.phoneField.text, @"password": self.codeField.text};
    if (!_isPassword) {
        host = API_POST_codeLogin;
        dic = @{@"phone": self.phoneField.text, @"code": self.codeField.text};
        if (self.inviteField.text.length != 0) {
            dic = @{@"phone": checkPhone, @"code": self.codeField.text, @"invite": self.inviteField.text};
        }
    }
    
    [HttpTool noHeardsPost:host dic:dic success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue] == 200) {
            [self saveLoginInfo:responce];

            [self showHomeViewController];
        }else{
              [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}

- (void)getAuthWithUserInfoFromWechat {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                self.resp = result;

//                self.resp.openid = @"ou_MfxCtTo-UZM343z7tWOSNiTTM";
//                self.resp.name = @"安卓开发人员";
                
                // 授权信息
                NSLog(@"Wechat uid: %@", self.resp.uid);
                NSLog(@"Wechat openid: %@", self.resp.openid);
                NSLog(@"Wechat unionid: %@", self.resp.unionId);
                NSLog(@"Wechat accessToken: %@", self.resp.accessToken);
                NSLog(@"Wechat refreshToken: %@", self.resp.refreshToken);
                NSLog(@"Wechat expiration: %@", self.resp.expiration);
                
                // 用户信息
                NSLog(@"Wechat name: %@", self.resp.name);
                NSLog(@"Wechat iconurl: %@", self.resp.iconurl);
                NSLog(@"Wechat gender: %@", self.resp.unionGender);
                [self load_login:[NSString stringWithFormat:@"%@",self.resp.openid]];
            }
        }];
        
    });
}

//判断微信是否授权过
-(void)load_login:(NSString*)openid{
     NSLog(@"==========: %@", self.resp.openid);
    [HttpTool noHeardsPost:API_POST_login dic:@{@"openid":openid} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            [self saveLoginInfo:responce];
            
            [self showHomeViewController];
        }else if ([responce[@"code"] intValue]==201){
            BindPhoneVC * VC =[[BindPhoneVC alloc]init];
            VC.hidesBottomBarWhenPushed=YES;
            VC.resp =self.resp;
            [self.navigationController pushViewController:VC animated:YES];
        }else{
             [self showToastInView:self.view message:self.msg duration:0.8];
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}

-(void)saveLoginInfo:(NSDictionary *)responce {
    [[NSUserDefaults standardUserDefaults] setObject:responce[@"data"][@"token"] forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setObject:responce[@"data"][@"userid"] forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] setObject:self.resp.openid forKey:@"openid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)showHomeViewController {
    UIWindow * window =[UIApplication sharedApplication].delegate.window;
    BassBarViewController * barVC =[[BassBarViewController alloc]init];
    window.rootViewController=barVC;
}

@end
