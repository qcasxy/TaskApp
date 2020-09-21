//
//  TaskBtnView.m
//  taskApp
//
//  Created by per on 2019/11/11.
//  Copyright © 2019 per. All rights reserved.
//

#import "TaskBtnView.h"
#import "HNPopMenuManager.h"
#import "HNPopMenuModel.h"
#import "BassMianViewController.h"
@interface TaskBtnView ()<HNPopMenuViewDelegate>
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)UIButton * leiBtn;
@property(nonatomic,strong)UIButton * zBtn;
@property(nonatomic,strong)UIButton * nBtn;
@property(nonatomic,strong)UIButton * pBtn;
@property(nonatomic,strong)UIButton * rBtn;
@property(nonatomic,strong)UIImageView  * jiaImg;
@property(nonatomic,assign)BOOL isSele;
@end
@implementation TaskBtnView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.isSele=NO;
        self.dataArr =[[NSMutableArray alloc]init];
        [HttpTool get:API_POST_labelList dic:@{} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                self.dataArr =[HNPopMenuModel mj_objectArrayWithKeyValuesArray:responce[@"data"]];
            }
            
        } faile:^(NSError * _Nonnull erroe) {
            UIViewController *tempVC = self.viewContainingController;
            if (tempVC != nil && [tempVC isKindOfClass: [BassMianViewController class]]) {
                BassMianViewController *vc = (BassMianViewController *)tempVC;
                if (vc != nil) {
                    [vc showToastInView:vc.view message: @"连接超时，请检查您的网络！" duration:0.8];
                }
            }
        }];
//        self.dataArr =[ mj_objectArrayWithKeyValuesArray:@[@{@"name":@"下载任务 ",@"id":@"1"},@{@"name":@"注册任务",@"id":@"2"},@{@"name":@"视频任务",@"id":@"3"}]];
        self.leiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.leiBtn setTitle:@"类型" forState:0];
        self.leiBtn.tag=0;
        [self.leiBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.leiBtn setTitleColor:BassColor(51, 51, 51) forState:0];
        self.leiBtn.titleLabel.font =[UIFont systemFontOfSize:height(16)];
        [self addSubview:self.leiBtn];
        [self.leiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(kScreenWidth/5);
            make.height.mas_equalTo(height(45));
        }];
        self.zBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.zBtn setTitle:@"综合" forState:0];
        [self.zBtn setTitleColor:BassColor(17, 151, 255) forState:0];
        self.zBtn.titleLabel.font =[UIFont systemFontOfSize:height(16)];
        self.zBtn.tag=1;
        [self.zBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.zBtn];
        [self.zBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leiBtn.mas_right);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(kScreenWidth/5);
            make.height.mas_equalTo(height(45));
        }];
        self.nBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.nBtn setTitle:@"最新" forState:0];
        [self.nBtn setTitleColor:BassColor(51, 51, 51) forState:0];
        self.nBtn.tag=2;
        [self.nBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.nBtn.titleLabel.font =[UIFont systemFontOfSize:height(16)];
        [self addSubview:self.nBtn];
        [self.nBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.zBtn.mas_right);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(kScreenWidth/5);
            make.height.mas_equalTo(height(45));
        }];
        self.pBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.pBtn setTitle:@"价格" forState:0];
        [self.pBtn setTitleColor:BassColor(51, 51, 51) forState:0];
        self.pBtn.titleLabel.font =[UIFont systemFontOfSize:height(16)];
        self.pBtn.tag=3;
        [self.pBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.pBtn];
        [self.pBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nBtn.mas_right);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(kScreenWidth/5);
            make.height.mas_equalTo(height(45));
        }];
        self.jiaImg =[[UIImageView alloc]init];
        self.jiaImg.image =[UIImage imageNamed:@"shangxiajiantou"];
        [self addSubview:self.jiaImg];
        [self.jiaImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.pBtn.mas_right);
            make.centerY.mas_equalTo(self.pBtn.mas_centerY);
            make.width.mas_equalTo(width(20));
            make.height.mas_equalTo(height(20));
        }];
        
        self.rBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.rBtn setTitle:@"人气" forState:0];
        [self.rBtn setTitleColor:BassColor(51, 51, 51) forState:0];
        self.rBtn.titleLabel.font =[UIFont systemFontOfSize:height(16)];
        self.rBtn.tag=4;
        [self.rBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rBtn];
        [self.rBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pBtn.mas_right);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(kScreenWidth/5);
            make.height.mas_equalTo(height(45));
        }];
        for (int i=0; i<5; i++) {
            UIView * line =[[UIView alloc]init];
            line.backgroundColor =BassColor(215, 215, 215);
            line.frame = CGRectMake(i*(width(kScreenWidth/5-0.5)), height(16), 0.5, height(13));
            [self addSubview:line];
        }
    }
    return self;
}
-(void)clickBtn:(UIButton*)btn{
    
    switch (btn.tag) {
        case 0:
        {
           
            [HNPopMenuManager showPopMenuWithView:self.leiBtn items:self.dataArr delegate:self dismissAutomatically:YES];
            self.isSele=NO;
             self.jiaImg.image =[UIImage imageNamed:@"shangxiajiantou"];
        }
            break;
        case 1:
        {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(chuanZhiType:)]) {
                
                [self.delegate chuanZhiType:[[NSString stringWithFormat:@"%ld",(long)btn.tag] intValue]];
                
            }
            [self.leiBtn setTitle:@"类型" forState:0];
            [self.zBtn setTitleColor:BassColor(17, 151, 255) forState:0];
            [self.leiBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.nBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.pBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.rBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            self.isSele=NO;
             self.jiaImg.image =[UIImage imageNamed:@"shangxiajiantou"];
        }
            break;
        case 2:
        {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(chuanZhiType:)]) {
                
                [self.delegate chuanZhiType:[[NSString stringWithFormat:@"%ld",(long)btn.tag] intValue]];
                
            }
             self.jiaImg.image =[UIImage imageNamed:@"shangxiajiantou"];
            [self.leiBtn setTitle:@"类型" forState:0];
            [self.nBtn setTitleColor:BassColor(17, 151, 255) forState:0];
            [self.leiBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.zBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.pBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.rBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            self.isSele=NO;
        }
            break;
        case 3:
        {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(chuanZhiType:)]) {
                
                [self.delegate chuanZhiType:[[NSString stringWithFormat:@"%ld",(long)btn.tag] intValue]];
                
            }
            if (self.isSele==NO) {
                if (self.delegate &&[self.delegate respondsToSelector:@selector(chuanZhiBOOL:)]) {
                    
                    [self.delegate chuanZhiBOOL:NO];
                    
                }
                 self.jiaImg.image =[UIImage imageNamed:@"jiabottom"];
                self.isSele=YES;
            }else{
                if (self.delegate &&[self.delegate respondsToSelector:@selector(chuanZhiBOOL:)]) {
                    
                    [self.delegate chuanZhiBOOL:YES];
                    
                }
                self.jiaImg.image =[UIImage imageNamed:@"jiatop"];
                self.isSele=NO;
            }
            
            [self.leiBtn setTitle:@"类型" forState:0];
            [self.pBtn setTitleColor:BassColor(17, 151, 255) forState:0];
            [self.leiBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.zBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.nBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.rBtn setTitleColor:BassColor(51, 51, 51) forState:0];
        }
            break;
        case 4:
        {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(chuanZhiType:)]) {
                
                [self.delegate chuanZhiType:[[NSString stringWithFormat:@"%ld",(long)btn.tag] intValue]];
                
            }
            self.jiaImg.image =[UIImage imageNamed:@"shangxiajiantou"];
            [self.leiBtn setTitle:@"类型" forState:0];
            [self.rBtn setTitleColor:BassColor(17, 151, 255) forState:0];
            [self.leiBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.zBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.nBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            [self.pBtn setTitleColor:BassColor(51, 51, 51) forState:0];
            self.isSele=NO;
        }
            break;
        default:
            break;
    }
}
- (void)QQPopMenuView:(HNPopMenuView *)menuView didSelectRow:(NSInteger)row{
    HNPopMenuModel * model =self.dataArr[row];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(chuanZhiLeiXing:)]) {
        [self.delegate chuanZhiLeiXing:model.MenuID];
    }
    [self.leiBtn setTitle:model.name forState:0];
    [self.leiBtn setTitleColor:BassColor(17, 151, 255) forState:0];
    [self.zBtn setTitleColor:BassColor(51, 51, 51) forState:0];
    [self.nBtn setTitleColor:BassColor(51, 51, 51) forState:0];
    [self.pBtn setTitleColor:BassColor(51, 51, 51) forState:0];
    [self.rBtn setTitleColor:BassColor(51, 51, 51) forState:0];
    self.jiaImg.image =[UIImage imageNamed:@"shangxiajiantou"];
    self.isSele=NO;
}
@end
