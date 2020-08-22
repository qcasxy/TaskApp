//
//  VerifyButtonUtils.h
//  RZXBozon
//
//  Created by per on 2018/12/14.
//  Copyright © 2018年 per. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CountDownFinish)(void);

@interface VerifyButtonUtils : UIButton
@property (nonatomic,copy) CountDownFinish  countDownFinish;

/**
 *  开始按钮倒计时
 *  后台另起线程执行定时器，不受主线程阻塞
 *
 *  @param countDownTime 倒计时时间
 *  @param title         正常按钮显示Title
 *  @param cdTitle       倒计时时显示Title
 *  @param color         正常按钮显示颜色
 *  @param cdColor       倒计时时显示颜色
 */
- (void)startCountDown:(NSInteger)countDownTime normalTitle:(NSString *)title countDownTitle:(NSString *) cdTitle normalColor:(UIColor *)color countDownColor:(UIColor *)cdColor;

/**
 *  结束倒计时
 *
 *  @param title 正常显示Title
 *  @param color 正常显示颜色
 */
- (void)endCountDown:(NSString *)title normalColor:(UIColor *)color;

/**
 *  设置按钮的有效状态
 *
 *  @param enable YES:按钮可交互 NO:按钮不可交互，变为灰色
 */
- (void)setButtonEnabled:(BOOL)enable;

@end
