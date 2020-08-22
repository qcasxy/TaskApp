//
//  HttpTool.m
//  Currency
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HttpTool.h"
#import "LoginViewController.h"
#import<CommonCrypto/CommonDigest.h>
@implementation HttpTool
+(void)post:(NSString*)url dic:(NSDictionary*)dic success:(SuccessBlockType)success faile:(FailedBloclkType)faile
{
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 25;
//    [dic setValue:@"2" forKey:@"equip"];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    
    NSString * heaedStr = TOKEN;
    if (heaedStr.length>0) {
        NSDictionary *headerFieldValueDictionary = @{@"token":TOKEN};
        if (headerFieldValueDictionary != nil) {
            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
                NSString *value = headerFieldValueDictionary[httpHeaderField];
                [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
            }
        }
    }
    manager.requestSerializer = requestSerializer;
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([responDic[@"code"] intValue]==501) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"level"];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cloud_token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            LoginViewController * loginVC = [[LoginViewController alloc]init];
            loginVC.msg=responDic[@"message"];
            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
            UIWindow * window = [UIApplication sharedApplication].delegate.window;
            window.rootViewController =loginNav;
            return ;
        }
        if (success) {
            success(responDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }
    }];
}
+(void)noHeardsPost:(NSString*)url dic:(NSDictionary*)dic success:(SuccessBlockType)success faile:(FailedBloclkType)faile
{
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 25;
//    [dic setValue:@"2" forKey:@"equip"];
   
    
   
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([responDic[@"code"] intValue]==501) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uuid"];
            LoginViewController * loginVC = [[LoginViewController alloc]init];
            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
            UIWindow * window = [UIApplication sharedApplication].delegate.window;
            window.rootViewController =loginNav;
            return ;
        }
        if (success) {
            success(responDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }
    }];
}
+(void)get:(NSString*)url dic:(NSDictionary*)dic success:(SuccessBlockType)success faile:(FailedBloclkType)faile
{
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 25;
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    NSString * heaedStr = TOKEN;
    if (heaedStr.length>0) {
        NSDictionary *headerFieldValueDictionary = @{@"token":TOKEN};
        if (headerFieldValueDictionary != nil) {
            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
                NSString *value = headerFieldValueDictionary[httpHeaderField];
                [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
            }
        }
    }
    manager.requestSerializer = requestSerializer;
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *responDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
           if ([responDic[@"code"] intValue]==501) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uuid"];
                    LoginViewController * loginVC = [[LoginViewController alloc]init];
                    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
                    UIWindow * window = [UIApplication sharedApplication].delegate.window;
                    window.rootViewController =loginNav;
                    return ;
                }
                if (success) {
                    success(responDic);
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }
    }];
   
}
+(void)NoHeardsGet:(NSString*)url dic:(NSDictionary*)dic success:(SuccessBlockType)success faile:(FailedBloclkType)faile
{
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 25;
   
    
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *responDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
           if ([responDic[@"code"] intValue]==501) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uuid"];
                    LoginViewController * loginVC = [[LoginViewController alloc]init];
                    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
                    UIWindow * window = [UIApplication sharedApplication].delegate.window;
                    window.rootViewController =loginNav;
                    return ;
                }
                if (success) {
                    success(responDic);
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }
    }];
   
}
+(NSString*)timestampConversionTime:(NSString*)time timeType:(NSString*)timeStr {
    NSString *timeStampString  = [NSString stringWithFormat:@"%@",time];
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:timeStr];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}
//获取当前时间戳
+(NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
+(NSString*)MD5Sigin:(NSDictionary*)dic{
    //    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    //    [signParams setObject:@"1" forKey:@"appid"];
    //    [signParams setObject:@"4" forKey:@"noncestr"];
    //    [signParams setObject:@"4" forKey:@"package"];
    //    [signParams setObject:@"6" forKey:@"partnerid"];
    //    [signParams setObject:@"7" forKey:@"prepayid"];
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dic allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dic objectForKey:categoryId] isEqualToString:@""]
            && ![[dic objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[dic objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dic objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段
    [contentString appendFormat:@"key=%@",@"0f4137ed1502b5045d6083aa258b5c42"];
    
    NSString *result = [self MD5ForLower32Bate:contentString];
    return result;
}
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}
//计算宽度
+ (CGFloat)floatWithStr:(NSString*)str and:(NSInteger)font {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};  //指定字号
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, 2000) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    //    CGSize size = [str boundingRectWithSize:constrainedSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return rect.size.width;
}
+(UILabel*)createLable:(UIColor*)color font:(UIFont*)font textAlignmen:(NSTextAlignment)textAlignment text:(nonnull NSString *)test
{
    UILabel * lable =[[UILabel alloc]init];
    lable.font =font;
    lable.textAlignment =textAlignment;
    lable.textColor = color;
    lable.text = test;
    return lable;
   
}
+(UITextField*)createField:(NSString*)placeholder font:(UIFont*)font color:(UIColor*)color ishidden:(BOOL)isYes{
    UITextField * filed =[[UITextField alloc]init];
    filed.placeholder =placeholder;
    filed.font =font;
    filed.textColor = color;
    filed.secureTextEntry= isYes;
    return filed;
}
+(UITextField*)createField:(NSString*)placeholder font:(UIFont*)font color:(UIColor*)color name:(NSString*)title ishidden:(BOOL)isYes foalt:(CGFloat)titleWidth{
    UITextField * filed =[[UITextField alloc]init];
    filed.placeholder =placeholder;
    filed.font =font;
    filed.textColor = color;
    filed.secureTextEntry= isYes;
//    UIView  * backView =[[UIView alloc]initWithFrame:CGRectMake(width(10), 0, width(80), height(50))];
    UILabel * leftLable =[[UILabel alloc]initWithFrame:CGRectMake(width(10), 0,titleWidth, height(50))];
    leftLable.text = title;
    leftLable.backgroundColor =UIColor.whiteColor;
    leftLable.textColor = BassColor(0, 0, 0);
    leftLable.font = [UIFont systemFontOfSize:20];
    leftLable.textAlignment =NSTextAlignmentLeft;
    filed.leftView = leftLable;
    filed.leftViewMode = UITextFieldViewModeAlways;
    return filed;
}
+(CAGradientLayer *) setChangeColorWithView:(UIView*)view andStartColor:(UIColor*)startColor andEndColor:(UIColor*)endColor{
    CAGradientLayer * gradLayer =[CAGradientLayer layer];
    gradLayer.frame =view.bounds;
    gradLayer.colors = @[(__bridge id) startColor.CGColor,(__bridge id) endColor.CGColor];
    gradLayer.startPoint =CGPointMake(0.0, 1.0);
    gradLayer.endPoint =CGPointMake(1.0, 1.0);
    return gradLayer;
}
+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(GradientDirection)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint startPt =  CGPointMake(0.0, 0.0);
    CGPoint endPt =  CGPointMake(0.0, 0.0);
    
    switch (gradientType) {
        case GradientDirectionTopToBottom:
            startPt= CGPointMake(0.0, 0.0);
            endPt= CGPointMake(0.0, bounds.size.height);
            break;
        case GradientDirectionLeftToRight:
            startPt = CGPointMake(0.0, 0.0);
            endPt = CGPointMake(bounds.size.width, 0.0);
            break;
        case GradientDirectionBottomToTop:
            startPt = CGPointMake(0.0, bounds.size.height);
            endPt = CGPointMake(0.0, 0.0);
            break;
        case GradientDirectionRightToLeft:
            startPt = CGPointMake(bounds.size.width, 0.0);
            endPt = CGPointMake(0, 0.0);
            break;
    }
    CGContextDrawLinearGradient(context, gradient, startPt, endPt, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}
@end
