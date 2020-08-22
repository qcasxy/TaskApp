//
//  MemberCell.h
//  CartoonApp
//
//  Created by per on 2019/11/28.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MemberCell : UICollectionViewCell
@property(nonatomic,strong)UILabel * moneyLable;
@property(nonatomic,strong)UILabel * nameLable;
@property(nonatomic,strong)UILabel * yaunLable;
@property(nonatomic,strong)UIButton * imgBtn;
@property(nonatomic,strong)VipModel * model;
@end

NS_ASSUME_NONNULL_END
