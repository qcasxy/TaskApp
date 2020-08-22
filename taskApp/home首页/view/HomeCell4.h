//
//  HomeCell4.h
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LableModel.h"
#import "ListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCell4 : UICollectionViewCell
@property(nonatomic,strong)UILabel  * numLable;
@property(nonatomic,strong)UILabel  * nameLable;
@property(nonatomic,strong)UILabel  * timeLable;
@property(nonatomic,strong)UIImageView  * biImg;
@property(nonatomic,strong)UILabel  * moneyLable;
@property(nonatomic,strong)UIButton  * statusBtn;
-(void)chuanZhiListModel:(ListModel*)model modelArr:(NSMutableArray*)modelArr;
@end

NS_ASSUME_NONNULL_END
