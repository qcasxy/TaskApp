//
//  PasswordViewController.m
//  taskApp
//
//  Created by 秦程 on 2020/8/23.
//  Copyright © 2020 per. All rights reserved.
//

#import "PasswordViewController.h"
#import "VerifyButtonUtils.h"

@interface PasswordViewController ()

@property (nonatomic, assign) BOOL isForget;

@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) VerifyButtonUtils *verifyBtn;

@property (nonatomic, strong) UITextField *firstPasswordField;
@property (nonatomic, strong) UITextField *secondPasswordField;

@end

@implementation PasswordViewController

-(void)clickBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (instancetype)initWithType:(BOOL)isForget {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.isForget = isForget;

        [self setNavTitle:isForget ? @"设置新密码" : @"设置密码"];
        [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.firstPasswordField = [HttpTool createField:@"设置密码（6位数字与字母组合）" font:[UIFont systemFontOfSize:height(15)] color:BassColor(51,51,51) ishidden: YES];
    self.firstPasswordField.layer.borderColor = [BassColor(233, 233, 233) CGColor];
    self.firstPasswordField.layer.borderWidth = 1.0;
    self.firstPasswordField.layer.cornerRadius = 4.0;
    self.firstPasswordField.keyboardType = UIKeyboardTypePhonePad;
    self.firstPasswordField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width(10.0), height(34.0))];
    self.firstPasswordField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.firstPasswordField];
    
    self.secondPasswordField = [HttpTool createField:@"请再次输入密码" font:[UIFont systemFontOfSize:height(15)] color:BassColor(51,51,51) ishidden: YES];
    self.secondPasswordField.layer.borderColor = [BassColor(233, 233, 233) CGColor];
    self.secondPasswordField.layer.borderWidth = 1.0;
    self.secondPasswordField.layer.cornerRadius = 4.0;
    self.secondPasswordField.keyboardType = UIKeyboardTypePhonePad;
    self.secondPasswordField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width(10.0), height(34.0))];
    self.secondPasswordField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.secondPasswordField];
    [self.secondPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.firstPasswordField);
        make.top.mas_equalTo(self.firstPasswordField.mas_bottom).offset(height(20));
    }];
    
    UIButton * loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = BassColor(17, 151, 255);
    [loginBtn setTitle:@"完成" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:height(17.0) weight:UIFontWeightMedium];
    [loginBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = height(4);
    [loginBtn addTarget: self action: @selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.secondPasswordField);
        make.height.mas_equalTo(height(44.0));
        make.top.mas_equalTo(self.secondPasswordField.mas_bottom).offset(height(75.0));
    }];
    
    if (_isForget) {
        self.phoneField = [HttpTool createField:@"请输入手机号" font:[UIFont systemFontOfSize:height(15)] color:BassColor(51,51,51) ishidden:NO];
        self.phoneField.layer.borderColor = [BassColor(233, 233, 233) CGColor];
        self.phoneField.layer.borderWidth = 1.0;
        self.phoneField.layer.cornerRadius = 4.0;
        self.phoneField.keyboardType = UIKeyboardTypePhonePad;
        self.phoneField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width(10.0), height(34.0))];
        self.phoneField.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:self.phoneField];
        [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view).inset(width(34.0));
            make.height.mas_equalTo(height(34.0));
            make.top.mas_equalTo(self.view).inset(height(40) + NavHeight);
        }];
        
        [self.view addSubview:self.verifyBtn];
        [self.verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.mas_equalTo(self.phoneField);
            make.width.mas_equalTo(width(120.0));
            make.top.mas_equalTo(self.phoneField.mas_bottom).offset(height(20));
        }];
        
        self.codeField = [HttpTool createField:@"请输入验证码" font:[UIFont systemFontOfSize:height(15)] color:BassColor(51,51,51) ishidden:NO];
        self.codeField.layer.borderColor = [BassColor(233, 233, 233) CGColor];
        self.codeField.layer.borderWidth = 1.0;
        self.codeField.layer.cornerRadius = 4.0;
        self.codeField.keyboardType = UIKeyboardTypePhonePad;
        self.codeField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width(10.0), height(34.0))];
        self.codeField.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:self.codeField];
        [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.mas_equalTo(self.phoneField);
            make.right.mas_equalTo(self.verifyBtn.mas_left).offset(width(-15.0));
            make.top.mas_equalTo(self.phoneField.mas_bottom).offset(height(20));
        }];
        
        self.firstPasswordField.placeholder = @"请输入新密码（6位数字与字母组合）";
        self.secondPasswordField.placeholder = @"请再次输入新密码";
        [loginBtn setTitle:@"修改" forState:UIControlStateNormal];
        
        [self.firstPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(self.phoneField);
            make.top.mas_equalTo(self.codeField.mas_bottom).offset(height(20));
        }];
    }else {
        [self.firstPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view).inset(width(34.0));
            make.height.mas_equalTo(height(34.0));
            make.top.mas_equalTo(self.view).inset(height(40));
        }];
    }
}

- (VerifyButtonUtils *)verifyBtn {
    if (!_verifyBtn) {
        _verifyBtn = [VerifyButtonUtils buttonWithType:UIButtonTypeCustom];
        _verifyBtn.layer.masksToBounds = YES;
        _verifyBtn.layer.cornerRadius = 4.0;
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
    if (self.codeField.text.length == 0) {
        [self showToastInView:self.view message:self.codeField.placeholder duration:0.8];
        return;
    }

//    [HttpTool noHeardsPost:API_POST_register dic:@{@"openid":self.resp.openid,@"nickname":self.resp.name,@"headimg":self.resp.iconurl,@"phone":self.phoneField.text,@"invite":self.yanField.text} success:^(id  _Nonnull responce) {
//
//        if ([responce[@"code"] intValue]==200) {
//            [[NSUserDefaults standardUserDefaults] setObject:responce[@"data"][@"token"] forKey:@"token"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isLogin"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            UIWindow * window =[UIApplication sharedApplication].delegate.window;
//            BassBarViewController * barVC =[[BassBarViewController alloc]init];
//            window.rootViewController=barVC;
//        }else{
//              [self showToastInView:self.view message:responce[@"message"] duration:0.8];
////            SuccessViewController *VC =[[SuccessViewController alloc]init];
////            VC.imgName = @"shibai";
////            VC.status = @"绑定失败";
////            VC.beiZhu = @"绑定失败，请检查自己的网络以及从新绑定，感谢配合～";
////            VC.btnStr = @"确定";
////            VC.indexType=1;
////            [self.navigationController pushViewController:VC animated:YES];
//
//        }
//    } faile:^(NSError * _Nonnull erroe) {
//
//    }];
}

@end
