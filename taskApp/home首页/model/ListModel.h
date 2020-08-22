//
//  ListModel.h
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LableModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ListModel : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * money;
@property(nonatomic,copy)NSString * status;
@property(nonatomic,strong)NSArray * label;
@property(nonatomic,copy)NSString * listID;
@property(nonatomic,copy)NSString * addtime;
@end

NS_ASSUME_NONNULL_END
