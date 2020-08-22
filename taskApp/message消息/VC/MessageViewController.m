//
//  MessageViewController.m
//  taskApp
//
//  Created by 二恒 on 2019/11/7.
//  Copyright © 2019 per. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "MessageModel.h"
#import "MessageDeitalVC.h"
#import "CustomerServiceVC.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation MessageViewController
-(void)clickBtn{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BassColor(241, 241, 241);
     [self setLeftButton:@"消息中心" imgStr:@"" selector:@selector(clickBtn)];
    [self.view addSubview:self.tableView];
    self.dataArr =[MessageModel mj_objectArrayWithKeyValuesArray:@[@{@"name":@"我的推荐",@"commit":@"您推荐的用户",@"img":@"liwu"},@{@"name":@"联系客服",@"commit":@"收到您的留言,我们会第一时间回复",@"img":@"kefu"},@{@"name":@"系统通知",@"commit":@"您的任务奖励已到账，请查收",@"img":@"tongzhi拷贝"}]];
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, height(10), kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[MessageCell class] forCellReuseIdentifier:@"cell"];
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
    MessageCell* cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor =UIColor.whiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageModel * model =self.dataArr[indexPath.section];
    [cell chuanZhiMessageModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return height(100);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heardView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
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
        MessageDeitalVC * VC =[[MessageDeitalVC alloc]init];
        VC.hidesBottomBarWhenPushed =YES;
        VC.typeIndex=10010;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section==1){
        CustomerServiceVC * VC =[[CustomerServiceVC alloc]init];
        VC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        MessageDeitalVC * VC =[[MessageDeitalVC alloc]init];
        VC.hidesBottomBarWhenPushed =YES;
        VC.typeIndex=10011;
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
