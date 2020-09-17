//
//  UploadScreenshotsVC.h
//  taskApp
//
//  Created by per on 2019/11/12.
//  Copyright © 2019 per. All rights reserved.
//

#import "BassMianViewController.h"
#import "TaskInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UploadScreenshotsVC : BassMianViewController

@property(nonatomic,strong)TaskBaseModel *taskModel;

@property(nonatomic,copy)NSString * nameStr;
@property(nonatomic,copy)NSString * orderid;
@property(nonatomic,assign)int indx;

-(instancetype)initModel:(TaskBaseModel *) model;

@end

NS_ASSUME_NONNULL_END
