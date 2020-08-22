//
//  TaskTanVC.h
//  taskApp
//
//  Created by per on 2019/11/15.
//  Copyright © 2019 per. All rights reserved.
//

#import "BassMianViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TaskTanVCDelegate <NSObject>

@optional
-(void)chuanZhiTaskTanID:(NSString*)ID;
-(void)chuanZhiTaskTanName:(NSString*)name;
@end
@interface TaskTanVC : BassMianViewController
@property(nonatomic,weak)id<TaskTanVCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
