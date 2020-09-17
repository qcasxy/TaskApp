//
//  HomeViewController.m
//  taskApp
//
//  Created by 二恒 on 2019/11/7.
//  Copyright © 2019 per. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell1.h"
#import "HomeCell2.h"
#import "HomeCell3.h"
#import "HomeCell4.h"
#import "LableModel.h"
#import "ListModel.h"
#import "RegisDetailVC.h"
#import "OrdinaryVC.h"
#import "QianDaoViewController.h"
#import "HomeWebViC.h"
#import "XinVipVC.h"
#import "MineModel.h"
#import "HomeBannerModel.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HomeCell1Delegate>
@property(nonatomic,strong)UICollectionView * homenCollection;
@property(nonatomic,strong)NSMutableArray * listArr;
@property(nonatomic,strong)NSMutableArray * lableArr;
@property(nonatomic,strong)NSArray<HomeBannerModel *> * bannerArr;
@property(nonatomic,strong)NSMutableArray * coverArr;
@property(nonatomic,strong)NSMutableArray * coverUrlArr;
@property(nonatomic,strong)MineModel * cellModel;
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self load_home_index];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setLeftButton:@"赚钱中心" imgStr:@"" selector:@selector(clickBtn)];
    self.bannerArr = [NSArray array];
    self.lableArr = [[NSMutableArray alloc]init];
    self.coverArr = [[NSMutableArray alloc]init];
    self.coverUrlArr = [[NSMutableArray alloc]init];
    [self.view addSubview:self.homenCollection];
    [self load_home_index];
    self.homenCollection.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self load_home_index];
    }];
    [self load_userIndex];
    // Do any additional setup after loading the view.
}
-(void)load_userIndex{
    [HttpTool get:API_POST_userIndex dic:@{} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            self.cellModel =[MineModel mj_objectWithKeyValues:responce[@"data"]];
            NSDictionary  *dic = responce[@"data"];
            if ([[dic allKeys] containsObject:@"account"]) {
                [[NSUserDefaults standardUserDefaults] setObject:responce[@"data"][@"account"] forKey:@"aliAccount"];
            }
            if ([[dic allKeys] containsObject:@"username"]) {
                [[NSUserDefaults standardUserDefaults] setObject:responce[@"data"][@"username"] forKey:@"aliName"];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            [self showToastInView:self.view message:responce[@"msg"] duration:0.8];
        }
    } faile:^(NSError * _Nonnull erroe) {
        
    }];
}

-(void)load_home_index {
    [HttpTool get:API_POST_Home_index dic:@{@"client":@"2"} success:^(id  _Nonnull responce) {
        self.homenCollection.ly_emptyView = [MyDIYEmpty diyNoDataEmpty];
        [self.homenCollection.mj_header endRefreshing];
        if ([responce[@"code"] intValue]==200) {
            [self.coverUrlArr removeAllObjects];
            [self.coverArr removeAllObjects];
            [self.lableArr removeAllObjects];
            
            self.bannerArr = [HomeBannerModel mj_objectArrayWithKeyValuesArray:responce[@"data"][@"banner"]];
            [responce[@"data"][@"banner"] enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.coverArr addObject:obj[@"cover"]];
//                [self.coverUrlArr addObject:obj[@"url"]];
            }];
            
            self.listArr = [ListModel mj_objectArrayWithKeyValuesArray:responce[@"data"][@"list"]];
            [responce[@"data"][@"list"] enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.lableArr addObject:[LableModel mj_objectArrayWithKeyValuesArray:dic[@"label"]]];
            }];
            [self.homenCollection reloadData];
        }else {
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message: @"网络错误\n请稍后下拉刷新页面" duration:0.8];
    }];
}

-(UICollectionView*)homenCollection {
    if (!_homenCollection) {
        UICollectionViewFlowLayout * flow =[[UICollectionViewFlowLayout alloc]init];
        
        _homenCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavHeight - TabBaHeight) collectionViewLayout:flow];
        _homenCollection.delegate =self;
        _homenCollection.dataSource=self;
        [_homenCollection registerClass:[HomeCell1 class] forCellWithReuseIdentifier:@"HomeCell1"];
        [_homenCollection registerClass:[HomeCell2 class] forCellWithReuseIdentifier:@"HomeCell2"];
        [_homenCollection registerClass:[HomeCell3 class] forCellWithReuseIdentifier:@"HomeCell3"];
        [_homenCollection registerClass:[HomeCell4 class] forCellWithReuseIdentifier:@"HomeCell4"];
        
        _homenCollection.backgroundColor =UIColor.whiteColor;
    }
    return _homenCollection;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 1;
    }else{
        return self.listArr.count;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        HomeCell1 * cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell1" forIndexPath:indexPath];
        cell1.coverArr = self.coverArr;
        cell1.delegate = self;
        return cell1;
    }else if (indexPath.section==1){
        HomeCell2 * cell2=[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell2" forIndexPath:indexPath];
        return cell2;
    }else if (indexPath.section==2){
        HomeCell3 * cell3=[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell3" forIndexPath:indexPath];
        return cell3;
    }
    else{
        HomeCell4 * cell4=[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell4" forIndexPath:indexPath];
        
        cell4.backgroundColor = BassColor(255,255,255);
        if (indexPath.row < self.lableArr.count) {
            ListModel * model =self.listArr[indexPath.row];
            cell4.numLable.text =[NSString stringWithFormat:@"%ld",indexPath.row + 1];
            [cell4 chuanZhiListModel:model modelArr:self.lableArr[indexPath.row]];
        }
        
        return cell4;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(kScreenWidth, height(210));
    }else if(indexPath.section==1){
        return CGSizeMake(kScreenWidth, height(100));
    }else if(indexPath.section==2){
        return CGSizeMake(kScreenWidth, height(45));
    }else{
        return CGSizeMake(kScreenWidth, height(85));
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==1) {
        return UIEdgeInsetsMake(0, 0, 1, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==1) {
        return 1;
    }
    return 0.0001;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section==1) {
        return 1;
    }
    return 0.0001;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
    }
    //    else if (indexPath.section==1){
    //        if (indexPath.row==0) {
    ////            [HttpTool get:API_POST_clockRecord dic:@{} success:^(id  _Nonnull responce) {
    ////                if ([responce[@"code"] intValue]==200) {
    ////                    NSDate *date =[NSDate date];//简书 FlyElephant
    ////                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    ////                    [formatter setDateFormat:@"yyyy"];
    ////                    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    ////                    [formatter setDateFormat:@"MM"];
    ////                    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    ////                    NSMutableArray * titleArr =[NSMutableArray new];
    ////                    //创建一个数组记录已经签过到的天
    ////                    [responce[@"data"][@"calendar"] enumerateObjectsUsingBlock:^(NSDictionary *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
    ////                        if ([obj[@"status"] intValue]==1) {
    ////                            [titleArr addObject:[NSString stringWithFormat:@"%ld-%ld-%@",(long)currentYear,(long)currentMonth,obj[@"day"]]];
    ////                        }
    ////
    ////                    }];
    ////                    QianDaoViewController *VC =[[QianDaoViewController alloc]init];
    ////                    VC.hidesBottomBarWhenPushed =YES;
    ////                    VC.dataArr = titleArr;
    ////                    VC.datadic =responce[@"data"];
    ////                    [self.navigationController pushViewController:VC animated:YES];
    ////                }
    ////
    ////            } faile:^(NSError * _Nonnull erroe) {
    ////
    ////            }];
    //            [self showToastInView:self.view message:@"暂未开放" duration:0.8];
    //
    //        }
    //    }
    else if (indexPath.section==1){
        XinVipVC * VC=[[XinVipVC alloc]init];
        VC.hidesBottomBarWhenPushed=YES;
        VC.mmodel=self.cellModel;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (self.listArr.count > indexPath.row) {
        [self showDGActView];
        ListModel * model = self.listArr[indexPath.row];
        [HttpTool get:API_POST_taskInfo dic:@{@"id":model.listID} success:^(id  _Nonnull responce) {
            [self stopDGActView];
            TaskInfoModel *model = [TaskInfoModel mj_objectWithKeyValues:responce[@"data"]];
            if ([responce[@"code"] intValue] == 200 && model != nil) {
                if ([responce[@"data"][@"cateid"] intValue]==1) {
                    RegisDetailVC * VC = [[RegisDetailVC alloc] initModel:model];
                    VC.hidesBottomBarWhenPushed=YES;
                    VC.dataDic = responce[@"data"];
                    VC.homeIndex = 102;
                    [self.navigationController pushViewController:VC animated:YES];
                }else {
                    OrdinaryVC * VC =[[OrdinaryVC alloc] initModel:model];
                    VC.hidesBottomBarWhenPushed=YES;
                    VC.homeIndex = 102;
                    VC.dataDic = responce[@"data"];
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }else {
                [self showToastInView:self.view message: @"暂时无法查看" duration:0.8];
            }
        } faile:^(NSError * _Nonnull erroe) {
            [self stopDGActView];
            [self showToastInView:self.view message: @"网络错误，暂时无法查看" duration:0.8];
        }];
    }
}

-(void)clickBtn {
    
}

-(void)goToWeb:(NSInteger)index {
    if (index < self.bannerArr.count) {
        if (self.bannerArr[index].type == 1) {
            if (self.bannerArr[index].detail != nil) {
                HomeWebViC * webVC =[[HomeWebViC alloc] initWithContent:self.bannerArr[index].detail];
                webVC.name = self.bannerArr[index].title;
                webVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:webVC animated:YES];
                return;
            }
        }else {
            NSString* urlStr = self.bannerArr[index].url;
            
            NSURL *url;
            
            if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString: urlStr]]) {
                url = [NSURL URLWithString: urlStr];
            }else if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", urlStr]]]) {
                url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", urlStr]];
            }
            if (url != nil) {
                HomeWebViC * webVC =[[HomeWebViC alloc] initWithURL:url];
                webVC.name = self.bannerArr[index].title;
                webVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:webVC animated:YES];
                return;
            }
        }
    }
    [self showToastInView:self.view message: @"无法打开该页面" duration: 0.8];
}
@end
