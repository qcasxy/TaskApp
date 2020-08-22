//
//  VipCell.m
//  taskApp
//
//  Created by per on 2019/11/13.
//  Copyright © 2019 per. All rights reserved.
//

#import "VipCell.h"

@implementation VipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.img=[[UIImageView alloc]init];
        self.img.image =[UIImage imageNamed:@"anniu"];
        self.img.hidden=YES;
        [self addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(width(300));
            make.height.mas_equalTo(height(40));
        }];
        self.ceterLable =[HttpTool createLable:BassColor(224, 179, 112) font:VPFont(@"PingFangSC-Regular", height(13)) textAlignmen:NSTextAlignmentCenter text:@"12332"];
        [self addSubview:self.ceterLable];
        [self.ceterLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(width(300));
            make.height.mas_equalTo(height(40));
        }];
         self.ceterLable.layer.masksToBounds =YES;
         self.ceterLable.layer.cornerRadius = height(20);
         self.ceterLable.layer.borderWidth=1;
         self.ceterLable.layer.borderColor = BassColor(224, 179, 112).CGColor;
        
    }
    return self;
}
@end
