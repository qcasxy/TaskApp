//
//  YJDetailVC.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "YJDetailVC.h"
#import "YJDetailCell.h"
#import "WalletModel.h"
#import "ZRYViewController.h"
@interface YJDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)UILabel * moneyLable;
@property(nonatomic,strong)UILabel * beilable;
@property(nonatomic,strong)UILabel * kelable;
@property(nonatomic,strong)UILabel * gonglable;
@property(nonatomic,assign)int page;

@end

@implementation YJDetailVC
- (void)viewDidLoad {
    [super viewDidLoad];self.view.backgroundColor =[UIColor whiteColor];
    self.page=1;
    [self setNavTitle:@"佣金详情"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self createUi];
    // Do any additional setup after loading the view.
}
-(void)createUi{
    UIImageView * backImg =[[UIImageView alloc]init];
    backImg.image=[UIImage imageNamed:@"yongjin"];
    backImg.backgroundColor =UIColor.whiteColor;
    [self.view addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(height(10));
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
        make.height.mas_equalTo(height(159));
    }];
    UILabel * zilable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"PingFangSC-Medium", height(14)) textAlignmen:NSTextAlignmentLeft text:@"我的佣金"];
    [backImg addSubview:zilable];
    [zilable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backImg.mas_left).offset(width(12));
        make.top.mas_equalTo(backImg).offset(height(33));
        make.width.mas_equalTo(width(150));
        make.height.mas_equalTo(height(15));
    }];
    self.moneyLable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"DIN",30) textAlignmen:NSTextAlignmentLeft text:@"0.00"];
    self.moneyLable.font =[UIFont systemFontOfSize:30];
    [backImg addSubview:self.moneyLable];
    [self.moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backImg.mas_left).offset(width(12));
        make.top.mas_equalTo(zilable.mas_bottom).offset(height(20));
        make.width.mas_equalTo(kScreenWidth/2-width(31));
        make.height.mas_equalTo(height(30));
    }];
    self.beilable=[HttpTool createLable:UIColor.whiteColor font:VPFont(@"DIN-Medium", height(28)) textAlignmen:NSTextAlignmentLeft text:@"注：佣金转入钱包可提现"];
    self.beilable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.beilable];
    [self.beilable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(31));
        make.bottom.mas_equalTo(backImg.mas_bottom).offset(-height(14.5));
        make.height.mas_equalTo(height(28));
        make.width.mas_equalTo(kScreenWidth/2+width(44));
    }];
    self.kelable =[HttpTool createLable:UIColor.whiteColor font:VPFont(@"DIN-Medium", height(28)) textAlignmen:NSTextAlignmentRight text:@"累计收益：0"];
    self.kelable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.kelable];
    [self.kelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-width(31));
        make.bottom.mas_equalTo(backImg.mas_bottom).offset(-height(14.5));
        make.height.mas_equalTo(height(28));
        make.width.mas_equalTo(kScreenWidth/2-width(44));
    }];
    UIView * lineView =[[UIView alloc]init];
    lineView.backgroundColor = BassColor(248, 248, 248);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(backImg.mas_bottom).offset(height(10));
        make.height.mas_equalTo(height(15));
    }];
    self.gonglable=[HttpTool createLable:BassColor(0, 0, 0) font:[UIFont systemFontOfSize:height(17)] textAlignmen:NSTextAlignmentCenter text:@""];
    [self.view addSubview:self.gonglable];
    [self.gonglable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(0));
        make.height.mas_equalTo(height(17));
        make.width.mas_equalTo(kScreenWidth);
        make.top.mas_equalTo(lineView.mas_bottom).offset(height(10));
    }];
    UILabel * lab =[HttpTool createLable:BassColor(0, 0, 0) font:[UIFont systemFontOfSize:height(17)] textAlignmen:NSTextAlignmentCenter text:@"用户ID"];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(0));
        make.height.mas_equalTo(height(17));
        make.width.mas_equalTo(kScreenWidth/4);
        make.top.mas_equalTo(self.gonglable.mas_bottom).offset(height(20));
    }];
    UILabel * lab1 =[HttpTool createLable:BassColor(0, 0, 0) font:[UIFont systemFontOfSize:height(17)] textAlignmen:NSTextAlignmentCenter text:@"方式"];
    [self.view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right).offset(width(0));
        make.height.mas_equalTo(height(17));
        make.width.mas_equalTo(kScreenWidth/4);
        make.top.mas_equalTo(self.gonglable.mas_bottom).offset(height(20));
    }];
    UILabel * lab2 =[HttpTool createLable:BassColor(0, 0, 0) font:[UIFont systemFontOfSize:height(17)] textAlignmen:NSTextAlignmentCenter text:@"金额"];
    [self.view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab1.mas_right).offset(width(0));
        make.height.mas_equalTo(height(17));
        make.width.mas_equalTo(kScreenWidth/4);
        make.top.mas_equalTo(self.gonglable.mas_bottom).offset(height(20));
    }];
    UILabel * lab3 =[HttpTool createLable:BassColor(0, 0, 0) font:[UIFont systemFontOfSize:height(17)] textAlignmen:NSTextAlignmentCenter text:@"时间"];
    [self.view addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab2.mas_right).offset(width(0));
        make.height.mas_equalTo(height(17));
        make.width.mas_equalTo(kScreenWidth/4);
        make.top.mas_equalTo(self.gonglable.mas_bottom).offset(height(20));
    }];
    UIButton * zbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [zbtn setBackgroundImage:[UIImage imageNamed:@"zy"] forState:0];
    [self.view addSubview:zbtn];
    [zbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-width(18));
        make.centerY.mas_equalTo(zilable.mas_centerY);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(81.5);
    }];
    [[zbtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ZRYViewController * VC =[[ZRYViewController alloc]init];
        VC.money =self.moneyLable.text;
        [self.navigationController pushViewController:VC animated:YES];
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lab.mas_bottom).offset(height(10));
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self load_walletDetails:YES];
    }];
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self load_walletDetails:NO];
    }];
    [self load_walletDetails:YES];
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[YJDetailCell class] forCellReuseIdentifier:@"YJDetailCell"];
    }
    return _tableView;
}
-(void)load_walletDetails:(BOOL)isYes{
    [HttpTool get:API_POST_myBrokerage dic:@{@"page":[NSString stringWithFormat:@"%d",self.page],@"pagesize":@"15"} success:^(id  _Nonnull responce) {
        self.tableView.ly_emptyView =[MyDIYEmpty diyNoDataEmpty];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([responce[@"code"] intValue]==200) {
            self.moneyLable.text =[NSString stringWithFormat:@"%@",responce[@"data"][@"brokerage"]];
            self.kelable.text =[NSString stringWithFormat:@"累计收益:%@",responce[@"data"][@"income"]];
            self.gonglable.text =[NSString stringWithFormat:@"共%@条收入,共%@元",responce[@"data"][@"num"],responce[@"data"][@"income"]];
            if (isYes==YES) {
                
                self.dataArr =[WalletModel mj_objectArrayWithKeyValuesArray:responce[@"data"][@"list"]];
                
                if ([WalletModel mj_objectArrayWithKeyValuesArray:responce[@"data"][@"list"]].count<15) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                if ([WalletModel mj_objectArrayWithKeyValuesArray:responce[@"data"][@"list"]].count==0) {
                    self.tableView.mj_footer.hidden =YES;
                }
            }else{
                [self.dataArr addObjectsFromArray:[WalletModel mj_objectArrayWithKeyValuesArray:responce[@"data"][@"list"]]];
                
                if ([WalletModel mj_objectArrayWithKeyValuesArray:responce[@"data"][@"list"]].count<15) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }else{
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
             self.tableView.mj_footer.hidden =YES;
        }
        [self.tableView reloadData];
    } faile:^(NSError * _Nonnull erroe) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"YJDetailCell"];
    cell.backgroundColor=UIColor.whiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WalletModel*model =self.dataArr[indexPath.section];
    [cell chuanzhiWalletModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return height(45);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heardView =[[UIView alloc]initWithFrame:CGRectMake(width(15), 0, kScreenWidth-width(30), 1)];
    heardView.backgroundColor = BassColor(241, 241, 241);
    return heardView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    footView.backgroundColor = BassColor(241, 241, 241);
    return footView;
}
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
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
