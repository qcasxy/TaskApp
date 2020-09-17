//
//  OrderDownloadVC.h
//  taskApp
//
//  Created by per on 2019/11/12.
//  Copyright © 2019 per. All rights reserved.
//

#import "BassMianViewController.h"
#import "TaskInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDownloadVC : BassMianViewController

@property(nonatomic,strong)TaskDetailModel *taskModel;
@property(nonatomic,strong)NSDictionary * dataDic;

-(instancetype)initModel:(TaskDetailModel *) model;

@end

NS_ASSUME_NONNULL_END
