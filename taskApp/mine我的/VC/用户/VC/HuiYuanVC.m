//
//  HuiYuanVC.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "HuiYuanVC.h"
#import "HuiYuanCell.h"
#import "HuiYuanModel.h"
@interface HuiYuanVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,copy)NSString * typeStr;
@property(nonatomic,assign)int page;
@end

@implementation HuiYuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor =UIColor.whiteColor;
    [self setNavTitle:@"用户"];
    self.typeStr = @"1";
    self.dataArr =[[NSMutableArray alloc]init];
    self.page=1;
       [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
   
    NSArray *array = [NSArray arrayWithObjects:@"上级代理",@"下级会员", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.frame = CGRectMake(width(15), height(21), kScreenWidth-width(30), 30);
    segment.selectedSegmentIndex=0;
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(segment.mas_bottom).offset(height(15));
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    }];
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self load_superiorMember:YES];
    }];
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self load_superiorMember:NO];
    }];
    [self load_superiorMember:YES];
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =UIColor.whiteColor;//BassColor(241, 241, 241);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[HuiYuanCell class] forCellReuseIdentifier:@"HuiYuanCell"];
    }
    return _tableView;
}
-(void)load_superiorMember:(BOOL)isYes{
    [HttpTool get:API_POST_superiorMember dic:@{@"page":[NSString stringWithFormat:@"%d",self.page],@"pagesize":@"15",@"type":self.typeStr} success:^(id  _Nonnull responce) {
        self.tableView.ly_emptyView =[MyDIYEmpty diyNoDataEmpty];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([responce[@"code"] intValue]==200) {
            if (isYes==YES) {
                [self.dataArr removeAllObjects];
                self.dataArr =[HuiYuanModel mj_objectArrayWithKeyValuesArray:responce[@"data"]];

                if ([HuiYuanModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count<15) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                if ([HuiYuanModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count==0) {
                    self.tableView.mj_footer.hidden =YES;
                }
            }else{
                [self.dataArr addObjectsFromArray:[HuiYuanModel mj_objectArrayWithKeyValuesArray:responce[@"data"]]];

                if ([HuiYuanModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count<15) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }else{
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
             self.tableView.mj_footer.hidden =YES;
             [self.dataArr removeAllObjects];
        }
        [self.tableView reloadData];
    } faile:^(NSError * _Nonnull erroe) {

    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HuiYuanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"HuiYuanCell"];
    cell.backgroundColor=UIColor.whiteColor;
        HuiYuanModel*model =self.dataArr[indexPath.section];
        [cell chuanzhiHuiYuanModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 46;
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
//点击不同分段就会有不同的事件进行相应
-(void)change:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        self.typeStr=@"1";
    }else{
        self.typeStr=@"2";
    }
    [self load_superiorMember:YES];
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
