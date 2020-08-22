
//
//  MemberCell.m
//  CartoonApp
//
//  Created by per on 2019/11/28.
//  Copyright © 2019 per. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.layer.borderColor = BassColor(241,241,241).CGColor;
        self.layer.borderWidth=1;
        self.moneyLable =[HttpTool createLable:BassColor(233, 174, 87) font:VPFont(@"PingFangSC-Regular", height(30)) textAlignmen:NSTextAlignmentCenter text:@"￥128"];
        self.moneyLable.adjustsFontSizeToFitWidth=YES;
        [self addSubview:self.moneyLable];
        [self.moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY).offset(height(30));
            make.right.left.mas_equalTo(self);
             make.height.mas_equalTo(20);
        }];
        self.nameLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", height(16)) textAlignmen:NSTextAlignmentCenter text:@"1个月"];
        
        [self addSubview:self.nameLable];
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-height(30));
            make.right.left.mas_equalTo(self);
             make.height.mas_equalTo(20);
        }];
        self.imgBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_imgBtn setBackgroundImage:[UIImage imageNamed:@"tuixin"] forState:0];
        _imgBtn.hidden=YES;
        [_imgBtn setTitle:@"推荐" forState:0];
        [_imgBtn setTitleColor:UIColor.whiteColor forState:0];
        _imgBtn.titleLabel.font =[UIFont systemFontOfSize:11];
        [self addSubview:_imgBtn];
        [_imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top).offset(height(0));
            make.height.mas_equalTo(height(21));
            make.width.mas_equalTo(width(38.5));
        }];
//        self.yaunLable =[HttpTool createLable:BassColor(153, 153, 153) font:VPFont(@"PingFangSC-Regular", height(12)) textAlignmen:NSTextAlignmentCenter text:@"20元/月"];
//
//        [self addSubview:self.yaunLable];
//        [self.yaunLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_centerX);
//            make.top.mas_equalTo(self.moneyLable.mas_bottom).offset(height(20));
//            make.right.left.mas_equalTo(self);
//            make.height.mas_equalTo(20);
//        }];
//        UIView * line =[[UIView alloc]init];
//        line.backgroundColor =BassColor(153, 153, 153);
//        [self addSubview:line];
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.mas_centerX);
//            make.centerY.mas_equalTo(self.yaunLable.mas_centerY);
//            make.width.mas_equalTo(height(50));
//            make.height.mas_equalTo(1);
//        }];
    }
    return self;
}
-(void)setModel:(VipModel *)model{
    self.moneyLable.text = [NSString stringWithFormat:@"￥%@",model.money];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.moneyLable.text];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,1)];
    self.moneyLable.attributedText = str;
    self.nameLable.text =[NSString stringWithFormat:@"%@",model.name];
    self.yaunLable.text = @"";
}
@end
