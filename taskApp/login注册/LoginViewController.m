

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
@interface LoginViewController ()
@property(nonatomic,strong)UIButton * sureBtn;
@property(nonatomic,strong)UMSocialUserInfoResponse *resp;
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self isHidden];
    if (self.msg.length>0) {
        [self showToastInView:self.view message:self.msg duration:0.8];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat imageWidth = 30;
    CGFloat imageHeight = 30;
    CGFloat spacing = 10;
    self.view.backgroundColor = UIColor.whiteColor;
    UIImageView * backImg =[[UIImageView alloc]init];
    backImg.image =[UIImage imageNamed:@"logoBack"];
    [self.view addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.bottom.mas_equalTo(self.view);
    }];
    UIImageView * logoImg =[[UIImageView alloc]init];
    logoImg.image =[UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view).offset(height(80)+NavHeight);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
    }];
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureBtn setTitle:@"微信授权登录" forState:0];
    self.sureBtn.backgroundColor =BassColor(17, 151, 255);
    [self.sureBtn setTitleColor:BassColor(255, 255,255) forState:0];
    [self.sureBtn setImage:[UIImage imageNamed:@"wechatbai"] forState:0];
    [self.view addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(height(50));
        make.width.mas_equalTo(width(305));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-height(100));
    }];
    self.sureBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
    self.sureBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
    
    self.sureBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
    self.sureBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
    
    [self.sureBtn setImagePosition:LXMImagePositionLeft spacing:spacing];
    [self.sureBtn addTarget:self action:@selector(getAuthWithUserInfoFromWechat) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * xieLable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"", height(12)) textAlignmen:NSTextAlignmentCenter text:@"登陆即代表同意用户条款和隐私条款"];
    xieLable.font = [UIFont systemFontOfSize:height(12)];
    [self.view addSubview:xieLable];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"登陆即代表同意用户条款和隐私条款"];
    [attrStr setAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}
                     range:NSMakeRange(7, 4)];
    [attrStr setAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}
                     range:NSMakeRange(12, 4)];
    xieLable.attributedText = attrStr;
    [xieLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height(20));
        make.top.mas_equalTo(self.sureBtn.mas_bottom).offset(height(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
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
            }
            
        } faile:^(NSError * _Nonnull erroe) {
            
        }];
    }];
    [lognBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height(20));
        make.top.mas_equalTo(self.sureBtn.mas_bottom).offset(height(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
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
            }
            
        } faile:^(NSError * _Nonnull erroe) {
            
        }];
    }];
    [lognBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height(20));
        make.top.mas_equalTo(self.sureBtn.mas_bottom).offset(height(25));
        make.left.mas_equalTo(lognBtn.mas_right);
        make.width.mas_equalTo(width(150));
    }];
}
- (void)getAuthWithUserInfoFromWechat
{
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
            [[NSUserDefaults standardUserDefaults] setObject:responce[@"data"][@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] setObject:self.resp.openid forKey:@"openid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIWindow * window =[UIApplication sharedApplication].delegate.window;
            BassBarViewController * barVC =[[BassBarViewController alloc]init];
            window.rootViewController=barVC;
        }else if ([responce[@"code"] intValue]==201){
            BindPhoneVC * VC =[[BindPhoneVC alloc]init];
            VC.hidesBottomBarWhenPushed=YES;
            VC.resp =self.resp;
            [self.navigationController pushViewController:VC animated:YES];
        }else{
             [self showToastInView:self.view message:self.msg duration:0.8];
        }
        
    } faile:^(NSError * _Nonnull erroe) {
        
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
