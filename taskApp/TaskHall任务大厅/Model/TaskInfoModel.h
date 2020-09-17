//
//  TaskInfoModel.h
//  taskApp
//
//  Created by 秦程 on 2020/9/15.
//  Copyright © 2020 per. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskBaseModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *download;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, assign) NSInteger surplus;
@property (nonatomic, copy) NSString *cuttime;
@property (nonatomic, assign) NSInteger cateid;
@property (nonatomic, assign) NSInteger collect;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSArray<NSString *> *cover;
@property (nonatomic, strong) NSArray<NSString *> *desc;
@property (nonatomic, copy) NSString *video;
/// 富文本框
@property (nonatomic, copy) NSString *detail;
/// 附件详情字段
@property (nonatomic, copy) NSString *detailfile;

/// 提交任务时，真实姓名是否必填  1 必填  2 非必填
@property (nonatomic, assign) NSInteger realneed;
/// 提交任务时，手机号是否必填  1 必填  2 非必填
@property (nonatomic, assign) NSInteger phoneneed;

@end

/// 任务大厅 任务详情 api/taskInfo
@interface TaskInfoModel : TaskBaseModel

@property (nonatomic, assign) NSInteger draw;

@end

/// 我的 我的接单 接口 api/taskDetails 
@interface TaskDetailModel : TaskBaseModel

@property (nonatomic, assign) NSInteger status;

@end

NS_ASSUME_NONNULL_END
