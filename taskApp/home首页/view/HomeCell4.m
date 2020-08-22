//
//  HomeCell4.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "HomeCell4.h"
#import "UIColor+Wrapper.h"
@implementation HomeCell4
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView * backImg =[[UIImageView alloc]init];
        backImg.image =[UIImage imageNamed:@"sibian"];
        [self addSubview:backImg];
        [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
            make.centerY.mas_equalTo(self.mas_centerY).offset(-height(15));
            make.width.mas_equalTo(width(39));
            make.height.mas_equalTo(height(14));
        }];
        self.numLable=[HttpTool createLable:UIColor.whiteColor font:VFont textAlignmen:NSTextAlignmentCenter text:@"03"];
        [self addSubview:self.numLable];
        [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backImg.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-height(15));
            make.width.mas_equalTo(width(39));
            make.height.mas_equalTo(height(16));
        }];
        
        self.nameLable=[HttpTool createLable:BassColor(51, 51, 51) font:VFont textAlignmen:NSTextAlignmentLeft text:@"标题标题标题标题标题标题标题标题标题"];
        [self addSubview:self.nameLable];
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.numLable.mas_right).offset(width(15));
            make.centerY.mas_equalTo(self.numLable.mas_centerY);
            make.width.mas_equalTo(kScreenWidth/2+width(30));
            make.height.mas_equalTo(height(16));
        }];
        self.biImg =[[UIImageView alloc]init];
        self.biImg.image =[UIImage imageNamed:@"jinbi"];
        self.biImg.backgroundColor =UIColor.clearColor;
        [self addSubview:self.biImg];
        [self.biImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.nameLable.mas_centerY);
            make.height.mas_equalTo(height(20));
            make.width.mas_equalTo(height(20));
            make.right.mas_equalTo(self.mas_right).offset(-width(10));
        }];
        self.moneyLable=[HttpTool createLable:BassColor(249, 171, 16) font:VFont textAlignmen:NSTextAlignmentRight text:@"10"];
        [self addSubview:self.moneyLable];
        [self.moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.biImg.mas_left).offset(-width(5));
            make.centerY.mas_equalTo(self.numLable.mas_centerY);
            make.left.mas_equalTo(self.nameLable.mas_right).offset(3);
            make.height.mas_equalTo(height(16));
        }];
        self.timeLable=[HttpTool createLable:BassColor(102, 102, 102) font:VFont textAlignmen:NSTextAlignmentLeft text:@"2019-09-20 13:45"];
        [self addSubview:self.timeLable];
        [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
            make.centerY.mas_equalTo(self.mas_centerY).offset(height(25));
            make.width.mas_equalTo(width(130));
            make.height.mas_equalTo(height(16));
        }];
        UIView * line =[[UIView alloc]init];
        line.backgroundColor = BassColor(241, 241, 241);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
//        for (int i=0; i<3; i++) {
//            self.statusBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//            self.statusBtn.frame = CGRectMake(width(155)+(3-3)*width(80)+i*width(75), height(40), width(60), height(25));
//            self.statusBtn.backgroundColor =UIColor.redColor;
//            [self addSubview:self.statusBtn];
//        }
    }
    return self;
}
-(void)chuanZhiListModel:(ListModel*)model modelArr:(NSMutableArray*)modelArr{
    for (UIView * subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i=0; i<modelArr.count; i++) {
        LableModel * lModel =modelArr[i];
      
        self.statusBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        self.statusBtn.frame = CGRectMake(width(155)+(3-modelArr.count)*width(70)+i*width(75), height(55), width(60), height(20));
        self.statusBtn.titleLabel.font = [UIFont systemFontOfSize:height(14)];
        [self.statusBtn setTitle:[NSString stringWithFormat:@"%@",lModel.name] forState:0];
        [self.statusBtn setTitleColor:UIColor.whiteColor forState:0];
        self.statusBtn.backgroundColor =[UIColor colorWithHexString:lModel.color];
        [self addSubview:self.statusBtn];
    }
    self.timeLable.text = model.addtime;
    self.nameLable.text = model.title;
    self.moneyLable.text = [NSString stringWithFormat:@"%@",model.money];
}
@end
