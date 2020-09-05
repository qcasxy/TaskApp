//
//  TaskDetailTableViewCell.m
//  taskApp
//
//  Created by 秦程 on 2020/9/5.
//  Copyright © 2020 per. All rights reserved.
//

#import "TaskDetailTableViewCell.h"

@interface TaskDetailTableViewCell()

@property(nonatomic, strong)UILabel *flagLabel;
@property(nonatomic, strong)UILabel *detailLable;

@end

@implementation TaskDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _flagLabel = [HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFang-SC-Medium", height(13)) textAlignmen:NSTextAlignmentLeft text:@"任务详情:"];
        [_flagLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_flagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self addSubview:_flagLabel];
        [_flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(10));
        }];
        
        self.detailLable = [HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFang-SC-Medium", height(13)) textAlignmen:NSTextAlignmentLeft text:@""];
        self.detailLable.numberOfLines = 0;
        [self addSubview:self.detailLable];
        [self.detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_flagLabel.mas_right);
            make.right.mas_equalTo(self).inset(width(10)).priority(926);
            make.top.bottom.mas_equalTo(self).inset(width(5));
            make.top.equalTo(_flagLabel);
            make.height.greaterThanOrEqualTo(_flagLabel);
        }];
        
        self.fuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.fuBtn setHidden:YES];
        [self.fuBtn setBackgroundImage:[UIImage imageNamed:@"fuzhi"] forState:0];
        [self addSubview:self.fuBtn];
        [self.fuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_detailLable.mas_right).offset(width(5.0));
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).inset(width(10.0)).priority(925);
            make.width.mas_equalTo(width(18.0));
            make.height.mas_equalTo(height(19.5));
        }];
        
        self.goBtn = [[UIControl alloc] init];
        [self addSubview:self.goBtn];
        [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_detailLable);
        }];
    }
    return self;
}

- (void)setContentVlaue:(NSDictionary *)contentVlaue {
    if ([contentVlaue.allKeys.firstObject containsString:@"下载"]) {
        [self.goBtn setEnabled:YES];
        [self.fuBtn setHidden:NO];
        [self.fuBtn setEnabled:YES];
        [self.fuBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).inset(width(10.0)).priority(927);
        }];
    }else {
        [self.goBtn setEnabled:NO];
        [self.fuBtn setHidden:YES];
        [self.fuBtn setEnabled:NO];
        [self.fuBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).inset(width(10.0)).priority(925);
        }];
    }
    
    _flagLabel.text = contentVlaue.allKeys.firstObject;

    _detailLable.attributedText = contentVlaue.allValues.firstObject;
    [self layoutIfNeeded];
}

@end
