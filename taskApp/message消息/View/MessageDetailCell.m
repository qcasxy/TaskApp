//
//  MessageDetailCell.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "MessageDetailCell.h"

@implementation MessageDetailCell

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
        UIView * backView =[[UIView alloc]init];
        backView.backgroundColor =UIColor.whiteColor;
        [self addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(height(100));
            make.width.mas_equalTo(width(335));
        }];
        backView.layer.masksToBounds =YES;
        backView.layer.cornerRadius = height(15);
        self.img =[[UIImageView alloc]init];
        self.img.image =[UIImage imageNamed:@"notice"];
        [backView addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(backView).offset(width(15));
            make.top.mas_equalTo(backView.mas_top).offset(height(10));
            make.width.mas_equalTo(width(19.5));
            make.height.mas_equalTo(height(18));
        }];
        
        self.titlelable =[HttpTool createLable:BassColor(153, 153, 153) font:VPFont(@"PingFang-SC-Medium", height(14)) textAlignmen:NSTextAlignmentLeft text:@"系统通知"];
        [backView addSubview:self.titlelable];
        [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(backView.mas_right).offset(-width(15));
            make.height.mas_equalTo(height(16));
            make.centerY.mas_equalTo(self.img.mas_centerY);
            make.left.mas_equalTo(self.img.mas_right).offset(width(15));
        }];
        
        self.detaillable =[[HGOrientationLabel alloc]init];
        self.detaillable.textColor = BassColor(102, 102, 102);
        self.detaillable.font = VPFont(@"PingFang-SC-Medium", height(13));
        self.detaillable.text = @"您已成功指派订单（单号2019082014160501）给王五，服务地址：郑州市郑东新区财信大厦409 [20190820上午]";
        self.detaillable.numberOfLines =3;
        [self.detaillable textAlign:^(HGMaker *make) {
            make.addAlignType(textAlignType_left).addAlignType(textAlignType_top);
        }];
        [backView addSubview:self.detaillable];
        [self.detaillable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(backView).offset(width(15));
            make.right.mas_equalTo(backView.mas_right).offset(-width(15));
            make.top.mas_equalTo(self.img.mas_bottom).offset(height(5));
            make.bottom.mas_equalTo(self.mas_bottom).offset(-height(5));
        }];
    }
    return self;
}
-(void)chuanZhiMessageModel:(MessageModel*)model{
    self.detaillable.text = model.content;
    //self.img.image =[UIImage imageNamed:model.img];
}
@end
