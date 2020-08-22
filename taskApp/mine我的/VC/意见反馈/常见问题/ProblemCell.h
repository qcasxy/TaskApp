//
//  ProblemCell.h
//  taskApp
//
//  Created by per on 2019/11/15.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProblemCell : UITableViewCell
@property(nonatomic,strong)UIImageView * wenImg;
@property(nonatomic,strong)UILabel * wenLabel;
@property(nonatomic,strong)UILabel * daLabel;
-(void)chuanZhiMineModel:(MineModel*)model;
@end

NS_ASSUME_NONNULL_END
