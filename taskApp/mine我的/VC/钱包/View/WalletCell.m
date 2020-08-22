//
//  WalletCell.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "WalletCell.h"

@implementation WalletCell

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
        self.leftlable=[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentLeft text:@""];
        [self addSubview:self.leftlable];
        [self.leftlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
            make.centerY.mas_equalTo(self.mas_centerY).offset(-height(15));
            make.height.mas_equalTo(height(15));
            make.width.mas_equalTo(kScreenWidth/2-width(15));
        }];
        self.leftlable1=[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentLeft text:@""];
        [self addSubview:self.leftlable1];
        [self.leftlable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
            make.centerY.mas_equalTo(self.mas_centerY).offset(height(15));
            make.height.mas_equalTo(height(15));
            make.width.mas_equalTo(kScreenWidth/2-width(15));
        }];
        self.rightlable=[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentRight text:@""];
        [self addSubview:self.rightlable];
        [self.rightlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-width(15));
            make.centerY.mas_equalTo(self.mas_centerY).offset(-height(15));
            make.height.mas_equalTo(height(15));
            make.width.mas_equalTo(kScreenWidth/2-width(15));
        }];
        self.rightlable1=[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentRight text:@""];
        [self addSubview:self.rightlable1];
        [self.rightlable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-width(15));
            make.centerY.mas_equalTo(self.mas_centerY).offset(height(15));
            make.height.mas_equalTo(height(15));
            make.width.mas_equalTo(kScreenWidth/2-width(15));
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
    self.leftlable.text = model.type;
    self.rightlable.text = [NSString stringWithFormat:@"%@%@",model.symbol,model.price];
    self.leftlable1.text = model.addtime;
    self.rightlable1.text = [NSString stringWithFormat:@"剩余余额:%@",model.money];
}
@end
