//
//  MineViewController.m
//  taskApp
//
//  Created by 二恒 on 2019/11/7.
//  Copyright © 2019 per. All rights reserved.
//

#import "MineViewController.h"
#import "SetVC.h"
#import "MineCell1.h"
#import "MineCell2.h"
#import "MineModel.h"
#import "OrderVC.h"
#import "YQHYVC.h"
#import "YJDetailVC.h"
#import "WalletVC.h"
#import "HuiYuanVC.h"
#import "VipVC.h"
#import "FaakQuestVC.h"
#import "PersonalDataVC.h"
#import "XinVipVC.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,MineCell1Delegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr1;
@property(nonatomic,strong)NSMutableArray * dataArr2;
@property(nonatomic,strong)NSMutableArray * dataArr3;
@property(nonatomic,strong)MineModel * cellModel;
@end

@implementation MineViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self isHidden];
    [self load_userIndex];
}
-(void)clickBtnGoToVC{
    PersonalDataVC * VC =[[PersonalDataVC alloc]init];
    VC.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = BassColor(241, 241, 241);
    [self.view addSubview:self.tableView];
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view);
//        make.left.right.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-TabBaHeight);
//    }];
    self.dataArr1=[MineModel mj_objectArrayWithKeyValuesArray:@[@{@"name":@"邀请好友",@"img":@"weibiaoti"},@{@"name":@"钱包",@"img":@"tixian"},@{@"name":@"会员",@"img":@"huiyuan"},@{@"name":@"佣金",@"img":@"ziyuan"}]];
     self.dataArr2=[MineModel mj_objectArrayWithKeyValuesArray:@[@{@"name":@"用户",@"img":@"yonghu"},@{@"name":@"意见反馈",@"img":@"guanyuwomen"}]];
     self.dataArr3=[MineModel mj_objectArrayWithKeyValuesArray:@[@{@"name":@"设置",@"img":@"shezhi"}]];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self load_userIndex];
}

-(void)load_userIndex{
    [HttpTool get:API_POST_userIndex dic:@{} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            self.cellModel =[MineModel mj_objectWithKeyValues:responce[@"data"]];
        }else{
            [self showToastInView:self.view message:responce[@"msg"] duration:0.8];
        }
        [self.tableView reloadData];
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-TabBaHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[MineCell1 class] forCellReuseIdentifier:@"MineCell1"];
        [_tableView registerClass:[MineCell2 class] forCellReuseIdentifier:@"MineCell2"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
       return 4;
    }else if (section==2){
      return 2;
    }else{
     return 1;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        MineCell1 * cell1 =[tableView dequeueReusableCellWithIdentifier:@"MineCell1"];
        cell1.backgroundColor = BassColor(241, 241, 241);
        cell1.delegate=self;
        [cell1 chuanZhiMineModel:self.cellModel];
        cell1.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell1;
    }else{
        MineCell2 * cell2 =[tableView dequeueReusableCellWithIdentifier:@"MineCell2"];
        cell2.selectionStyle =  UITableViewCellSelectionStyleNone;
        MineModel * model;
        if (indexPath.section==1) {
            model = self.dataArr1[indexPath.row];
            [cell2 chuanZhiMineModel:model];
        }else if (indexPath.section==2){
            model = self.dataArr2[indexPath.row];
            [cell2 chuanZhiMineModel:model];
            
        }else{
            model = self.dataArr3[indexPath.row];
            [cell2 chuanZhiMineModel:model];
        }
        return cell2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return height(330);
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.0001;
    }
    return height(10);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heardView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height(10))];
    heardView.backgroundColor = BassColor(241, 241, 241);
    return heardView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    footView.backgroundColor = BassColor(241, 241, 241);
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            YQHYVC * VC =[[YQHYVC alloc]init];
            VC.hidesBottomBarWhenPushed =YES;
            VC.invite =self.cellModel.invite;
            VC.share =self.cellModel.share;
            VC.poster =self.cellModel.poster;
            [self.navigationController pushViewController:VC animated:YES];
        }else if (indexPath.row==1){
            WalletVC * VC =[[WalletVC alloc]init];
            VC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else if (indexPath.row==2){
            XinVipVC * VC =[[XinVipVC alloc]init];
            VC.mmodel = self.cellModel;
            VC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            YJDetailVC *VC =[[YJDetailVC alloc]init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            HuiYuanVC * VC =[[HuiYuanVC alloc]init];
            VC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            FaakQuestVC * VC =[[FaakQuestVC alloc]init];
            VC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else{
        SetVC * VC =[[SetVC alloc]init];
        VC.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}
-(void)clickBtnIndex:(NSUInteger)index{
    OrderVC * VC =[[OrderVC alloc]init];
    VC.typeIndex = [[NSString stringWithFormat:@"%lu",(unsigned long)index] intValue];
    VC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:VC animated:YES];
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
