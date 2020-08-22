//
//  UIView+UIView.m
//  MTSjzzs
//
//  Created by per on 2018/12/10.
//  Copyright © 2018年 per. All rights reserved.
//

#import "UIView+UIView.h"

@implementation UIView (UIView)
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)originX {
    return self.frame.origin.x;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setOriginX:(CGFloat)originX {
    if (isnan(originX)) {
        return;
    }
    self.frame = CGRectMake(originX, self.originY, self.width, self.height);
}

- (void)setOriginY:(CGFloat)originY {
    if (isnan(originY)) {
        return;
    }
    self.frame = CGRectMake(self.originX, originY, self.width, self.height);
}

- (void)setWidth:(CGFloat)width {
    if (isnan(width)) {
        return;
    }
    self.frame = CGRectMake(self.originX, self.originY, width, self.height);
}

- (void)setHeight:(CGFloat)height {
    if (isnan(height)) {
        return;
    }
    self.frame = CGRectMake(self.originX, self.originY, self.width, height);
}

- (CGFloat)CenterX {
    return self.center.x;
}

- (CGFloat)CenterY {
    return self.center.y;
}
- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.CenterY);
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.CenterX, centerY);
}

- (void)setRoundCorners:(UIRectCorner)rectCorner{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

- (UIImage *)creatImageForViewWithFrame:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
    
    struct CGContext *context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, rect.origin.x * -1, rect.origin.y * -1);
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

- (void)pushView:(UIView *)toView {
    [[UIApplication sharedApplication].keyWindow addSubview:toView];
    [UIView animateWithDuration:0.35 animations:^{
        self.frame = CGRectMake(-self.width, 0, self.width, self.height);
        toView.frame = CGRectMake(0, 0, self.width, self.height);
    }];
}

- (void)popView:(UIView *)lastView {
    [UIView animateWithDuration:0.35 animations:^{
        self.frame = CGRectMake(self.width, 0, self.width, self.height);
        lastView.frame = CGRectMake(0, 0, self.width, self.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)presentView:(UIView *)view {
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = CGRectMake(0, 0, view.width, view.height);
    } completion:nil];
}

- (void)dismissViewWithViews:(NSMutableArray *)views completion:(void (^)(BOOL finished))completion {
    [self endEditing:YES];
    //    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, self.height, self.width, self.height);
    } completion:^(BOOL finished) {
        NSLog(@"==============dismissViewWithViews views: %@", views);
        //        NSArray *viewArray = [UIApplication sharedApplication].keyWindow.subviews;
        //        NSLog(@"==============dismissViewWithViews viewArray: %@", viewArray);
        for (UIView *tempView in views) {
            [tempView removeFromSuperview];
        }
        [views removeAllObjects];
        
        if (completion) {
            completion(finished);
        }
    }];
}

@end
