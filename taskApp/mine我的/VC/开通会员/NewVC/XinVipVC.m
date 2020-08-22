//
//  XinVipVC.m
//  taskApp
//
//  Created by per on 2020/1/4.
//  Copyright © 2020 per. All rights reserved.
//

#import "XinVipVC.h"
#import "MemberCell.h"
#import "VipModel.h"
#import "SPButton.h"
#import "WXApi.h"
#import "YouHuiVC.h"
#import "SuccessViewController.h"
#import "WebXieViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PaymentManager.h"

@interface XinVipVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    UILabel * name1;
    UILabel * name;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray* dataArr;
@property(nonatomic,strong)UILabel * timeLable;
@property(nonatomic,assign)NSInteger indexSeleted;
@property(nonatomic,strong)UIButton * moneyBtn;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)NSString * vipID;
@property(nonatomic,strong)NSDictionary * reDic;
@end

@implementation XinVipVC
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self isHidden];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr =[[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentResult:) name:nPaymentResult object:nil];
    self.indexSeleted=0;
    self.index=0;
    self.view.backgroundColor =BassColor(255, 255, 255);
    [self createView];
    [self load_API_POST_vipCard:@"2"];
}
-(void)createView{
    UIView * backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height(178))];
    backView.backgroundColor = BassColor(46, 46, 48);
    [self.view addSubview:backView];
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor =UIColor.clearColor;
    [btn setBackgroundImage:[UIImage imageNamed:@"walletrightbai"] forState:0];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(20));
        make.top.mas_equalTo(self.view).offset(NavHeight-44);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIButton * huangBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [huangBtn setTitle:@"黄金会员" forState:0];
    [huangBtn setTitleColor:BassColor(229, 163, 54) forState:0];
    huangBtn.titleLabel.font = [UIFont systemFontOfSize:height(14)];
    [backView addSubview:huangBtn];
    [huangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(btn.mas_centerY);
        make.width.mas_equalTo(width(80));
        make.height.mas_equalTo(height(16));
        make.left.mas_equalTo(backView).offset(width(93));
    }];
    UIView * line =[[UIView alloc]init];
    line.backgroundColor=BassColor(229, 163, 54);
    line.hidden=NO;
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(huangBtn.mas_bottom).offset(height(5));
        make.width.mas_equalTo(width(34));
        make.height.mas_equalTo(2);
        make.centerX.mas_equalTo(huangBtn.mas_centerX);
    }];
    UIButton * zBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [zBtn setTitle:@"钻石会员" forState:0];
    [zBtn setTitleColor:BassColor(255,255,255) forState:0];
    zBtn.titleLabel.font = [UIFont systemFontOfSize:height(14)];
    [backView addSubview:zBtn];
    [zBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(btn.mas_centerY);
        make.width.mas_equalTo(width(80));
        make.height.mas_equalTo(height(16));
        make.left.mas_equalTo(backView).offset(width(221));
    }];
    UIView * line1 =[[UIView alloc]init];
    line1.backgroundColor=BassColor(229, 163, 54);
     line1.hidden=YES;
    [backView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(huangBtn.mas_bottom).offset(height(5));
        make.width.mas_equalTo(width(34));
        make.height.mas_equalTo(2);
        make.centerX.mas_equalTo(zBtn.mas_centerX);
    }];
    [[huangBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        line.hidden=NO;
        [zBtn setTitleColor:BassColor(255,255,255) forState:0];
        [huangBtn setTitleColor:BassColor(229, 163, 54) forState:0];
        line1.hidden=YES;
        [self load_API_POST_vipCard:@"2"];
        self.indexSeleted=0;
        if ([self.reDic[@"level"] intValue]==3){
            self->name.hidden=YES;
            self->name1.hidden=YES;
        }else{
        self->name.hidden=NO;
        self->name1.hidden=NO;
        } 
    }];
    [[zBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.indexSeleted=0;
        [self load_API_POST_vipCard:@"3"];
        line1.hidden=NO;
        [zBtn setTitleColor:BassColor(229, 163, 54) forState:0];
        [huangBtn setTitleColor:BassColor(255,255,255) forState:0];
        line.hidden=YES;
        self->name.hidden=YES;
        self->name1.hidden=YES;
        
    }];
    UIImageView * touImg =[[UIImageView alloc]init];
    touImg.backgroundColor =UIColor.whiteColor;
    [touImg sd_setImageWithURL:[NSURL URLWithString:self.mmodel.headimg] placeholderImage:nil];
    [backView addSubview:touImg];
    [touImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_left).offset(width(35));
        make.bottom.mas_equalTo(backView.mas_bottom).offset(-height(19));
        make.width.height.mas_equalTo(height(60));
    }];
    touImg.layer.masksToBounds =YES;
    touImg.layer.cornerRadius = height(30);
    CGFloat wid =[HttpTool floatWithStr:self.mmodel.nickname and:height(17)];
    
    UILabel * nickLable =[HttpTool createLable:BassColor(255,255,255) font:VPFont(@"PingFangSC-Regular", height(17)) textAlignmen:NSTextAlignmentLeft text:self.mmodel.nickname];
    [backView addSubview:nickLable];
    [nickLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(touImg.mas_right).offset(width(15));
        make.centerY.mas_equalTo(touImg.mas_centerY).offset(-height(15));
        make.height.mas_equalTo(height(18));
        make.width.mas_equalTo(width(5)+wid);
    }];
    UIImageView * vimg=[[UIImageView alloc]init];
    vimg.image =[UIImage imageNamed:@"huiyan"];
    if ([self.mmodel.level intValue]==1) {
        vimg.hidden=YES;
    }else{
        vimg.hidden=NO;
    }
    [backView addSubview:vimg];
    [vimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nickLable.mas_right).offset(width(10));
        make.width.height.mas_equalTo(17);
        make.centerY.mas_equalTo(nickLable.mas_centerY);
    }];
    self.timeLable =[HttpTool createLable:BassColor(229, 163, 54) font:VPFont(@"PingFangSC-Regular", height(13)) textAlignmen:NSTextAlignmentLeft text:@""];
    [backView addSubview:self.timeLable];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(touImg.mas_right).offset(width(15));
        make.centerY.mas_equalTo(touImg.mas_centerY).offset(height(15));
        make.height.mas_equalTo(height(18));
        make.width.mas_equalTo(width(280));
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
        make.top.mas_equalTo(backView.mas_bottom);
    }];
 
    UIButton * guiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [guiBtn setTitle:@"会员规则说明" forState:0];
    [guiBtn setTitleColor:BassColor(229, 163, 54) forState:0];
    guiBtn.titleLabel.font = VPFont(@"PingFangSC-Regular", height(13));
    guiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [backView addSubview:guiBtn];
    [guiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(backView.mas_right).offset(-width(15.5));
        make.centerY.mas_equalTo(nickLable.mas_centerY);
        make.left.mas_equalTo(nickLable.mas_right).offset(width(10));
        make.height.mas_equalTo(height(30));
    }];
    [[guiBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [HttpTool NoHeardsGet:API_POST_website dic:@{} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]) {
                WebXieViewController * webVC =[[WebXieViewController alloc]init];
                webVC.name = @"会员规则";
                webVC.context = responce[@"data"][@"member"];
                webVC.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:webVC animated:YES];
            }
            
        } faile:^(NSError * _Nonnull erroe) {
            
        }];
    }];
}
-(void)load_API_POST_vipCard:(NSString*)level{
    [self.dataArr removeAllObjects];
    [HttpTool get:API_POST_vipCard dic:@{@"level":level} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            self.reDic =responce[@"data"];
            if ([responce[@"data"][@"level"] intValue]==2) {
                self.timeLable.text = [NSString stringWithFormat:@"黄金会员%@到期",responce[@"data"][@"viptime"]];
                [self.moneyBtn setTitle:[NSString stringWithFormat:@"立即续费"] forState:0];
            }else if ([responce[@"data"][@"level"] intValue]==3){
              self.timeLable.text = [NSString stringWithFormat:@"钻石会员%@到期",responce[@"data"][@"viptime"]];
                [self.moneyBtn setTitle:[NSString stringWithFormat:@"立即续费"] forState:0];
                self->name.hidden=YES;
                self->name1.hidden=YES;
            }else{
                self.timeLable.text = @"未开通";
                 [self.moneyBtn setTitle:[NSString stringWithFormat:@"立即开通"] forState:0];
            }
                
            self.dataArr =[VipModel mj_objectArrayWithKeyValuesArray:responce[@"data"][@"vip"]];
            if (self.dataArr.count>0) {
                VipModel * model = self.dataArr[0];
                
                self.vipID = model.vipID;
            }
           
            [self.collectionView reloadData];
        }else{
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        }
        
    } faile:^(NSError * _Nonnull erroe) {
        
    }];
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =UIColor.whiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor =BassColor(255, 255, 255);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return height(0);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return height(680);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heardView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,  height(680))];
    heardView.backgroundColor = UIColor.whiteColor;
    UIImageView * vipImg =[[UIImageView alloc]init];
    vipImg.image =[UIImage imageNamed:@"vipXin"];
    [heardView addSubview:vipImg];
    [vipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(heardView.mas_centerX);
        make.top.mas_equalTo(heardView).offset(height(8));
        make.height.mas_equalTo(height(86));
        make.width.mas_equalTo(width(343));
    }];
    [heardView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(heardView);
        make.height.mas_equalTo(height(144));
        make.top.mas_equalTo(vipImg.mas_bottom).offset(height(13));
    }];
    name =[HttpTool createLable:BassColor(74, 71, 71) font:VPFont(@"PingFangSCRegular", height(14)) textAlignmen:NSTextAlignmentLeft text:@"优惠升级"];
    [heardView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(heardView).offset(10);
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(height(25));
        make.width.mas_equalTo(width(100));
        make.height.mas_equalTo(height(14));
    }];
    
    name1 =[HttpTool createLable:BassColor(74, 71, 71) font:VPFont(@"PingFangSCRegular", height(14)) textAlignmen:NSTextAlignmentRight text:@"升级剩余黄金会员天数"];
    [heardView addSubview:name1];
    [name1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(heardView.mas_right).offset(-10);
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(height(25));
        make.width.mas_equalTo(width(200));
        make.height.mas_equalTo(height(14));
    }];
    self->name.hidden=NO;
    self->name1.hidden=NO;

    UIButton * panBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    panBtn.backgroundColor = UIColor.clearColor;
    [heardView addSubview:panBtn];
    [panBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(heardView.mas_right).offset(0);
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(height(25));
        make.width.mas_equalTo(width(200));
        make.height.mas_equalTo(height(14));
    }];
    [[panBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [HttpTool get:API_POST_checkUpgrade dic:@{} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                YouHuiVC * VC =[[YouHuiVC alloc]init];
                [self.navigationController pushViewController:VC animated:YES];
            }else{
                [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            }
        } faile:^(NSError * _Nonnull erroe) {
            
        }];
    }];
    UIView * line3 =[[UIView alloc]init];
    line3.backgroundColor = BassColor(241, 241, 241);
    [heardView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(heardView);
        make.height.mas_equalTo(height(10));
        make.top.mas_equalTo(self->name.mas_bottom).offset(height(15));
    }];
    UILabel * tiLable =[HttpTool createLable:BassColor(153, 153, 153) font:VPFont(@"PingFangSCRegular", height(14)) textAlignmen:NSTextAlignmentLeft text:@"选择支付方式"];
    [heardView addSubview:tiLable];
    [tiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(heardView).offset(10);
        make.top.mas_equalTo(line3.mas_bottom).offset(height(15));
        make.width.mas_equalTo(width(150));
        make.height.mas_equalTo(height(14));
    }];
    
    SPButton * weiBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];;
    [weiBtn setTitle:@"微信   " forState:UIControlStateNormal];

    weiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [weiBtn setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [weiBtn setTitleColor:BassColor(51,51,51) forState:UIControlStateNormal];
    weiBtn.backgroundColor = BassColor(255,255,255);
    weiBtn.imageTitleSpace =width(10);
    //    [gouBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [heardView addSubview:weiBtn];
    [weiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height(40));
        make.width.mas_equalTo(width(80));
        make.top.mas_equalTo(tiLable.mas_bottom).offset(height(32));
        make.left.mas_equalTo(heardView).offset(10);
    }];
    UIButton * weiImg =[UIButton buttonWithType:UIButtonTypeCustom];
    [weiImg setImage:[UIImage imageNamed:@"xinxuanz"] forState:0];
    [heardView addSubview:weiImg];
    [weiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17.5);
        make.width.mas_equalTo(17.5);
        make.centerY.mas_equalTo(weiBtn.mas_centerY);
        make.right.mas_equalTo(heardView.mas_right).offset(-10);
    }];
    SPButton * zhiBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];;
    [zhiBtn setTitle:@"支付宝" forState:UIControlStateNormal];
    
    zhiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zhiBtn setImage:[UIImage imageNamed:@"zhifubaoxin"] forState:UIControlStateNormal];
    [zhiBtn setTitleColor:BassColor(51,51,51) forState:UIControlStateNormal];
    zhiBtn.backgroundColor = BassColor(255,255,255);
    zhiBtn.imageTitleSpace =width(10);
    //    [gouBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [heardView addSubview:zhiBtn];
    [zhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height(40));
        make.width.mas_equalTo(width(80));
        make.top.mas_equalTo(weiBtn.mas_bottom).offset(height(30));
        make.left.mas_equalTo(heardView).offset(10);
    }];
    UIButton * zhiImg =[UIButton buttonWithType:UIButtonTypeCustom];
    [zhiImg setImage:[UIImage imageNamed:@"weixin-1"] forState:0];
    [heardView addSubview:zhiImg];
    [zhiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17.5);
        make.width.mas_equalTo(17.5);
        make.centerY.mas_equalTo(zhiBtn.mas_centerY);
        make.right.mas_equalTo(heardView.mas_right).offset(-10);
    }];
    [[weiImg rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         self.index=0;
        [weiImg setImage:[UIImage imageNamed:@"xinxuanz"] forState:0];
       [zhiImg setImage:[UIImage imageNamed:@"weixin-1"] forState:0];
    }];
    [[zhiImg rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.index=1;
       
        [zhiImg setImage:[UIImage imageNamed:@"xinxuanz"] forState:0];
        [weiImg setImage:[UIImage imageNamed:@"weixin-1"] forState:0];
    }];
    
    UIView * line4 =[[UIView alloc]init];
    line4.backgroundColor= BassColor(241, 241, 241);
    [heardView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(heardView);
        make.height.mas_equalTo(height(77));
        make.top.mas_equalTo(zhiBtn.mas_bottom).offset(height(30));
    }];
    self.moneyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.moneyBtn setBackgroundImage:[HttpTool gradientImageWithBounds:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andColors:@[BassColor(253, 234, 201),BassColor(223, 178, 110)] andGradientType:0] forState:0];
    
    [self.moneyBtn setTitleColor:BassColor(51, 51, 51) forState:0];
    [heardView addSubview:self.moneyBtn];
    [self.moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(heardView.mas_centerX);
        make.top.mas_equalTo(line4.mas_bottom).offset(height(20));
        make.width.mas_equalTo(width(300));
        make.height.mas_equalTo(height(40));
    }];
    self.moneyBtn.layer.masksToBounds =YES;
    self.moneyBtn.layer.cornerRadius =height(20);
    [[self.moneyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [HttpTool get:API_POST_checkVip dic:@{@"id":self.vipID} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                if (self.index==0) {//微信
                    NSLog(@"%@",TOKEN);
                    [HttpTool post:API_POST_echargeVip dic:@{@"type":@"2",@"id":self.vipID} success:^(id  _Nonnull responce) {
                        NSLog(@"%@",responce);
                        
                        PayReq *request = [[PayReq alloc] init];
                        request.partnerId = responce[@"appId"];
                        request.prepayId= [[responce[@"package"] componentsSeparatedByString:@"="] lastObject];
                        request.package = @"Sign=WXPay";
                        request.nonceStr= responce[@"nonceStr"];
                        request.timeStamp= [responce[@"timeStamp"] intValue];
                        request.sign= responce[@"signType"];
                        [WXApi sendReq:request];
                        if ([responce[@"code"] intValue]==201) {
                            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
                        }
                    } faile:^(NSError * _Nonnull erroe) {
                        
                    }];
                }else{//支付宝
                    [HttpTool post:API_POST_echargeVip dic:@{@"type":@"1",@"id":self.vipID} success:^(id  _Nonnull responce) {
                        NSLog(@"%@",responce);
                        [[AlipaySDK defaultService] payOrder:responce[@"data"] fromScheme:@"com.ruizhixue.ttrw" callback:^(NSDictionary *resultDic) {
                            int resultStatus = [[resultDic objectForKey:@"resultStatus"] intValue];
                            [PaymentManager alipayResult:resultStatus];
                        }];
                    } faile:^(NSError * _Nonnull erroe) {

                    }];
                }
            }else{
              [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            }
            
        } faile:^(NSError * _Nonnull erroe) {
            
        }];
        
    }];
    return heardView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,0.0001)];
    footView.backgroundColor = BassColor(255, 255, 255);
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
}
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MemberCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MemberCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    VipModel * model = self.dataArr[indexPath.row];
    cell.model = model;
    if (indexPath.row==1) {
        cell.imgBtn.hidden=NO;
    }else if(indexPath.row==0){
        cell.imgBtn.hidden=YES;
    }else{
       cell.imgBtn.hidden=YES;
    }
    if (self.indexSeleted==indexPath.row) {
        cell.contentView.layer.borderColor = BassColor(255, 166, 20).CGColor;
         cell.backgroundColor =BassColor(251, 220, 127);
    }else{
         cell.backgroundColor =[UIColor whiteColor];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VipModel * model = self.dataArr[indexPath.row];
    self.indexSeleted = indexPath.row;
    self.vipID = model.vipID;
//    [self.moneyBtn setTitle:[NSString stringWithFormat:@"立即支付%@元",model.money] forState:0];
    [self.collectionView reloadData];
}
// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(width(110), height(144));
}

// 设置UIcollectionView整体的内边距（这样item不贴边显示）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 上 左 下 右
    return UIEdgeInsetsMake(10,10, 10, 10);
}

// 设置minimumLineSpacing：cell上下之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 设置minimumInteritemSpacing：cell左右之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
/**
 * 响应支付完成的通知
 */
- (void)paymentResult:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo == nil || ![userInfo objectForKey:@"result"]){
        return;
    }
    int result = [[userInfo objectForKey:@"result"] intValue];
    NSString *message = [userInfo objectForKey:@"message"];
    [self paymentCallback:result message:message];
}
/**
 * 处理支付结果
 */
- (void)paymentCallback:(int)result message:(NSString *)msg{
    if (result == 0) {
        SuccessViewController *VC =[[SuccessViewController alloc]init];
        VC.imgName = @"shibai";
        VC.status = @"支付失败";
        VC.beiZhu = @"支付失败，请重新支付...";
        VC.btnStr = @"确定";
        VC.indexType=6;
        [self.navigationController pushViewController:VC animated:YES];
    } else if (result == 1){//支付成功
        SuccessViewController *VC =[[SuccessViewController alloc]init];
        VC.imgName = @"success";
        VC.status = @"支付成功";
        VC.beiZhu = @"支付成功，请等待...";
        VC.btnStr = @"确定";
        VC.indexType=6;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (result == 2) {
        [self showToastInView:self.view message:@"订单正在处理中，请您稍后查询订单状态！" duration:0.8];
        return;
    }
}
@end
