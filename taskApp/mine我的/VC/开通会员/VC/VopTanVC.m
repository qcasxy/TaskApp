//
//  VopTanVC.m
//  taskApp
//
//  Created by per on 2019/11/11.
//  Copyright © 2019 per. All rights reserved.
//

#import "VopTanVC.h"
#import "TanCell.h"
#import "UIButton+LXMImagePosition.h"
#import "WXApi.h"
@interface VopTanVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,assign)NSInteger index;
@end

@implementation VopTanVC
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"success" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"fail" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:135/255 green:135/255 blue:135/255 alpha:0.1];
    self.index = -1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"success" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail) name:@"fail" object:nil];
    UIView * backView =[[UIView alloc]init];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(height(400));
    }];
    UIButton * closeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:0];
    [backView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView).offset(width(15));
        make.top.mas_equalTo(backView).offset(height(15));
        make.width.height.mas_equalTo(40);
    }];
    [[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"success" object:nil];
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"fail" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UILabel * titlelable =[HttpTool createLable:BassColor(0, 0, 0) font:VPFont(@"PingFangSC-Semibold", height(17)) textAlignmen:NSTextAlignmentCenter text:self.tanModel.name];
    [backView addSubview:titlelable];
    [titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(closeBtn.mas_centerY);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.width.mas_equalTo(width(200));
        make.height.mas_equalTo(height(17));
    }];
    
    [backView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(backView);
         make.top.mas_equalTo(closeBtn.mas_bottom).offset(height(15));
        make.height.mas_equalTo(height(120));
    }];
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:[NSString stringWithFormat:@"支付%@",self.tanModel.price] forState:0];
    sureBtn.backgroundColor = BassColor(17, 151, 255);
    [sureBtn setTitleColor:BassColor(255, 255, 255) forState:0];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(height(40));
        make.width.mas_equalTo(width(305));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-height(60));
    }];
    sureBtn.layer.masksToBounds =YES;
    sureBtn.layer.cornerRadius = height(20);
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.index==0) {
            
        }else{
             NSLog(@"%@",TOKEN);
            NSLog(@"%@",self.tanModel.vipID);
            [HttpTool post:API_POST_echargeVip dic:@{@"type":@"2",@"id":self.tanModel.vipID} success:^(id  _Nonnull responce) {
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
                [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
            }];
        }
    }];
    UIButton * beiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beiBtn setTitle:@"该服务资金安全已经进行全面加密保护" forState:0];
    beiBtn.backgroundColor =UIColor.whiteColor;
    beiBtn.titleLabel.font =[UIFont systemFontOfSize:11];
    [beiBtn setTitleColor:BassColor(153, 153, 153) forState:0];
    [beiBtn setImage:[UIImage imageNamed:@"anquan"] forState:0];
    [self.view addSubview:beiBtn];
    [beiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(height(12));
        make.width.mas_equalTo(width(305));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-height(120));
    }];
    beiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    beiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    
   beiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    beiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    
    [beiBtn setImagePosition:LXMImagePositionLeft spacing:5];
    
    // Do any additional setup after loading the view.
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[TanCell class] forCellReuseIdentifier:@"TanCell"];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 1;

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        TanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"TanCell"];
        cell.backgroundColor=UIColor.whiteColor;
    if (indexPath.section==0) {
        cell.nameLable.text = @"支付宝";
        cell.leftImg.image =[UIImage imageNamed:@"zhifubao"];
    }else{
      cell.nameLable.text = @"微信";
        cell.leftImg.image =[UIImage imageNamed:@"weixin"];
    }
    if (self.index == indexPath.section) {
       cell.rightImg.image =[UIImage imageNamed:@"dui"];
    }else{
       cell.rightImg.image =[UIImage imageNamed:@""];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return height(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 0.0001;
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heardView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    heardView.backgroundColor = BassColor(241, 241, 241);
    return heardView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    footView.backgroundColor = BassColor(241, 241, 241);
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        [self showToastInView:self.view message:@"暂未开放" duration:0.8];
        self.index = 1;
    }else{
     self.index = indexPath.section;
    }
    self.index = indexPath.section;
    [self.tableView reloadData];
}
-(void)paySuccess{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(goToViewControllerVC)]) {
        [self.delegate goToViewControllerVC];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)payFail{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(goToViewControllerFailVC)]) {
        [self.delegate goToViewControllerFailVC];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
