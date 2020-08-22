//
//  PersinDataCell0.h
//  taskApp
//
//  Created by per on 2019/11/13.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PersinDataCell0Delegate <NSObject>

@optional
-(void)chuanZhiNick:(NSString*)nickStr andSex:(NSString*)sexStr;
@end
@interface PersinDataCell0 : UITableViewCell
@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic,weak)id<PersinDataCell0Delegate>delegate;
@end

NS_ASSUME_NONNULL_END
