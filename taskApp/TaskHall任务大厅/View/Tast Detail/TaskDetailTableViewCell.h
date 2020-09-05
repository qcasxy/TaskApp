//
//  TaskDetailTableViewCell.h
//  taskApp
//
//  Created by 秦程 on 2020/9/5.
//  Copyright © 2020 per. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskDetailTableViewCell : UITableViewCell

@property(nonatomic, strong)NSDictionary *contentVlaue;

@property(nonatomic, strong)UIButton *fuBtn;
@property(nonatomic, strong)UIControl *goBtn;

@end

NS_ASSUME_NONNULL_END
