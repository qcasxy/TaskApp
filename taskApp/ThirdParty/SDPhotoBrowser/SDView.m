//
//  SDView.m
//  RedEnvelope
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "SDView.h"

@implementation SDView
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.quBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.quBtn.backgroundColor = [UIColor whiteColor];
        [self.quBtn setTitle:@"取消" forState:0];
        [self.quBtn setTitleColor:BassColor(51, 51, 51) forState:0];
        [self addSubview:self.quBtn];
        [self.quBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(height(45));
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        self.baoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.baoBtn.backgroundColor = [UIColor whiteColor];
        [self.baoBtn setTitle:@"保存" forState:0];
        [self.baoBtn setTitleColor:BassColor(51, 51, 51) forState:0];
        [self addSubview:self.baoBtn];
        [self.baoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(height(45));
            make.bottom.mas_equalTo(self.quBtn.mas_top).offset(-1);
        }];
        self.shiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shiBtn.backgroundColor = [UIColor whiteColor];
        [self.shiBtn setTitle:@"识别二维码" forState:0];
        [self.shiBtn setTitleColor:BassColor(51, 51, 51) forState:0];
        [self addSubview:self.shiBtn];
        [self.shiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(height(45));
            make.bottom.mas_equalTo(self.baoBtn.mas_top).offset(-1);
        }];
        self.erLable = [[UILabel alloc]init];
        self.erLable.textColor = BassColor(51, 51, 51);
        self.erLable.backgroundColor = [UIColor whiteColor];
        self.erLable.font =VFont;
        self.erLable.text = @"图片操作";
        self.erLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.erLable];
        [self.erLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(height(45));
            make.bottom.mas_equalTo(self.shiBtn.mas_top).offset(-1);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
