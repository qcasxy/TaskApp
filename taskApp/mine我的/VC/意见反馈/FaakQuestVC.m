//
//  FaakQuestVC.m
//  taskApp
//
//  Created by per on 2019/11/15.
//  Copyright © 2019 per. All rights reserved.
//

#import "FaakQuestVC.h"
#import "SetCell.h"
#import "FeedbackVC.h"
#import "CommonProblemVC.h"
@interface FaakQuestVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation FaakQuestVC
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setNavTitle:@"意见反馈"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self.view addSubview:self.tableView];
    self.dataArr=[MineModel mj_objectArrayWithKeyValuesArray:@[@{@"name":@"问题反馈",@"img":@"lishi"},@{@"name":@"常见问题",@"img":@"gongzuo"}]];
    // Do any additional setup after loading the view.
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =BassColor(241, 241, 241);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled =NO;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[SetCell class] forCellReuseIdentifier:@"SetCell"];
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
    
    SetCell * cell =[tableView dequeueReusableCellWithIdentifier:@"SetCell"];
    cell.backgroundColor=UIColor.whiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MineModel * model =self.dataArr[indexPath.section];
    [cell chuanZhiMineModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
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
       heardView.frame =CGRectMake(0, 0, kScreenWidth, height(10));
    }else{
         heardView.frame =CGRectMake(0, 0, kScreenWidth, 1);
    }
    heardView.backgroundColor = BassColor(241, 241, 241);
    return heardView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]init];
    
        footView.frame= CGRectMake(0, 0, kScreenWidth, 0.0001);
    footView.backgroundColor = BassColor(241, 241, 241);
    
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section==0) {
        FeedbackVC * VC =[[FeedbackVC alloc]init];
        VC.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        CommonProblemVC * VC =[[CommonProblemVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
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
