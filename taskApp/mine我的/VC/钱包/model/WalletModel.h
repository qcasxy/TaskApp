//
//  WalletModel.h
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletModel : NSObject
@property(nonatomic,copy)NSString * wallID;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * symbol;
@property(nonatomic,copy)NSString * taskid;
@property(nonatomic,copy)NSString * money;
@property(nonatomic,copy)NSString * one;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * addtime;
@property(nonatomic,copy)NSString * userid;
@end

NS_ASSUME_NONNULL_END
