//
//  HeaderSet.h
//  Currency
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef HeaderSet_h
#define HeaderSet_h


#define nPaymentResult @"PaymentResultNotification"     //支付结果通知

#define TOKEN [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]
#define LEVEL [[NSUserDefaults standardUserDefaults] objectForKey:@"level"]
#define NICKNAME [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"]
#define NICKIMG [[NSUserDefaults standardUserDefaults] objectForKey:@"img"]
#define ISLOGIN [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]
#define cloud_token [[NSUserDefaults standardUserDefaults] objectForKey:@"cloud_token"]
#define OPENID [[NSUserDefaults standardUserDefaults] objectForKey:@"openid"]
#define kLatitude @"latitudeString"//纬度
#define kLongitude @"longitudeString"//经度
/** 16进制颜色  0x...... */
#define kRGB_HEX(rgbValue)                                                                         \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0                         \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0                            \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0                                     \
alpha:1.0]
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenScale [UIScreen mainScreen].scale
#define isIPhoneX_Xs (kScreenWidth == 375.0 && kScreenHeight == 812.0)
#define isIPhoneXR ((kScreenWidth == 414.0 && kScreenHeight == 896.0) && kScreenScale == 2.0)
#define isIPhoneXsMax ((kScreenWidth == 414.0 && kScreenHeight == 896.0) && kScreenScale == 3.0)
#define  isIPhoneX (isIPhoneX_Xs || isIPhoneXR || isIPhoneXsMax ? YES : NO)
#define  NavHeight   (isIPhoneX ? 88.f : 64.f)
#define  isFont(p)  [UIFont systemFontOfSize:p]
#define VFont (isIPhoneX ? isFont(16) : isFont(14))
#define VPFont(w,num) [UIFont fontWithName:[NSString stringWithFormat:@"%@",w] size:height(num)]
#define kSafeAreaBottomHeight (isIPhoneX ?  34 : 0)
//#define kSafeHeight (isIPhoneX ? 44 : 0)
#define TabBaHeight (isIPhoneX ? (49.f+34.f) : 49.f)
#define width(w)  w/375.0*kScreenWidth
#define height(h) h*kScreenWidth/375.0
#define BassColor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]
#define IOS_FSystenVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define HEXCOLOR(rgbValue)                                                                                             \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                               \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                  \
blue:((float)(rgbValue & 0xFF)) / 255.0                                                           \
alpha:1.0]

#endif /* HeaderSet_h */
