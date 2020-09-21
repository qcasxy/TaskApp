
//
//  VipVC.m
//  taskApp
//
//  Created by per on 2019/11/11.
//  Copyright © 2019 per. All rights reserved.
//

#import "VipVC.h"
#import "VopTanVC.h"
#import "VipCell.h"
#import "VipModel.h"
#import "SuccessViewController.h"
#import "WebXieViewController.h"
@interface VipVC ()<UITableViewDelegate,UITableViewDataSource,VopTanVCDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,copy)NSString  * typrStr;
@property(nonatomic,assign)NSInteger indexType;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)VipModel * model;
@end

@implementation VipVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self isHidden];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BassColor(241, 241, 241);
    self.typrStr = @"";
    self.indexType=-1;
    
    
    
    
    
    
    
    UIImageView * heiImg =[[UIImageView alloc]init];
    heiImg.image =[UIImage imageNamed:@"hei"];
    [self.view addSubview:heiImg];
    [heiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(height(237));
    }];
    
    
    UILabel * titleLable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"PingFang-SC-Bold", height(16)) textAlignmen:NSTextAlignmentCenter text:@"开通会员"];
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
    vipImg.image =[UIImage imageNamed:@"vipImg"];
    [self.view addSubview:vipImg];
    [vipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLable.mas_bottom).offset(height(27.5));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(height(463));
    }];
    UIImageView * touImg =[[UIImageView alloc]init];
    touImg.backgroundColor =UIColor.whiteColor;
    [touImg sd_setImageWithURL:[NSURL URLWithString:self.mmodel.headimg] placeholderImage:nil];
    [vipImg addSubview:touImg];
    [touImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vipImg.mas_left).offset(width(35));
        make.top.mas_equalTo(vipImg.mas_top).offset(height(19));
        make.width.height.mas_equalTo(height(37));
    }];
    touImg.layer.masksToBounds =YES;
    touImg.layer.cornerRadius = height(18.5);
    
    UILabel * nickLable =[HttpTool createLable:BassColor(133, 99, 62) font:VPFont(@"PingFangSC-Regular", height(17)) textAlignmen:NSTextAlignmentLeft text:self.mmodel.nickname];
    [vipImg addSubview:nickLable];
    [nickLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(touImg.mas_right).offset(width(15));
        make.centerY.mas_equalTo(touImg.mas_centerY);
        make.height.mas_equalTo(height(18));
        make.width.mas_equalTo(width(90));
    }];
    UIButton * guiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [guiBtn setTitle:@"会员规则说明" forState:0];
    [guiBtn setTitleColor:BassColor(133, 99, 62) forState:0];
    guiBtn.titleLabel.font = VPFont(@"PingFangSC-Regular", height(13));
    guiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [vipImg addSubview:guiBtn];
    [guiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(vipImg.mas_right).offset(-width(42.5));
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
            [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
        }];
    }];
    UILabel * comtLable =[HttpTool createLable:BassColor(133, 99, 62) font:VPFont(@"PingFangSC-Regular", height(13)) textAlignmen:NSTextAlignmentLeft text:@"开通V I P·尊享各大特权"];
    [vipImg addSubview:comtLable];
    [comtLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vipImg.mas_left).offset(width(35));
        make.top.mas_equalTo(touImg.mas_bottom).offset(height(8));
        make.height.mas_equalTo(height(18));
        make.width.mas_equalTo(width(220));
    }];
    
//    UIButton * kaiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    [kaiBtn setTitle:@"开通会员" forState:0];
//    [kaiBtn setTitleColor:BassColor(224, 179, 112) forState:0];
//    kaiBtn.titleLabel.font = VPFont(@"PingFangSC-Regular", height(13));
//    [self.view addSubview:kaiBtn];
//    [kaiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.top.mas_equalTo(vipImg.mas_bottom).offset(height(85));
//        make.height.mas_equalTo(height(40));
//        make.width.mas_equalTo(width(300));
//    }];
//    kaiBtn.layer.masksToBounds =YES;
//    kaiBtn.layer.cornerRadius = height(20);
//    kaiBtn.layer.borderWidth=1;
//    kaiBtn.layer.borderColor = BassColor(224, 179, 112).CGColor;
//    UIButton * kaiBtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
//    [kaiBtn1 setTitle:@"开通代理" forState:0];
//    [kaiBtn1 setTitleColor:BassColor(224, 179, 112) forState:0];
//    kaiBtn1.titleLabel.font = VPFont(@"PingFangSC-Regular", height(13));
//    [self.view addSubview:kaiBtn1];
//    [kaiBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.top.mas_equalTo(kaiBtn.mas_bottom).offset(height(30));
//        make.height.mas_equalTo(height(40));
//        make.width.mas_equalTo(width(300));
//    }];
//    kaiBtn1.layer.masksToBounds =YES;
//    kaiBtn1.layer.cornerRadius = height(20);
//    kaiBtn1.layer.borderWidth=1;
//    kaiBtn1.layer.borderColor = BassColor(224, 179, 112).CGColor;
//    kaiBtn.layer.masksToBounds =YES;
//    kaiBtn.layer.cornerRadius = height(20);
//    kaiBtn.layer.borderWidth=1;
//    kaiBtn.layer.borderColor = BassColor(224, 179, 112).CGColor;
//
//    UIButton * kaiBtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
//    [kaiBtn2 setTitle:@"开通合伙人" forState:0];
//    [kaiBtn2 setTitleColor:BassColor(224, 179, 112) forState:0];
//    kaiBtn2.titleLabel.font = VPFont(@"PingFangSC-Regular", height(13));
//    [self.view addSubview:kaiBtn2];
//    [kaiBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.top.mas_equalTo(kaiBtn1.mas_bottom).offset(height(30));
//        make.height.mas_equalTo(height(40));
//        make.width.mas_equalTo(width(300));
//    }];
//    kaiBtn2.layer.masksToBounds =YES;
//    kaiBtn2.layer.cornerRadius = height(20);
//    kaiBtn2.layer.borderWidth=1;
//    kaiBtn2.layer.borderColor = BassColor(224, 179, 112).CGColor;
//    [[kaiBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//       ;
//        kaiBtn.backgroundColor = BassColor(223, 178, 110);
//        [kaiBtn setTitleColor:BassColor(0, 0, 0) forState:0];
//        [kaiBtn1 setTitleColor:BassColor(224, 179, 112) forState:0];
//        [kaiBtn2 setTitleColor:BassColor(224, 179, 112) forState:0];
//        kaiBtn1.backgroundColor = BassColor(255, 255, 255);
//        kaiBtn2.backgroundColor =BassColor(255, 255, 255);
//        self.typrStr = @"开通会员";
//    }];
//    [[kaiBtn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        ;
//        kaiBtn1.backgroundColor = BassColor(223, 178, 110);
//        [kaiBtn1 setTitleColor:BassColor(0, 0, 0) forState:0];
//        [kaiBtn setTitleColor:BassColor(224, 179, 112) forState:0];
//        [kaiBtn2 setTitleColor:BassColor(224, 179, 112) forState:0];
//        kaiBtn.backgroundColor = BassColor(255, 255, 255);
//        kaiBtn2.backgroundColor =BassColor(255, 255, 255);
//        self.typrStr = @"开通代理";
//    }];
//    [[kaiBtn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        ;
//        kaiBtn2.backgroundColor = BassColor(223, 178, 110);
//        [kaiBtn2 setTitleColor:BassColor(0, 0, 0) forState:0];
//        [kaiBtn setTitleColor:BassColor(224, 179, 112) forState:0];
//        [kaiBtn1 setTitleColor:BassColor(224, 179, 112) forState:0];
//        kaiBtn.backgroundColor = BassColor(255, 255, 255);
//        kaiBtn1.backgroundColor =BassColor(255, 255, 255);
//        self.typrStr = @"开通合伙人";
//    }];
//    // Do any additional setup after loading the view.
//
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"立即开通" forState:0];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"anniu"] forState:0];
//    sureBtn.backgroundColor = BassColor(224, 179, 112);
    [sureBtn setTitleColor:BassColor(51, 51, 51) forState:0];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(height(40));
        make.width.mas_equalTo(width(300));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-height(60));
    }];
//    sureBtn.layer.masksToBounds =YES;
//    sureBtn.layer.cornerRadius = height(25);
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.indexType==-1) {
            [self showToastInView:self.view message:@"请选择开通会员的类型" duration:0.8];
            return ;
        }
        [HttpTool get:API_POST_checkVip dic:@{@"id":self.model.vipID} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                VopTanVC * VC =[[VopTanVC alloc]init];
                //设置模式展示风格
                VC.delegate = self;
                [VC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
                //必要配置
                self.modalPresentationStyle = UIModalPresentationCurrentContext;
                self.providesPresentationContextTransitionStyle = YES;
                self.definesPresentationContext = YES;
                VC.tanModel = self.model;
                [self.navigationController presentViewController:VC animated:YES completion:nil];
            }else{
                [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            }
        } faile:^(NSError * _Nonnull erroe) {
            [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
        }];
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(heiImg.mas_bottom).offset(height(68));
        make.height.mas_equalTo(height(200));
        make.width.mas_equalTo(width(300));
    }];
    [self load_vipList];
}
-(void)load_vipList{
    [HttpTool get:API_POST_vipList dic:@{} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            self.dataArr =[VipModel mj_objectArrayWithKeyValuesArray:responce[@"data"]];
            [self.tableView reloadData];
        }else{
            
        }
    } faile:^(NSError * _Nonnull erroe) {
                [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =UIColor.whiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.scrollEnabled=NO;
        _tableView.dataSource =self;
        [_tableView registerClass:[VipCell class] forCellReuseIdentifier:@"VipCell"];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VipCell * cell =[tableView dequeueReusableCellWithIdentifier:@"VipCell"];
    if (self.indexType==indexPath.section) {
       //cell.ceterLable.backgroundColor=BassColor(224, 179, 112);
        cell.ceterLable.textColor=BassColor(51, 51, 51);
        cell.img.hidden=NO;
    }else{
       //cell.ceterLable.backgroundColor=BassColor(241, 241, 241);
        cell.ceterLable.textColor=BassColor(224, 179, 112);
        cell.img.hidden=YES;
    }
    VipModel *model =self.dataArr[indexPath.section];
    cell.ceterLable.text = model.name;
    cell.backgroundColor =BassColor(255, 255, 255);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return height(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return height(30);
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heardView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    heardView.backgroundColor = BassColor(241, 241, 241);
    return heardView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height(30))];
    footView.backgroundColor = BassColor(255, 255, 255);
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.indexType=indexPath.section;
     self.model =self.dataArr[indexPath.section];
    [self.tableView reloadData];
}
-(void)goToViewControllerVC{
    SuccessViewController *VC =[[SuccessViewController alloc]init];
    VC.imgName = @"success";
    VC.status = @"支付成功";
    VC.beiZhu = @"支付成功，请等待...";
    VC.btnStr = @"确定";
    VC.indexType=6;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)goToViewControllerFailVC{
    SuccessViewController *VC =[[SuccessViewController alloc]init];
    VC.imgName = @"shibai";
    VC.status = @"支付失败";
    VC.beiZhu = @"支付失败，请重新支付...";
    VC.btnStr = @"确定";
    VC.indexType=6;
    [self.navigationController pushViewController:VC animated:YES];
}
@end
