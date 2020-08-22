
//
//  MessageCell.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

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
        self.img =[[UIImageView alloc]init];
        self.img.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(height(60));
            make.width.mas_equalTo(height(60));
            make.left.mas_equalTo(self.mas_left).offset(width(20));
        }];
        self.img.layer.masksToBounds = YES;
        self.img.layer.cornerRadius = height(30);
        self.nameLable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFang-SC-Medium", height(17)) textAlignmen:NSTextAlignmentLeft text:@"name"];
        [self addSubview:self.nameLable];
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.img.mas_right).offset(width(10));
            make.centerY.mas_equalTo(self.mas_centerY).offset(-height(15));
            make.right.mas_equalTo(self.mas_right).offset(-width(35));
            make.height.mas_equalTo(height(height(18)));
        }];
        
        self.commtLable =[HttpTool createLable:BassColor(110,110,110) font:VPFont(@"PingFang-SC-Medium", height(15)) textAlignmen:NSTextAlignmentLeft text:@"福内容"];
        [self addSubview:self.commtLable];
        [self.commtLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.img.mas_right).offset(width(10));
            make.centerY.mas_equalTo(self.mas_centerY).offset(height(15));
            make.right.mas_equalTo(self.mas_right).offset(-width(35));
            make.height.mas_equalTo(height(height(18)));
        }];
    }
    return self;
}
-(void)chuanZhiMessageModel:(MessageModel*)model{
    self.nameLable.text= model.name;
    self.commtLable.text = model.commit;
     self.img.image =[UIImage imageNamed:model.img];
}
@end
