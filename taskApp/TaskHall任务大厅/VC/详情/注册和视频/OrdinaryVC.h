//
//  OrdinaryVC.h
//  taskApp
//
//  Created by per on 2019/11/12.
//  Copyright © 2019 per. All rights reserved.
//

#import "BassMianViewController.h"
#import "TaskInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrdinaryVC : BassMianViewController

@property(nonatomic,strong)TaskInfoModel *taskModel;

@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic,assign)int homeIndex;

-(instancetype)initModel:(TaskInfoModel *) model;

@end

NS_ASSUME_NONNULL_END
