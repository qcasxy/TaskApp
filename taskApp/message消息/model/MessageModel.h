//
//  MessageModel.h
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * commit;
@property(nonatomic,copy)NSString * img;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * addtime;
@end

NS_ASSUME_NONNULL_END
