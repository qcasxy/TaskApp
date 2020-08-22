//
//  YouHuiVC.m
//  taskApp
//
//  Created by per on 2020/1/4.
//  Copyright © 2020 per. All rights reserved.
//

#import "YouHuiVC.h"
#import "SPButton.h"
#import "WXApi.h"
#import "SuccessViewController.h"
@interface YouHuiVC ()
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UIButton * numBtn;
@property(nonatomic,strong)UILabel * moneyLable;
@property(nonatomic,strong)UIButton * moneyBtn;
@end

@implementation YouHuiVC
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"success" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"fail" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self isHidden];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BassColor(241, 241, 241);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"success" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail) name:@"fail" object:nil];
    UIImageView * heiImg =[[UIImageView alloc]init];
    heiImg.image =[UIImage imageNamed:@"hei"];
    [self.view addSubview:heiImg];
    [heiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(height(237));
    }];
    
    
    UILabel * titleLable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"PingFang-SC-Bold", height(16)) textAlignmen:NSTextAlignmentCenter text:@"优惠升级"];
    [self.view addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view).offset(20+height(27));
        make.width.mas_equalTo(width(100));
        make.height.mas_equalTo(height(20));
    }];
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor =UIColor.clearColor;
    [btn setBackgroundImage:[UIImage imageNamed:@"walletrightbai"] forState:0];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(20));
        make.centerY.mas_equalTo(titleLable.mas_centerY);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIImageView * vipImg =[[UIImageView alloc]init];
    vipImg.userInteractionEnabled=YES;
    vipImg.image =[UIImage imageNamed:@"vipImgxixin"];
    [self.view addSubview:vipImg];
    [vipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLable.mas_bottom).offset(height(10.5));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(width(357));
        make.height.mas_equalTo(height(192.5));
    }];
    UILabel * shengLab =[HttpTool createLable:BassColor(133, 99, 62) font:VPFont(@"PingFang-SC-Medium", height(16)) textAlignmen:NSTextAlignmentLeft text:@"升级会员"];
    [vipImg addSubview:shengLab];
    [shengLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vipImg.mas_left).offset(width(40));
        make.top.mas_equalTo(vipImg.mas_top).offset(height(39.5));
        make.height.mas_equalTo(width(80));
        make.height.mas_equalTo(height(16));
    }];
    
    self.numBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    self.numBtn.backgroundColor = [UIColor whiteColor];
    self.numBtn.titleLabel.font = VFont;
    
    [self.numBtn setTitleColor:BassColor(151, 120, 75) forState:0];
    [vipImg addSubview:self.numBtn];
    [self.numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vipImg.mas_left).offset(width(34.5));
        make.height.mas_equalTo(height(32));
        make.width.mas_equalTo(width(197));
        make.top.mas_equalTo(shengLab.mas_bottom).offset(height(24));
    }];
    self.numBtn.layer.masksToBounds=YES;
    self.numBtn.layer.cornerRadius = height(16);
    self.moneyLable =[HttpTool createLable:BassColor(151, 120, 75) font:VPFont(@"PingFangSC-Regular", height(20)) textAlignmen:NSTextAlignmentRight text:@"￥128"];
    self.moneyLable.adjustsFontSizeToFitWidth=YES;
    [vipImg addSubview:self.moneyLable];
    [self.moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(vipImg.mas_right).offset(-width(46));
        make.centerY.mas_equalTo(self.numBtn.mas_centerY);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self.numBtn.mas_right).offset(width(5));
    }];
    
    
    
    
    UIView * wview =[[UIView alloc]init];
    wview.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:wview];
    [wview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(height(176.5));
        make.top.mas_equalTo(vipImg.mas_bottom).offset(height(10));
    }];
    UILabel * tiLable =[HttpTool createLable:BassColor(153, 153, 153) font:VPFont(@"PingFangSCRegular", height(14)) textAlignmen:NSTextAlignmentLeft text:@"选择支付方式"];
    [wview addSubview:tiLable];
    [tiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wview).offset(10);
        make.top.mas_equalTo(wview).offset(height(15));
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
    [wview addSubview:weiBtn];
    [weiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height(40));
        make.width.mas_equalTo(width(80));
        make.top.mas_equalTo(tiLable.mas_bottom).offset(height(32));
        make.left.mas_equalTo(wview).offset(10);
    }];
    UIButton * weiImg =[UIButton buttonWithType:UIButtonTypeCustom];
    [weiImg setImage:[UIImage imageNamed:@"xinxuanz"] forState:0];
    [wview addSubview:weiImg];
    [weiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17.5);
        make.width.mas_equalTo(17.5);
        make.centerY.mas_equalTo(weiBtn.mas_centerY);
        make.right.mas_equalTo(wview.mas_right).offset(-10);
    }];
    SPButton * zhiBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];;
    [zhiBtn setTitle:@"支付宝" forState:UIControlStateNormal];
    
    zhiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zhiBtn setImage:[UIImage imageNamed:@"zhifubaoxin"] forState:UIControlStateNormal];
    [zhiBtn setTitleColor:BassColor(51,51,51) forState:UIControlStateNormal];
    zhiBtn.backgroundColor = BassColor(255,255,255);
    zhiBtn.imageTitleSpace =width(10);
    //    [gouBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [wview addSubview:zhiBtn];
    [zhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height(40));
        make.width.mas_equalTo(width(80));
        make.top.mas_equalTo(weiBtn.mas_bottom).offset(height(30));
        make.left.mas_equalTo(wview).offset(10);
    }];
    UIButton * zhiImg =[UIButton buttonWithType:UIButtonTypeCustom];
    [zhiImg setImage:[UIImage imageNamed:@"weixin-1"] forState:0];
    [wview addSubview:zhiImg];
    [zhiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17.5);
        make.width.mas_equalTo(17.5);
        make.centerY.mas_equalTo(zhiBtn.mas_centerY);
        make.right.mas_equalTo(wview.mas_right).offset(-10);
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
    UIView * writeView =[[UIView alloc]init];
    writeView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:writeView];
    [writeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(height(77.5));
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    
    self.moneyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.moneyBtn setBackgroundImage:[HttpTool gradientImageWithBounds:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andColors:@[BassColor(253, 234, 201),BassColor(223, 178, 110)] andGradientType:0] forState:0];
    [self.moneyBtn setTitle:[NSString stringWithFormat:@"立即升级"] forState:0];
    [self.moneyBtn setTitleColor:BassColor(51, 51, 51) forState:0];
    [writeView addSubview:self.moneyBtn];
    [self.moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(writeView.mas_centerX);
        make.top.mas_equalTo(writeView.mas_top).offset(height(20));
        make.width.mas_equalTo(width(300));
        make.height.mas_equalTo(height(40));
    }];
    self.moneyBtn.layer.masksToBounds =YES;
    self.moneyBtn.layer.cornerRadius =height(20);
    [[self.moneyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.index==0) {
            NSLog(@"%@",TOKEN);
            [HttpTool post:API_POST_upgrade dic:@{@"type":@"2"} success:^(id  _Nonnull responce) {
                NSLog(@"%@",responce);
                
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = responce[@"appId"];
                request.prepayId= [[responce[@"package"] componentsSeparatedByString:@"="] lastObject];
                request.package = @"Sign=WXPay";
                request.nonceStr= responce[@"nonceStr"];
                request.timeStamp= [responce[@"timeStamp"] intValue];
                request.sign= responce[@"signType"];
                [WXApi sendReq:request];
                
            } faile:^(NSError * _Nonnull erroe) {
                
            }];
        }else{
            
            [self showToastInView:self.view message:@"暂未开放" duration:0.8];
            
        }
    }];
    [HttpTool get:API_POST_upgradePage dic:@{} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            [self.numBtn setTitle:[NSString stringWithFormat:@"升级剩余黄金会员天数%@天",responce[@"data"][@"time"]] forState:0];
            self.moneyLable.text = [NSString stringWithFormat:@"￥%@",responce[@"data"][@"money"]];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.moneyLable.text];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,1)];
            self.moneyLable.attributedText = str;
//            [self.moneyBtn setTitle:[NSString stringWithFormat:@"立即支付%@元",responce[@"data"][@"money"]] forState:0];
        }
    } faile:^(NSError * _Nonnull erroe) {
        
    }];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)paySuccess{
    SuccessViewController *VC =[[SuccessViewController alloc]init];
    VC.imgName = @"success";
    VC.status = @"支付成功";
    VC.beiZhu = @"支付成功，请等待...";
    VC.btnStr = @"确定";
    VC.indexType=6;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)payFail{
    SuccessViewController *VC =[[SuccessViewController alloc]init];
    VC.imgName = @"shibai";
    VC.status = @"支付失败";
    VC.beiZhu = @"支付失败，请重新支付...";
    VC.btnStr = @"确定";
    VC.indexType=6;
    [self.navigationController pushViewController:VC animated:YES];
}
@end
