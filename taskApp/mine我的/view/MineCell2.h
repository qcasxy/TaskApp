//
//  MineCell2.h
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineCell2 : UITableViewCell
@property(nonatomic,strong)UILabel * nameLable;
@property(nonatomic,strong)UIImageView * leftImg;
@property(nonatomic,strong)UIImageView * rightImg;
-(void)chuanZhiMineModel:(MineModel*)model;
@end

NS_ASSUME_NONNULL_END
