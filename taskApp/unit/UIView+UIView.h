//
//  UIView+UIView.h
//  MTSjzzs
//
//  Created by per on 2018/12/10.
//  Copyright © 2018年 per. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIView)
- (UIViewController*)viewController;
- (CGFloat)originX;
- (CGFloat)originY;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)CenterX;
- (CGFloat)CenterY;
- (CGFloat)maxX;
- (CGFloat)maxY;
- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (UIImage *)creatImageForViewWithFrame:(CGRect)rect;

- (void)setRoundCorners:(UIRectCorner)rectCorner;

- (void)pushView:(UIView *)toView;
- (void)popView:(UIView *)lastView;
- (void)presentView:(UIView *)view;

- (void)dismissViewWithViews:(NSMutableArray *)views completion:(void (^)(BOOL finished))completion;

@end
