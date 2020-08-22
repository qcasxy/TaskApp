

//
//  TaskDetailCell1.m
//  taskApp
//
//  Created by per on 2019/11/12.
//  Copyright © 2019 per. All rights reserved.
//

#import "TaskDetailCell1.h"

@implementation TaskDetailCell1

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
        self.timelable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFang-SC-Medium", height(13)) textAlignmen:NSTextAlignmentLeft text:@"截止时间：2019-02-12 12:00"];
        [self addSubview:self.timelable];
        [self.timelable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(width(10));
            make.right.mas_equalTo(self.mas_right).offset(-width(10));
            make.top.mas_equalTo(self).offset(height(10));
        }];
        UILabel * renLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFang-SC-Medium", height(13)) textAlignmen:NSTextAlignmentLeft text:@"任务要求:"];
        [self addSubview:renLable];
        [renLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(width(10));
            make.width.mas_equalTo(width(75));
            make.top.mas_equalTo(self.timelable.mas_bottom).offset(height(10));
        }];
        self.comtlable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFang-SC-Medium", height(13)) textAlignmen:NSTextAlignmentLeft text:@"1、点赞完关注请不要取消，请发送截图提交审核；"];
        self.comtlable.numberOfLines=0;
        [self addSubview:self.comtlable];
        [self.comtlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(renLable.mas_right).offset(width(10));
            make.right.mas_equalTo(self.mas_right).offset(-width(10));
            make.top.mas_equalTo(self.timelable.mas_bottom).offset(height(10));
            make.bottom.mas_equalTo(self.mas_bottom).offset(-height(10));
        }];
    }
    return self;
}
-(void)setDatadic:(NSDictionary *)datadic{
    self.timelable.text = [NSString stringWithFormat:@"截止时间：%@",datadic[@"cuttime"]];
    NSString * descStr;
    descStr=@"";
    for (int i=0; i<[datadic[@"desc"] count]; i++) {
        NSString * str =[NSString stringWithFormat:@"%@,",datadic[@"desc"][i]];
        descStr =[NSString stringWithFormat:@"%@%@",descStr,str];
    }
    if ([descStr rangeOfString:@","].location !=NSNotFound) {
        self.comtlable.text = [NSString stringWithFormat:@"%@",[descStr stringByReplacingOccurrencesOfString:@"," withString:@";\n"]];
    }else if ([descStr rangeOfString:@"，"].location !=NSNotFound){
        self.comtlable.text = [NSString stringWithFormat:@"%@",[descStr stringByReplacingOccurrencesOfString:@"，" withString:@";\n"]];
    }else{
        self.comtlable.text =descStr;
    }
}
@end
