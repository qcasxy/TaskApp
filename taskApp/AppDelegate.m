//
//  AppDelegate.m
//  taskApp
//
//  Created by per on 2019/11/7.
//  Copyright © 2019 per. All rights reserved.
//

#import "AppDelegate.h"
#import "BassBarViewController.h"
#import "LoginViewController.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import <AlipaySDK/AlipaySDK.h>
#import "PaymentManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //微信
    [WXApi registerApp:WECHAT_APP_ID];
    [UMConfigure initWithAppkey:@"5dccf0e13fc19518fd0007d1" channel:@"App Store"];
     [self configUSharePlatforms];
     //[self confitUShareSettings];
    if ([ISLOGIN isEqualToString:@"1"]) {
        BassBarViewController * barVC =[[BassBarViewController alloc]init];
        self.window.rootViewController = barVC;
    }else{
        LoginViewController * VC =[[LoginViewController alloc]init];
        UINavigationController * navVC =[[UINavigationController alloc]initWithRootViewController:VC];
        self.window.rootViewController = navVC;
    }
    return YES;
}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APP_ID appSecret:WECHAT_APP_SECRET redirectURL:@"http://mobile.umeng.com/social"];
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
}

#pragma mark --- 回调---
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if ((!result)||[url.host isEqualToString:@"safepay"]||([[url description] containsString:@"pay"]&&[[url description] containsString:WECHAT_APP_ID]))
    {
        // 其他如支付等SDK的回调
        result = [self handleUrl:url];
    }
    return result;
}
/**
 * 处理支付url
 */
- (BOOL)handleUrl:(NSURL *)url {
    //跳转支付宝钱包进行支付，处理支付结果
    if ([url.host isEqualToString:@"safepay"])
    {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            int resultStatus = [[resultDic objectForKey:@"resultStatus"] intValue];
            [PaymentManager alipayResult:resultStatus];
        }];
    }
    else if (![WECHAT_APP_ID isEqualToString:@""] && [[url description] containsString:WECHAT_APP_ID])
    {
        return [WXApi handleOpenURL:url delegate:[PaymentManager sharedManager]];
    }
    return YES;
}


@end
