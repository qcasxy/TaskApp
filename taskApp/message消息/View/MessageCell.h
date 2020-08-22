//
//  MessageCell.h
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : UITableViewCell
@property(nonatomic,strong)UIImageView * img;
@property(nonatomic,strong)UILabel * nameLable;
@property(nonatomic,strong)UILabel * commtLable;
-(void)chuanZhiMessageModel:(MessageModel*)model;
@end

NS_ASSUME_NONNULL_END
