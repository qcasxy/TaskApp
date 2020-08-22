//
//  HomeCell1.h
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HomeCell1Delegate <NSObject>

-(void)goToWeb:(NSInteger)index;

@end
@interface HomeCell1 : UICollectionViewCell
@property(nonatomic,strong)NSMutableArray * coverArr;
@property(nonatomic,weak)id<HomeCell1Delegate>delegate;
@end

NS_ASSUME_NONNULL_END
