//
//  WalletModel.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "WalletModel.h"

@implementation WalletModel
+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"wallID":@"id"};
}
@end
