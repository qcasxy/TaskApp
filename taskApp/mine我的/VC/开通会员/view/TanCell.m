//
//  TanCell.m
//  taskApp
//
//  Created by per on 2019/11/11.
//  Copyright © 2019 per. All rights reserved.
//

#import "TanCell.h"

@implementation TanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftImg =[[UIImageView alloc]init];
        self.leftImg.backgroundColor =UIColor.whiteColor;
        [self addSubview:self.leftImg];
        [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(width(40));
            make.height.mas_equalTo(height(40));
        }];
        self.nameLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFang-SC-Medium", height(14)) textAlignmen:NSTextAlignmentLeft text:@"name"];
        [self addSubview:self.nameLable];
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.leftImg.mas_right).offset(width(15));
            make.width.mas_equalTo(width(140));
            make.height.mas_equalTo(height(25));
        }];
        self.rightImg=[[UIImageView alloc]init];
        self.rightImg.backgroundColor =UIColor.whiteColor;
        self.rightImg.image =[UIImage imageNamed:@"jinru"];
        [self addSubview:self.rightImg];
        [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-width(15));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(width(13));
            make.height.mas_equalTo(height(12.5));
        }];
    }
    return self;
}
@end
