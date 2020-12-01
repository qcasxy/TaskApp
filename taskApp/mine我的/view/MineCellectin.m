

//
//  MineCellectin.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "MineCellectin.h"

@implementation MineCellectin
-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.img =[[UIImageView alloc]init];
        self.img.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self).offset(height(14));
            make.width.height.mas_equalTo(height(35));
        }];
        self.name = [HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", height(11)) textAlignmen:NSTextAlignmentCenter text:@"我的接单"];
        [self addSubview:self.name];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-height(14));
            make.height.mas_equalTo(height(11));
            make.width.mas_equalTo(width(70));
        }];
    }
    return self;
}
-(void)chuanZhiMineModel:(MineModel*)model{
    self.name.text = model.name;
    self.img.image=[UIImage imageNamed:model.img];
}
@end
