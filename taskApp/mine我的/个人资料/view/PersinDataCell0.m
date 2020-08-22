//
//  PersinDataCell0.m
//  taskApp
//
//  Created by per on 2019/11/13.
//  Copyright © 2019 per. All rights reserved.
//

#import "PersinDataCell0.h"
#import "UIButton+LXMImagePosition.h"
@interface PersinDataCell0 ()<UITextFieldDelegate>
{
    UIButton * boyBtn;
    UIButton * NVBtn;
}
@property(nonatomic,strong)UIImageView * touImg;
@property(nonatomic,strong)UITextField * nickField;
@property(nonatomic,copy)NSString * sexStr;
@end
@implementation PersinDataCell0

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
        
        UILabel *leftLable1 =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", height(14)) textAlignmen:NSTextAlignmentLeft text:@"昵称"];
        [self addSubview:leftLable1];
        [leftLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
         make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(width(120));
            make.height.mas_equalTo(height(50));
        }];
        self.nickField =[HttpTool createField:@"请输入您要修改的昵称" font:VPFont(@"PingFangSC-Regular", height(14)) color:BassColor(51, 51, 51) ishidden:NO];
        
         [self.nickField addTarget:self action:@selector(edit) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.nickField];
        [self.nickField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftLable1.mas_right).offset(width(10));
            make.centerY.mas_equalTo(leftLable1.mas_centerY);
            make.width.mas_equalTo(width(180));
            make.height.mas_equalTo(height(50));
        }];
        
        UILabel *leftLable2 =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", height(14)) textAlignmen:NSTextAlignmentLeft text:@"性别"];
        [self addSubview:leftLable2];
        [leftLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(15));
            make.top.mas_equalTo(leftLable1.mas_bottom);
            make.width.mas_equalTo(width(120));
            make.height.mas_equalTo(height(50));
        }];
        
        
        boyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [boyBtn setTitle:@"男" forState:0];
        boyBtn.backgroundColor =UIColor.whiteColor;
        boyBtn.titleLabel.font =[UIFont systemFontOfSize:11];
        [boyBtn setTitleColor:BassColor(153, 153, 153) forState:0];
       
        [self addSubview:boyBtn];
        [boyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftLable2.mas_right).offset(width(10));
            make.height.mas_equalTo(height(16));
            make.width.mas_equalTo(width(30));
            make.centerY.mas_equalTo(leftLable2.mas_centerY);
        }];
        boyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
       boyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        
        boyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        boyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        
        [boyBtn setImagePosition:LXMImagePositionLeft spacing:5];
        NVBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [NVBtn setTitle:@"女" forState:0];
        NVBtn.backgroundColor =UIColor.whiteColor;
        NVBtn.titleLabel.font =[UIFont systemFontOfSize:11];
        [NVBtn setTitleColor:BassColor(153, 153, 153) forState:0];
        
        
        [self addSubview:NVBtn];
        [NVBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->boyBtn.mas_right).offset(width(40));
            make.height.mas_equalTo(height(16));
            make.width.mas_equalTo(width(30));
            make.centerY.mas_equalTo(leftLable2.mas_centerY);
        }];
        NVBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        NVBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        
        NVBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
       NVBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        
        [NVBtn setImagePosition:LXMImagePositionLeft spacing:5];
        [[boyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self->boyBtn setImage:[UIImage imageNamed:@"sexXuan"] forState:0];
            [self->NVBtn setImage:[UIImage imageNamed:@"sexWei"] forState:0];
            self.sexStr = @"1";
            if (self.delegate&&[self.delegate respondsToSelector:@selector(chuanZhiNick:andSex:)]) {
                [self.delegate chuanZhiNick:self.nickField.text andSex:self.sexStr];
            }
        }];
        [[NVBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self->boyBtn setImage:[UIImage imageNamed:@"sexWei"] forState:0];
            [self->NVBtn setImage:[UIImage imageNamed:@"sexXuan"] forState:0];
            self.sexStr = @"2";
            if (self.delegate&&[self.delegate respondsToSelector:@selector(chuanZhiNick:andSex:)]) {
                [self.delegate chuanZhiNick:self.nickField.text andSex:self.sexStr];
            }
        }];
    }
    return self;
}
-(void)setDataDic:(NSDictionary *)dataDic{
    self.sexStr =[NSString stringWithFormat:@"%@",dataDic[@"sex"]];
    if ([dataDic[@"sex"] intValue]==1) {
        [boyBtn setImage:[UIImage imageNamed:@"sexXuan"] forState:0];
        [NVBtn setImage:[UIImage imageNamed:@"sexWei"] forState:0];
    }else{
        [boyBtn setImage:[UIImage imageNamed:@"sexWei"] forState:0];
        [NVBtn setImage:[UIImage imageNamed:@"sexXuan"] forState:0];
    }
   
    self.nickField.text = dataDic[@"nickname"];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(chuanZhiNick:andSex:)]) {
        [self.delegate chuanZhiNick:self.nickField.text andSex:self.sexStr];
    }
}

-(void)edit{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(chuanZhiNick:andSex:)]) {
        [self.delegate chuanZhiNick:self.nickField.text andSex:self.sexStr];
    }
}
@end
