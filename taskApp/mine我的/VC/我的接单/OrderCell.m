//
//  OrderCell.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

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
        self.nameLable=[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Medium", height(14)) textAlignmen:NSTextAlignmentLeft text:@"标题标题标题标题标题标题标题标题标题"];
        [self addSubview:self.nameLable];
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.numLable.mas_right).offset(width(15));
            make.centerY.mas_equalTo(self.numLable.mas_centerY);
            make.width.mas_equalTo(kScreenWidth/2+width(30));
            make.height.mas_equalTo(height(16));
        }];
        self.statsLable=[HttpTool createLable:BassColor(17, 151, 255) font:VFont textAlignmen:NSTextAlignmentRight text:@"等待"];
        [self addSubview:self.statsLable];
        [self.statsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-width(15));
            make.centerY.mas_equalTo(self.numLable.mas_centerY);
            make.left.mas_equalTo(self.nameLable.mas_right).offset(3);
            make.height.mas_equalTo(height(16));
        }];
        self.timeLable=[HttpTool createLable:BassColor(102, 102, 102) font:VPFont(@"PingFangSC-Regular", height(11)) textAlignmen:NSTextAlignmentLeft text:@"2019-09-20 13:45"];
        [self addSubview:self.timeLable];
        [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
            make.centerY.mas_equalTo(self.mas_centerY).offset(height(15));
            make.width.mas_equalTo(width(130));
            make.height.mas_equalTo(height(16));
        }];
        
    }
    return self;
}
-(void)chuanZhiListModel:(ListModel*)model modelArr:(NSMutableArray*)modelArr{
    
    for (int i=0; i<modelArr.count; i++) {
        LableModel*lModel=modelArr[i];
        self.statusBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        self.statusBtn.frame = CGRectMake(width(155)+(3-modelArr.count)*width(80)+i*width(75), height(43), width(60), height(20));
        self.statusBtn.titleLabel.font = [UIFont systemFontOfSize:height(14)];
        [self.statusBtn setTitle:[NSString stringWithFormat:@"%@",lModel.name] forState:0];
        [self.statusBtn setTitleColor:UIColor.whiteColor forState:0];
        self.statusBtn.backgroundColor =[UIColor colorWithHexString:lModel.color];
        [self addSubview:self.statusBtn];
    }
    self.nameLable.text = model.title;
    if ([model.status intValue]==1) {
        self.statsLable.text = @"待提交";
    }else if ([model.status intValue]==2) {
        self.statsLable.text =@"审核中";
    }else if ([model.status intValue]==3) {
        self.statsLable.text = @"不合格";
    }else{
       self.statsLable.text = @"已完成";
    }
    
}
@end
