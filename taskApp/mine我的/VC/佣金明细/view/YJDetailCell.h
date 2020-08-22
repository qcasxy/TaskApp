//
//  YJDetailCell.h
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalletModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YJDetailCell : UITableViewCell
@property(nonatomic,strong)UILabel * leftLable;
@property(nonatomic,strong)UILabel * centerLable;
@property(nonatomic,strong)UILabel * rightLable;
@property(nonatomic,strong)UILabel * rightLable1;
-(void)chuanzhiWalletModel:(WalletModel*)model;
@end

NS_ASSUME_NONNULL_END
