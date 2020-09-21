//
//  MessageDeitalVC.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "MessageDeitalVC.h"
#import "MessageDetailCell.h"
#import "MessageModel.h"
@interface MessageDeitalVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,assign)int page;
@end

@implementation MessageDeitalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self.view addSubview:self.tableView];
    self.page=1;
    if (self.typeIndex==10010) {
     [self setNavTitle:@"我的推荐"];
    }else{
        [self setNavTitle:@"系统通知"];
    }
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self load_myRecommend_notice:YES];
    }];
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self load_myRecommend_notice:NO];
    }];
    [self load_myRecommend_notice:YES];
    // Do any additional setup after loading the view.
}
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)load_myRecommend_notice:(BOOL)isYes{//   #define
    NSString * urlStr;
    if (self.typeIndex==10010) {
        urlStr =API_POST_myRecommend;
    }else{
       urlStr =API_POST_notice;
    }
    [HttpTool get:urlStr dic:@{@"pagesize":@"15",@"page":[NSString stringWithFormat:@"%d",self.page]} success:^(id  _Nonnull responce) {
        self.tableView.ly_emptyView =[MyDIYEmpty diyNoDataEmpty];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responce[@"code"] intValue]==200) {
            if (isYes==YES) {
                self.dataArr =[MessageModel mj_objectArrayWithKeyValuesArray:responce[@"data"]];
                if ([MessageModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count<15) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                if ([MessageModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count==0) {
                    self.tableView.mj_footer.hidden=YES;
                }
            }else{
                [self.dataArr addObjectsFromArray:[MessageModel mj_objectArrayWithKeyValuesArray:responce[@"data"]]];
                if ([MessageModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count<15) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }else{
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            self.tableView.mj_footer.hidden=YES;
        }
        [self.tableView reloadData];
        
    } faile:^(NSError * _Nonnull erroe) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-NavHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =BassColor(241, 241, 241);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[MessageDetailCell class] forCellReuseIdentifier:@"cell"];
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
    MessageDetailCell* cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor =BassColor(241, 241, 241);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.typeIndex==10010) {
        cell.titlelable.text = @"用户推荐";
    }else{
        cell.titlelable.text = @"系统通知";
    }
    MessageModel * model =self.dataArr[indexPath.section];
    [cell chuanZhiMessageModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return height(100);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return height(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MessageModel * model =self.dataArr[section];
    UIView * heardView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height(60))];
    UIButton * timeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [timeBtn setTitle:model.addtime forState:0];
    [timeBtn setTitleColor:UIColor.whiteColor forState:0];
    timeBtn.backgroundColor = BassColor(217, 217, 217);
    timeBtn.titleLabel.font =VFont;
    [heardView addSubview:timeBtn];
    [timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(heardView.mas_centerY);
        make.centerX.mas_equalTo(heardView.mas_centerX);
        make.height.mas_equalTo(height(36));
        make.width.mas_equalTo(width(150));
    }];
    timeBtn.layer.masksToBounds =YES;
    timeBtn.layer.cornerRadius = height(18);
    heardView.backgroundColor = BassColor(241, 241, 241);
    return heardView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    footView.backgroundColor = BassColor(241, 241, 241);
    return footView;
}

@end
