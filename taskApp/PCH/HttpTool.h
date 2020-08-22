//
//  HttpTool.h
//  Currency
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, GradientDirection) {
    GradientDirectionTopToBottom = 0,    // 从上往下 渐变
    GradientDirectionLeftToRight,        // 从左往右
    GradientDirectionBottomToTop,      // 从下往上
    GradientDirectionRightToLeft      // 从右往左
};
NS_ASSUME_NONNULL_BEGIN
typedef void (^SuccessBlockType)(id responce);
typedef void (^FailedBloclkType)(NSError *erroe);
@interface HttpTool : NSObject
+(void)post:(NSString*)url dic:(NSDictionary*)dic success:(SuccessBlockType)success faile:(FailedBloclkType)faile;
+(void)noHeardsPost:(NSString*)url dic:(NSDictionary*)dic success:(SuccessBlockType)success faile:(FailedBloclkType)faile;
+(void)get:(NSString*)url dic:(NSDictionary*)dic success:(SuccessBlockType)success faile:(FailedBloclkType)faile;
+(void)NoHeardsGet:(NSString*)url dic:(NSDictionary*)dic success:(SuccessBlockType)success faile:(FailedBloclkType)faile;
+(NSString*)timestampConversionTime:(NSString*)time timeType:(NSString*)timeStr;
+(NSString *)currentTimeStr;
+(NSString*)MD5Sigin:(NSDictionary*)dic;
+(NSString *)MD5ForLower32Bate:(NSString *)str;
+(CGFloat)floatWithStr:(NSString*)str and:(NSInteger)font;
+(UILabel*)createLable:(UIColor*)color font:(UIFont*)font textAlignmen:(NSTextAlignment)textAlignment text:(NSString*)test;
+(UITextField*)createField:(NSString*)placeholder font:(UIFont*)font color:(UIColor*)color ishidden:(BOOL)isYes;
+(UITextField*)createField:(NSString*)placeholder font:(UIFont*)font color:(UIColor*)color name:(NSString*)title ishidden:(BOOL)isYes foalt:(CGFloat)titleWidth;
+(CAGradientLayer *) setChangeColorWithView:(UIView*)view andStartColor:(UIColor*)startColor andEndColor:(UIColor*)endColor;
+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(GradientDirection)gradientType;
@end

NS_ASSUME_NONNULL_END
