//
//  MineCell1.h
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MineCell1Delegate <NSObject>

@optional
-(void)clickBtnIndex:(NSUInteger)index;
-(void)clickBtnGoToVC;
@end
@interface MineCell1 : UITableViewCell
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UIImageView * touImg;
@property(nonatomic,strong)UILabel * nameLable;
@property(nonatomic,strong)UILabel * IDLable;
@property(nonatomic,strong)UIImageView * rightImg;
@property(nonatomic,strong)UILabel * moneyLable;
@property(nonatomic,strong)UILabel * moneyLable1;
@property(nonatomic,strong)UIImageView * leveImg;
@property(nonatomic,strong)UILabel * leveLable;
@property(nonatomic,weak)id<MineCell1Delegate>delegate;
-(void)chuanZhiMineModel:(MineModel*)model;
@end

NS_ASSUME_NONNULL_END
