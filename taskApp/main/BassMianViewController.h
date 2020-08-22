//
//  BassMianViewController.h
//  全民帮
//
//  Created by per on 2019/10/18.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BassMianViewController : UIViewController
@property(nonatomic,strong)DGActivityIndicatorView * DGActView;
-(void)isHidden;
-(void)showDGActView;
-(void)stopDGActView;
-(void)setNavTitle:(NSString *)title;
-(void)setLeftButton:(NSString*)title imgStr:(NSString*)imgStr selector:(SEL)selector;
-(void)setRightButton:(NSString*)title imgStr:(NSString*)imgStr selector:(SEL)selector;
-(void)showToastInView:(UIView*)view message:(NSString*)message duration:(NSTimeInterval)duration;
@end

NS_ASSUME_NONNULL_END
