//
//  TaskCell.m
//  taskApp
//
//  Created by per on 2019/11/15.
//  Copyright © 2019 per. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.lab =[[UILabel alloc]init];
        self.lab.textAlignment = NSTextAlignmentCenter;
        self.lab.textColor = BassColor(127, 127, 127);
        self.lab.font =[UIFont systemFontOfSize:13];
        [self addSubview:self.lab];
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(height(25));
            make.width.mas_equalTo(width(75));
        }];
        self.lab.layer.masksToBounds = YES;
        self.lab.layer.cornerRadius=height(12.5);
        self.lab.layer.borderColor =BassColor(127, 127, 127).CGColor;
        self.lab.layer.borderWidth =1;
    }
    return self;
}
@end
