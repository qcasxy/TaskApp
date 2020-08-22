//
//  VerifyButtonUtils.m
//  RZXBozon
//
//  Created by per on 2018/12/14.
//  Copyright © 2018年 per. All rights reserved.
//

#import "VerifyButtonUtils.h"

@interface VerifyButtonUtils ()

{
    dispatch_source_t timer;
}

@end

@implementation VerifyButtonUtils
- (void)startCountDown:(NSInteger)countDownTime normalTitle:(NSString *)title countDownTitle:(NSString *) cdTitle normalColor:(UIColor *)color countDownColor:(UIColor *)cdColor {
    
    if (!timer) {
        __block NSInteger cdTime = countDownTime;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(timer, ^{
            
            //倒计时结束
            if (cdTime <= 0) {
                [self endCountDown:title normalColor:color];
                if (self.countDownFinish) {
                    self.countDownFinish();
                }
            } else {
                int seconds = cdTime % 60;
                if (cdTime == 60) {
                    seconds = 60;
                }
                NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
                //回到主线程更新Button的标题,颜色和交互状态
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setTitle:[NSString stringWithFormat:@"%@%@", timeStr, cdTitle] forState:UIControlStateNormal];
                    [self setBackgroundColor:cdColor];
                    self.enabled = NO;
                });
            }
            cdTime--;
        });
        dispatch_resume(timer);
    }
}

- (void)endCountDown:(NSString *)title normalColor:(UIColor *)color {
    if (timer != nil) {
        dispatch_source_cancel(timer);
        timer = nil;
    }
    //回到主线程更新Button的标题,颜色和交互状态
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTitle:title forState:UIControlStateNormal];
        self.layer.masksToBounds = YES;
        self.backgroundColor = color;
        self.enabled = YES;
    });
}

- (void)setButtonEnabled:(BOOL)enable {
    self.enabled = enable;
    if (enable) {
        [self setBackgroundImage:[UIImage imageNamed:@"btnNormol"] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage imageNamed:@"btnDisEnable"] forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
