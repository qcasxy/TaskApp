//
//  UIColor+Wrapper.h
//  RZXBozon
//
//  Created by per on 2018/12/10.
//  Copyright © 2018年 per. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Wrapper)

/**
 *  十六进制颜色码转换成iOS可用的RGB
 *
 *   hexColorString 十六进制颜色码
 *   alpha 透明度/Users/mac1/Desktop/博瑞名师学生/RZXStudent/Utils/UIColor+Wrapper.m
 *
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColorString;
+ (UIColor *)colorWithHexString:(NSString *)hexColorString andAlpha:(CGFloat)alpha;

@end
