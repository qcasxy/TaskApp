//
//  HuiYuanCell.m
//  taskApp
//
//  Created by per on 2019/11/11.
//  Copyright © 2019 per. All rights reserved.
//

#import "HuiYuanCell.h"

@implementation HuiYuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.touImg =[[UIImageView alloc]init];
        self.touImg.backgroundColor =[UIColor orangeColor];
        [self addSubview:self.touImg];
        [self.touImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(width(15));
            make.height.width.mas_equalTo(height(30));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        self.touImg.layer.masksToBounds = YES;
        self.touImg.layer.cornerRadius = height(15);
        self.leftLable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentLeft text:@"任务1：19元"];
        [self addSubview:self.leftLable];
        [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.touImg.mas_right).offset(width(15));
            make.width.mas_equalTo(((kScreenWidth-width(30))-30)/3);
            make.height.mas_equalTo(height(18));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        self.centerLable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentCenter text:@"获取佣金8元"];
        [self addSubview:self.centerLable];
        [self.centerLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftLable.mas_right).offset(width(0));
            make.width.mas_equalTo(((kScreenWidth-width(30))-30)/3);
            make.height.mas_equalTo(height(18));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        self.rightLable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Regular", 14) textAlignmen:NSTextAlignmentRight text:@"任务1：19元"];
        [self addSubview:self.rightLable];
        [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-width(15));
            make.width.mas_equalTo(((kScreenWidth-width(30))-30)/3);
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
-(void)chuanzhiHuiYuanModel:(HuiYuanModel*)model{
    [self.touImg sd_setImageWithURL:[NSURL URLWithString:model.headimg] placeholderImage:nil];
    self.leftLable.text = model.nickname;
    self.centerLable.text = [NSString stringWithFormat:@"ID:%@",model.ID];
    self.rightLable.text = model.phone;
}
@end
