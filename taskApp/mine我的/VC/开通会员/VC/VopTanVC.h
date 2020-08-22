//
//  VopTanVC.h
//  taskApp
//
//  Created by per on 2019/11/11.
//  Copyright © 2019 per. All rights reserved.
//

#import "BassMianViewController.h"
#import "VipModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol VopTanVCDelegate <NSObject>

@optional
-(void)goToViewControllerVC;
-(void)goToViewControllerFailVC;
@end
@interface VopTanVC : BassMianViewController
@property(nonatomic,copy)NSString * titleStr;
@property(nonatomic,strong)VipModel * tanModel;
@property(nonatomic,weak)id<VopTanVCDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
