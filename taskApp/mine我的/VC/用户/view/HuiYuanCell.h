//
//  HuiYuanCell.h
//  taskApp
//
//  Created by per on 2019/11/11.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuiYuanModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HuiYuanCell : UITableViewCell
@property(nonatomic,strong)UIImageView * touImg;
@property(nonatomic,strong)UILabel * leftLable;
@property(nonatomic,strong)UILabel * centerLable;
@property(nonatomic,strong)UILabel * rightLable;
-(void)chuanzhiHuiYuanModel:(HuiYuanModel*)model;
@end

NS_ASSUME_NONNULL_END
