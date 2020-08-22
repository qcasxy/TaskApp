//
//  YJDetailCell.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "YJDetailCell.h"

@implementation YJDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftLable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentCenter text:@"任务1：19元"];
        [self addSubview:self.leftLable];
        self.leftLable.font = [UIFont systemFontOfSize:18];
        self.leftLable.adjustsFontSizeToFitWidth=YES;
        [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(0));
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(height(18));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        self.centerLable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentCenter text:@"获取佣金8元"];
        self.centerLable.font = [UIFont systemFontOfSize:18];
        self.centerLable.adjustsFontSizeToFitWidth=YES;
        [self addSubview:self.centerLable];
        [self.centerLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftLable.mas_right).offset(0);
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(height(18));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        self.rightLable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentCenter text:@"任务1：19元"];
        self.rightLable.adjustsFontSizeToFitWidth=YES;
        self.rightLable.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.rightLable];
        [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.centerLable.mas_right).offset(width(0));
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(height(18));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        self.rightLable1 =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentCenter text:@"任务1：19元"];
        self.rightLable1.adjustsFontSizeToFitWidth=YES;
         self.rightLable1.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.rightLable1];
        [self.rightLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.rightLable.mas_right).offset(width(0));
            make.width.mas_equalTo(kScreenWidth/4);
            make.height.mas_equalTo(height(18));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        UIView * line =[[UIView alloc]init];
        line.backgroundColor = BassColor(241, 241, 241);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return self;
}
-(void)chuanzhiWalletModel:(WalletModel*)model{
    self.leftLable.text = [NSString stringWithFormat:@"%@",model.userid];
    self.centerLable.text = [NSString stringWithFormat:@"%@",model.name];
    self.rightLable.text = [NSString stringWithFormat:@"%@",model.price];
    self.rightLable1.text = [NSString stringWithFormat:@"%@",model.addtime];
}
@end
