//
//  HomeCell3.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "HomeCell3.h"

@implementation HomeCell3
-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
       
        
        self.titleLable =[HttpTool createLable:BassColor(0, 0, 0) font:VFont textAlignmen:NSTextAlignmentLeft text:@"为您推荐"];
        [self addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
            make.height.mas_equalTo(height(18));
            make.width.mas_equalTo(width(100));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}
@end
