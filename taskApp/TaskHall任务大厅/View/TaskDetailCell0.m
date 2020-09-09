//
//  TaskDetailCell0.m
//  taskApp
//
//  Created by per on 2019/11/12.
//  Copyright © 2019 per. All rights reserved.
//

#import "TaskDetailCell0.h"

@implementation TaskDetailCell0

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
         self.name=[[HGOrientationLabel alloc]init];
        self.name.textColor = BassColor(0,0,0);
        self.name.backgroundColor = UIColor.whiteColor;
        self.name.font = VPFont(@"PingFang-SC-Medium", height(15));
        self.name.text = @"郑州市郑东新区财信大厦409[20190820上午]郑州市郑东新区财信大厦409[20190820上午]";
        self.name.numberOfLines =0;
        self.name.textAlignment = NSTextAlignmentLeft;
        [self.name textAlign:^(HGMaker *make) {
            make.addAlignType(textAlignType_left).addAlignType(textAlignType_top);
        }];
        [self addSubview:self.name];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(height(10));
            make.left.mas_equalTo(self.mas_left).offset(width(10));
            make.right.mas_equalTo(self.mas_right).offset(-width(10));
        }];
        self.leftlable =[[UILabel alloc]init];
        self.leftlable.textColor=BassColor(51, 51, 51);
        self.leftlable.text=@"任务详情-任务上传";
        self.leftlable.font =VPFont(@"PingFang-SC-Medium", height(12));
        [self addSubview:self.leftlable];
        [self.leftlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(10));
            make.top.mas_equalTo(self.name.mas_bottom).offset(height(10));
            make.bottom.mas_equalTo(self.mas_bottom).offset(-height(10));
//            make.height.mas_equalTo(height(18));
            make.width.mas_equalTo(kScreenWidth/2);
        }];
        self.rightlable =[[UILabel alloc]init];
        self.rightlable.text=@"需要人数：20人";
        self.rightlable.textColor=BassColor(51, 51, 51);
        self.rightlable.font =VPFont(@"PingFang-SC-Medium", height(12));
        self.rightlable.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.rightlable];
        [self.rightlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-width(10));
            make.bottom.mas_equalTo(self.mas_bottom).offset(-height(10));
            make.top.mas_equalTo(self.name.mas_bottom).offset(height(10));
            make.width.mas_equalTo(kScreenWidth/2);
        }];
    }
    return self;
}
-(void)setDatadic:(NSDictionary *)datadic{
    self.name.text = datadic[@"title"];
    self.leftlable.text = [NSString stringWithFormat:@"奖励：%@",datadic[@"money"]];
    if ([datadic[@"cateid"] intValue]==2) {
        self.rightlable.text = [NSString stringWithFormat:@"需要人数：%d/%@",[datadic[@"num"] intValue]-[datadic[@"surplus"] intValue],datadic[@"num"]];
    }else if([datadic[@"cateid"] intValue]==3){
         self.rightlable.text = [NSString stringWithFormat:@"需要人数：%d/%@",[datadic[@"num"] intValue]-[datadic[@"surplus"] intValue],datadic[@"num"]];
    }else{
        self.rightlable.text = [NSString stringWithFormat:@"需要人数：%d/%@",[datadic[@"num"] intValue]-[datadic[@"surplus"] intValue],datadic[@"num"]];
    }
}
@end
