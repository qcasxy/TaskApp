//
//  BindPhoneVC.h
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "BassMianViewController.h"
#import <UMShare/UMShare.h>
NS_ASSUME_NONNULL_BEGIN

@interface BindPhoneVC : BassMianViewController
@property(nonatomic,strong)UMSocialUserInfoResponse *resp;
@end

NS_ASSUME_NONNULL_END
