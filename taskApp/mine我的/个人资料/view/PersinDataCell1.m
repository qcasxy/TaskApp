//
//  PersinDataCell1.m
//  taskApp
//
//  Created by per on 2019/11/13.
//  Copyright © 2019 per. All rights reserved.
//

#import "PersinDataCell1.h"

@implementation PersinDataCell1

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
        self.leftLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", height(14)) textAlignmen:NSTextAlignmentLeft text:@"账号等级"];
        [self addSubview:self.leftLable];
        [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(width(120));
            make.height.mas_equalTo(height(16));
        }];
        self.rightLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", height(14)) textAlignmen:NSTextAlignmentLeft text:@"账号等级"];
        [self addSubview:self.rightLable];
        [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftLable.mas_right).offset(width(10));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(width(120));
            make.height.mas_equalTo(height(16));
        }];
    }
    return self;
}
@end
