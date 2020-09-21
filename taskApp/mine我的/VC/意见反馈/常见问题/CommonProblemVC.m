//
//  CommonProblemVC.m
//  taskApp
//
//  Created by per on 2019/11/15.
//  Copyright © 2019 per. All rights reserved.
//

#import "CommonProblemVC.h"
#import "ProblemCell.h"
#import "MineModel.h"
#import "FeedbackVC.h"
@interface CommonProblemVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)UIImageView * wenImg;
@property(nonatomic,strong)UIImageView * rightImg;
@property(nonatomic,strong)UILabel * wenLabel;
@property(nonatomic,strong)NSMutableArray * isExpandArray;
@end

@implementation CommonProblemVC

-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page=1;
    // Do any additional setup after loading the view.
    _isExpandArray =[[NSMutableArray alloc]init];
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setNavTitle:@"常见问题"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self load_question:YES];
    }];
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self load_question:NO];
    }];
    [self load_question:YES];
}
-(void)load_question:(BOOL)isYes{
    [HttpTool get:API_POST_question dic:@{@"page":[NSString stringWithFormat:@"%d",self.page],@"pagesize":@"15"} success:^(id  _Nonnull responce) {
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([responce[@"code"] intValue]==200) {
            if (isYes==YES) {
                [self.isExpandArray removeAllObjects];
                self.dataArr =[MineModel mj_objectArrayWithKeyValuesArray:responce[@"data"]];
                
                if ([MineModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count<15) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                if ([MineModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count==0) {
                    self.tableView.mj_footer.hidden =YES;
                }
                for (NSInteger i = 0; i < self.dataArr.count; i++) {
                    [self.isExpandArray addObject:@"0"];//0:没展开 1:展开
                }
            }else{
                [self.dataArr addObjectsFromArray:[MineModel mj_objectArrayWithKeyValuesArray:responce[@"data"]]];
                for (NSInteger i = 0; i < self.dataArr.count; i++) {
                    [self.isExpandArray addObject:@"0"];//0:没展开 1:展开
                }
                if ([MineModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count<15) {
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
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =BassColor(241, 241, 241);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled =NO;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[ProblemCell class] forCellReuseIdentifier:@"ProblemCell"];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([_isExpandArray[section] isEqualToString:@"1"]) {
       return 1;
    }else{
        return 0;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProblemCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ProblemCell"];
    cell.backgroundColor=UIColor.whiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MineModel * model =self.dataArr[indexPath.section];
    [cell chuanZhiMineModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MineModel * model =self.dataArr[section];
    UIView * heardView =[[UIView alloc]init];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    heardView.tag = section;
    [heardView addGestureRecognizer:recognizer];
    heardView.frame =CGRectMake(0, 0, kScreenWidth, 45);
    heardView.backgroundColor = BassColor(255, 255, 255);
    self.wenImg =[[UIImageView alloc]init];
    self.wenImg.image =[UIImage imageNamed:@"wen"];
    [heardView addSubview:self.wenImg];
    [self.wenImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(heardView).offset(width(15));
        make.width.height.mas_equalTo(15);
        make.top.mas_equalTo(heardView.mas_top).offset(height(15));
    }];
    self.wenLabel =[[UILabel alloc]init];
    self.wenLabel.textColor = BassColor(0, 0, 0);
    self.wenLabel.font = VFont;
    self.wenLabel.text = model.title;;
    self.wenLabel.numberOfLines=0;
    [heardView addSubview:self.wenLabel];
    [self.wenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.wenImg.mas_right).offset(width(15));
        make.top.mas_equalTo(heardView).offset(height(15));
        make.right.mas_equalTo(heardView.mas_right).offset(-width(15));
    }];
    self.rightImg =[[UIImageView alloc]init];
    if ([_isExpandArray[section] isEqualToString:@"1"]) {
        self.rightImg.image =[UIImage imageNamed:@"shang"];
    }else{
        self.rightImg.image =[UIImage imageNamed:@"xia"];
    }
    
    [heardView addSubview:self.rightImg];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(heardView.mas_right).offset(-width(15));
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(6);
        make.top.mas_equalTo(heardView.mas_top).offset(height(15));
    }];
    return heardView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]init];
    
    footView.frame= CGRectMake(0, 0, kScreenWidth, 0.0001);
    footView.backgroundColor = BassColor(241, 241, 241);
    
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section==0) {
//        FeedbackVC * VC =[[FeedbackVC alloc]init];
//        VC.hidesBottomBarWhenPushed =YES;
//        [self.navigationController pushViewController:VC animated:YES];
//    }else{
//        CommonProblemVC * VC =[[CommonProblemVC alloc]init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }
//    
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"%ld",(long)tap.view.tag);
    if ([_isExpandArray[tap.view.tag] isEqualToString:@"0"]) {
        //关闭 => 展开
        [_isExpandArray removeObjectAtIndex:tap.view.tag];
        [_isExpandArray insertObject:@"1" atIndex:tap.view.tag];
    }else{
        //展开 => 关闭
        [_isExpandArray removeObjectAtIndex:tap.view.tag];
        [_isExpandArray insertObject:@"0" atIndex:tap.view.tag];
        
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:tap.view.tag];
    NSRange rang = NSMakeRange(indexPath.section, 1);
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:rang];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
}

@end
