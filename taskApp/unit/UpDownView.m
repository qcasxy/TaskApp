
//
//  UpDownView.m
//  全民帮
//
//  Created by per on 2019/10/23.
//  Copyright © 2019 二恒. All rights reserved.
//

#import "UpDownView.h"

@implementation UpDownView

-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.upLable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"DIN-Medium", height(16)) textAlignmen:NSTextAlignmentCenter text:@"123"];
        [self addSubview:self.upLable];
        [self.upLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-height(15));
            make.height.mas_equalTo(height(20));
        }];
        self.downLable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFang-SC-Medium", height(12)) textAlignmen:NSTextAlignmentCenter text:@"总"];
        [self addSubview:self.downLable];
        [self.downLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.centerY.mas_equalTo(self.mas_centerY).offset(height(15));
            make.height.mas_equalTo(height(20));
        }];
    }
    return self;
}

@end
