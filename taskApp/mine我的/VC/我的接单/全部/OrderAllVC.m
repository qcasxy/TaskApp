//
//  OrderAllVC.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "OrderAllVC.h"
#import "OrderCell.h"
#import "LableModel.h"
#import "ListModel.h"
#import "OrderDownloadVC.h"
#import "OrderDetailVC.h"
#import "TaskInfoModel.h"

@interface OrderAllVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSMutableArray * listArr;
@property(nonatomic,strong)NSMutableArray * lableArr;
@end

@implementation OrderAllVC

- (instancetype)initType:(int)type {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BassColor(241, 241, 241);
    [self.view addSubview:self.tableView];
    self.lableArr=[[NSMutableArray alloc]init];
    self.page=1;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self load_taskRecord:YES];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self load_taskRecord:NO];
    }];
    [self load_taskRecord:YES];
    // Do any additional setup after loading the view.
}

-(void)load_taskRecord:(BOOL)isYes{
    [HttpTool get:API_POST_taskRecord dic:@{@"type":[NSString stringWithFormat:@"%d",self.type],@"pagesize":@"15",@"page":[NSString stringWithFormat:@"%d",self.page]} success:^(id  _Nonnull responce) {
        self.tableView.ly_emptyView =[MyDIYEmpty diyNoDataEmpty];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([responce[@"code"] intValue]==200) {
            
            if (isYes==YES) {
                [self.lableArr removeAllObjects];
                
                self.listArr =[ListModel mj_objectArrayWithKeyValuesArray:responce[@"data"]];
                [responce[@"data"] enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.lableArr addObject:[LableModel mj_objectArrayWithKeyValuesArray:dic[@"label"]]];
                }];
                if ([ListModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count<15) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                if ([ListModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count==0) {
                    self.tableView.mj_footer.hidden =YES;
                }
            }else{
                [self.listArr addObjectsFromArray:[ListModel mj_objectArrayWithKeyValuesArray:responce[@"data"]]];
                [responce[@"data"] enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.lableArr addObject:[LableModel mj_objectArrayWithKeyValuesArray:dic[@"label"]]];
                }];
                if ([ListModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count<15) {
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

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-NavHeight-height(40)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[OrderCell class] forCellReuseIdentifier:@"OrderCell"];
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    cell.backgroundColor=UIColor.whiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ListModel * model =self.listArr[indexPath.section];
    [cell chuanZhiListModel:model modelArr:self.lableArr[indexPath.section]];
    cell.numLable.text =[NSString stringWithFormat:@"%ld",indexPath.section+1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return height(79);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return height(10);
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heardView =[[UIView alloc]init];
    if (section==0) {
        heardView.frame = CGRectMake(0, 0, kScreenWidth, height(10));
    }else{
        CGRectMake(0, 0, kScreenWidth, 1);
    }
    heardView.backgroundColor = BassColor(241, 241, 241);
    return heardView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    footView.backgroundColor = BassColor(241, 241, 241);
    return footView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListModel * model =self.listArr[indexPath.section];
    [HttpTool get:API_POST_taskDetails dic:@{@"id":model.listID} success:^(id  _Nonnull responce) {
        NSLog(@"12%@",responce);
        TaskDetailModel *model = [TaskDetailModel mj_objectWithKeyValues:responce[@"data"]];
        if ([responce[@"code"] intValue] == 200 && model != nil) {
            if ([responce[@"data"][@"cateid"] intValue]==1) {
                OrderDownloadVC * VC =[[OrderDownloadVC alloc] initModel:model];
                VC.hidesBottomBarWhenPushed=YES;
                VC.dataDic =responce[@"data"];
                [self.navigationController pushViewController:VC animated:YES];
                
            }else{
                OrderDetailVC * VC =[[OrderDetailVC alloc] initModel:model];
                VC.hidesBottomBarWhenPushed=YES;
                VC.dataDic =responce[@"data"];
                [self.navigationController pushViewController:VC animated:YES];
            }
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}

@end
