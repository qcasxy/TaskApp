//
//  MineCell1.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "MineCell1.h"
#import "MineCellectin.h"
@interface MineCell1 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * mineCollection;
@property(nonatomic,strong)NSMutableArray * dataArr;
@end
@implementation MineCell1

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
        self.dataArr=[MineModel mj_objectArrayWithKeyValuesArray:@[@{@"name":@"我的接单",@"img":@"hx_danzi"},@{@"name":@"待提交",@"img":@"shangchuanicon"},@{@"name":@"审核中",@"img":@"shenhezhong"},@{@"name":@"不合格",@"img":@"buhege"},@{@"name":@"已完成",@"img":@"yiwancheng"}]];
        UIImageView* backView =[[UIImageView alloc]init];
        backView.image =[UIImage imageNamed:@"minetop"];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(height(285));
        }];
        self.titleLable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"PingFangSC-Semibold", height(21)) textAlignmen:NSTextAlignmentLeft text:@"个人中心"];
        [self.contentView addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(19));
            make.top.mas_equalTo(self).offset(height(55.5));
            make.height.mas_equalTo(height(20));
            make.width.mas_equalTo(width(110));
        }];
        self.touImg =[[UIImageView alloc]init];
        self.touImg.image =[UIImage imageNamed:@""];
        [self.contentView addSubview:self.touImg];
        [self.touImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(19));
            make.top.mas_equalTo(self.titleLable.mas_bottom).offset(height(27));
            make.width.height.mas_equalTo(height(60));
        }];
        self.touImg.layer.masksToBounds =YES;
        self.touImg.layer.cornerRadius = height(30);
        
        self.nameLable = [HttpTool createLable:UIColor.whiteColor font:VPFont(@"PingFangSC-Semibold", height(16)) textAlignmen:NSTextAlignmentLeft text:@""];
        self.nameLable.numberOfLines = 0;
        [self.contentView addSubview:self.nameLable];
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.touImg.mas_right).offset(width(10));
            make.centerY.mas_equalTo(self.touImg.mas_centerY).offset(height(-15));
            make.height.mas_equalTo(height(20));
        }];
       
        self.IDLable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"PingFangSC-Semibold", height(13)) textAlignmen:NSTextAlignmentLeft text:@"ID："];
        [self.contentView addSubview:self.IDLable];
        [self.IDLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.touImg.mas_right).offset(width(10));
            make.top.mas_greaterThanOrEqualTo(self.nameLable.mas_bottom).offset(height(5.0));
            make.centerY.greaterThanOrEqualTo(self.touImg.mas_centerY).offset(height(15));
            make.height.mas_equalTo(height(20));
            make.right.mas_lessThanOrEqualTo(self).offset(width(-40));
        }];
        
        self.leveImg =[[UIImageView alloc]init];
        self.leveImg.image =[UIImage imageNamed:@"VipImg-1"];
        [self.contentView addSubview:self.leveImg];
        [self.leveImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.nameLable.mas_centerY);
            make.height.mas_equalTo(height(13));
            make.width.mas_equalTo(width(63));
            make.left.mas_equalTo(self.nameLable.mas_right).offset(width(5));
            make.right.mas_lessThanOrEqualTo(self).offset(width(-40));
        }];
        
        self.leveLable=[HttpTool createLable:UIColor.whiteColor font:VPFont(@"PingFangSC-Semibold", height(13)) textAlignmen:NSTextAlignmentCenter text:@""];
        self.leveLable.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.leveLable];
        [self.leveLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.leveImg);
        }];
        
        self.rightImg=[[UIImageView alloc]init];
        self.rightImg.backgroundColor =UIColor.clearColor;
        self.rightImg.image =[UIImage imageNamed:@"jinru"];
        [self.contentView addSubview:self.rightImg];
        [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-width(15));
            make.centerY.mas_equalTo(self.touImg.mas_centerY);
            make.width.mas_equalTo(width(7));
            make.height.mas_equalTo(height(13));
        }];
        UILabel * ziLable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"PingFangSC-Medium", height(13)) textAlignmen:NSTextAlignmentLeft text:@"我的资产"];
        [self.contentView addSubview:ziLable];
        [ziLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(19));
            make.height.mas_equalTo(height(13));
            make.top.mas_equalTo(self.touImg.mas_bottom).offset(height(10));
            make.width.mas_equalTo(width(100));
        }];
        self.moneyLable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"DIN-Medium", height(28)) textAlignmen:NSTextAlignmentLeft text:@""];
        self.moneyLable.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.moneyLable];
        [self.moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(44));
            make.top.mas_equalTo(ziLable).offset(height(14.5));
            make.height.mas_equalTo(height(28));
            make.width.mas_equalTo(kScreenWidth/2-width(44));
        }];
        self.moneyLable1 =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"DIN-Medium", height(28)) textAlignmen:NSTextAlignmentRight text:@""];
      self.moneyLable1.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.moneyLable1];
        [self.moneyLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-width(44));
            make.top.mas_equalTo(ziLable).offset(height(14.5));
            make.height.mas_equalTo(height(28));
            make.width.mas_equalTo(kScreenWidth/2-width(44));
        }];
        UIView * senView=[[UIView alloc]init];
        senView.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:senView];
        [senView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(width(350));
            make.height.mas_equalTo(height(85));
            make.top.mas_equalTo(self.moneyLable.mas_bottom).offset(height(26.5));
        }];
        [senView addSubview:self.mineCollection];
        [self.mineCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(senView.mas_centerX);
            make.width.mas_equalTo(width(350));
            make.height.mas_equalTo(height(85));
            make.top.mas_equalTo(senView).offset(height(0));
        }];
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.touImg.mas_centerY);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(height(60));
        }];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(clickBtnGoToVC)]) {
                [self.delegate clickBtnGoToVC];
            }
        }];
    }
    return self;
}
-(UICollectionView*)mineCollection{
    if (!_mineCollection) {
        UICollectionViewFlowLayout * flow =[[UICollectionViewFlowLayout alloc]init];
        
        _mineCollection =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-NavHeight) collectionViewLayout:flow];
        _mineCollection.delegate =self;
        _mineCollection.dataSource=self;
        [_mineCollection registerClass:[MineCellectin class] forCellWithReuseIdentifier:@"MineCellectin"];
        
        _mineCollection.backgroundColor =UIColor.whiteColor;
    }
    return _mineCollection;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return 5;

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        MineCellectin * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MineCellectin" forIndexPath:indexPath];
    MineModel * model =self.dataArr[indexPath.row];
    [cell chuanZhiMineModel:model];
        cell.backgroundColor =UIColor.whiteColor;
        return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickBtnIndex:)]) {
        [self.delegate clickBtnIndex:indexPath.row];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
        return CGSizeMake(width(350)/5-5, height(85));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0.1, 0, 0.1);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0001;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0001;
}
-(void)chuanZhiMineModel:(MineModel*)model{
    [self.touImg sd_setImageWithURL:[NSURL URLWithString:model.headimg] placeholderImage:nil];
    if ([model.level intValue]==0) {
        self.leveLable.text=@"";
        self.leveImg.hidden=YES;
    }else{
        self.leveImg.hidden=NO;
      self.leveLable.text= [NSString stringWithFormat:@"%@",model.levelname];
    }
    
    self.nameLable.text = model.nickname;
    
    if (model.mineID != nil) {
        self.IDLable.text = [NSString stringWithFormat:@"ID:%@",model.mineID];
    }
    
    if (model.brokerage != nil) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"提现成功 %@",model.withdraw]];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, 4)];
        self.moneyLable.attributedText = attriStr;
    }
    
    if (model.price != nil) {
        NSMutableAttributedString *attriStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"可提现 %@",model.price]];
        [attriStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, 4)];
        self.moneyLable1.attributedText = attriStr1;
    }
}
@end
