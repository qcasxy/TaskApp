//
//  ListModel.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel
+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"listID":@"id",@"label":@"LableModel"};
}
@end
