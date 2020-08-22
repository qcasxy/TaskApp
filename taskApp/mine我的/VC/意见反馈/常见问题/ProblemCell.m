//
//  ProblemCell.m
//  taskApp
//
//  Created by per on 2019/11/15.
//  Copyright © 2019 per. All rights reserved.
//

#import "ProblemCell.h"

@implementation ProblemCell

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
//        self.wenImg =[[UIImageView alloc]init];
//        self.wenImg.image =[UIImage imageNamed:@"wen"];
//        [self addSubview:self.wenImg];
//        [self.wenImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self).offset(width(15));
//            make.width.height.mas_equalTo(15);
//            make.top.mas_equalTo(self.mas_top).offset(height(15));
//        }];
//        self.wenLabel =[[UILabel alloc]init];
//        self.wenLabel.textColor = BassColor(0, 0, 0);
//        self.wenLabel.font = VFont;
//        self.wenLabel.numberOfLines=0;
//        [self addSubview:self.wenLabel];
//        [self.wenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.wenImg.mas_right).offset(width(15));
//            make.top.mas_equalTo(self).offset(height(15));
//            make.right.mas_equalTo(self.mas_right).offset(-width(15));
//        }];
        self.daLabel =[[UILabel alloc]init];
        self.daLabel.textColor = BassColor(0, 0, 0);
        self.daLabel.font = [UIFont systemFontOfSize:11];
        self.daLabel.numberOfLines=0;
        [self addSubview:self.daLabel];
        [self.daLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(width(30));
            make.top.mas_equalTo(self).offset(height(15));
            make.right.mas_equalTo(self.mas_right).offset(-width(15));
            make.bottom.mas_equalTo(self.mas_bottom).offset(-height(15));
        }];
        
    }
    return self;
}
-(void)chuanZhiMineModel:(MineModel *)model{
   
    self.daLabel.text = model.content;
}
@end
