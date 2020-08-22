//
//  WalletCell.h
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalletModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WalletCell : UITableViewCell
@property(nonatomic,strong)UILabel * leftlable;
@property(nonatomic,strong)UILabel * leftlable1;
@property(nonatomic,strong)UILabel * rightlable;
@property(nonatomic,strong)UILabel * rightlable1;
-(void)chuanzhiWalletModel:(WalletModel*)model;
@end

NS_ASSUME_NONNULL_END
