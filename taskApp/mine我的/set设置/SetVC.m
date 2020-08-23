//
//  SetVC.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "SetVC.h"
#import "MineModel.h"
#import "SetCell.h"
#import "LoginViewController.h"
#import "SDImageCache.h"
#import "AboutUsVC.h"
#import "PasswordViewController.h"

@interface SetVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation SetVC
-(void)clickBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setNavTitle:@"设置"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self.view addSubview:self.tableView];
     self.dataArr=[MineModel mj_objectArrayWithKeyValuesArray:@[@{@"name":@"设置密码",@"img":@"lishi"},@{@"name":@"清除缓存",@"img":@"lishi"},@{@"name":@"检查更新",@"img":@"gongzuo"},@{@"name":@"关于我们",@"img":@"bangzhu"}]];
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
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        UIButton *tiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tiBtn.backgroundColor = BassColor(17, 151, 255);
        [tiBtn setTitle:@"退出登录" forState:0];
        tiBtn.titleLabel.font = VPFont(@"PingFang-SC-Medium", height(17));
        [tiBtn setTitleColor:UIColor.whiteColor forState:0];
        [footView addSubview:tiBtn];
        [tiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(footView.mas_centerX);
            make.width.mas_equalTo(width(302));
            make.height.mas_equalTo(height(34));
            make.top.mas_equalTo(footView.mas_bottom).offset(-height(25));
        }];
        tiBtn.layer.masksToBounds = YES;
        tiBtn.layer.cornerRadius = height(17);
        [[tiBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uuid"];
            LoginViewController * loginVC = [[LoginViewController alloc]init];
            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
            UIWindow * window = [UIApplication sharedApplication].delegate.window;
            window.rootViewController =loginNav;
        }];
        
        _tableView.tableFooterView = footView;
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
    UIView * footView =[[UIView alloc]init];
    footView.frame= CGRectMake(0, 0, kScreenWidth, 0.0001);
    footView.backgroundColor = BassColor(241, 241, 241);
   
    return footView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        PasswordViewController * VC = [[PasswordViewController alloc] initWithType: NO];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section==1) {
        NSUInteger intg =[[SDImageCache sharedImageCache] totalDiskSize];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@内存",[self fileSizeWithInterge:intg]] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else if (indexPath.section==2){
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        [HttpTool get:API_POST_checkBb dic:@{@"type":@"2",@"bbnum":[NSString stringWithFormat:@"%@",  [infoDictionary objectForKey:@"CFBundleShortVersionString"]]} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否更新" message:@"发现新的版本" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"是", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil]];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
               [self showToastInView:self.view message:@"已是最新版本" duration:0.8];
            }
        } faile:^(NSError * _Nonnull erroe) {
            
        }];
        
    }else{
        AboutUsVC * VC =[[AboutUsVC alloc] init];
        VC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//计算出大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

@end
