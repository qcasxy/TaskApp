//
//  TaskBtnView.h
//  taskApp
//
//  Created by per on 2019/11/11.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TaskBtnViewDelegate <NSObject>

@optional
-(void)chuanZhiType:(int)indexType;
-(void)chuanZhiLeiXing:(NSString*)cateid;
-(void)chuanZhiBOOL:(BOOL)isBool;
@end
@interface TaskBtnView : UIView
@property(nonatomic,weak)id<TaskBtnViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
