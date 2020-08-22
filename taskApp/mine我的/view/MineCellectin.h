//
//  MineCellectin.h
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineCellectin : UICollectionViewCell
@property(nonatomic,strong)UILabel * name;
@property(nonatomic,strong)UIImageView * img;
-(void)chuanZhiMineModel:(MineModel*)model;
@end

NS_ASSUME_NONNULL_END
