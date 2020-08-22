


//
//  TaskDetailCollCell.m
//  taskApp
//
//  Created by per on 2019/11/12.
//  Copyright © 2019 per. All rights reserved.
//

#import "TaskDetailCollCell.h"

@implementation TaskDetailCollCell
-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.img =[[UIImageView alloc]init];
        [self addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self.mas_right).offset(-width(5));
            make.left.mas_equalTo(self.mas_left).offset(width(5));
        }];
    }
    return self;
}
@end
