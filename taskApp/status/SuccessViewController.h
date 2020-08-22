//
//  SuccessViewController.h
//  taskApp
//
//  Created by per on 2019/11/14.
//  Copyright © 2019 per. All rights reserved.
//

#import "BassMianViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SuccessViewController : BassMianViewController
@property(nonatomic,copy)NSString* imgName;
@property(nonatomic,copy)NSString* status;
@property(nonatomic,copy)NSString* beiZhu;
@property(nonatomic,copy)NSString* btnStr;
@property(nonatomic,assign)int indexType;
@end

NS_ASSUME_NONNULL_END
