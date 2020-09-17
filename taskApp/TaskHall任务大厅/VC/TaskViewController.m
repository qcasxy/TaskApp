//
//  TaskViewController.m
//  taskApp
//
//  Created by 二恒 on 2019/11/7.
//  Copyright © 2019 per. All rights reserved.
//

#import "TaskViewController.h"
#import "HomeCell4.h"
#import "ListModel.h"
#import "TaskBtnView.h"
#import "RegisDetailVC.h"
#import "OrdinaryVC.h"
#import "TaskTanVC.h"
#import "AppDelegate.h"
#import "SPButton.h"
@interface TaskViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TaskBtnViewDelegate,TaskTanVCDelegate>
@property(nonatomic,strong)UICollectionView * taskCollection;
@property(nonatomic,strong)NSMutableArray * listArr;
@property(nonatomic,strong)NSMutableArray * lableArr;
@property(nonatomic,assign)int page;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * cateid;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * labelStr;
@property(nonatomic,copy)NSString * keyword;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.lableArr =[[NSMutableArray alloc]init];
    self.listArr=[[NSMutableArray alloc]init];
    self.page=1;
    self.type=@"2";
    self.price=@"";
    self.labelStr=@"";
    self.keyword = @"";
    //    [self setLeftButton:@"任务大厅" imgStr:@"sousuo" selector:@selector(clickBtn)];
    UIView * leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, width(170), height(44))];
    UILabel * lab =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"", height(23)) textAlignmen:NSTextAlignmentLeft text:@"任务大厅"];
    lab.font = [UIFont systemFontOfSize:23];
    lab.frame= CGRectMake(width(0), 0,width(110), height(44));
    [leftView addSubview:lab];
    UIButton * imgBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setImage:[UIImage imageNamed:@"shuaxin"] forState:0];
    imgBtn.frame =CGRectMake(width(115), height(13.5), height(20), height(20));
    [leftView addSubview:imgBtn];
    [imgBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem =leftItem;
    [self setRightButton:@"" imgStr:@"sousuo" selector:@selector(clickSouSuo)];
    TaskBtnView * btnview =[[TaskBtnView alloc]init];
    btnview.delegate=self;
    btnview.backgroundColor =[UIColor whiteColor];
    btnview.frame
    = CGRectMake(0, 0, kScreenWidth, height(50));
    
    [self.view addSubview:btnview];
    UIView * line =[[UIView alloc]init];
    line.backgroundColor = BassColor(241, 241, 241);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(height(10));
        make.top.mas_equalTo(btnview.mas_bottom).offset(0);
    }];
    [self.view addSubview:self.taskCollection];
    self.taskCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self load_taskIndex:YES];
    }];
    self.taskCollection.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self load_taskIndex:NO];
    }];
    
    [self.taskCollection.mj_header beginRefreshing];
}

-(void)clickBtn {
    [self.taskCollection.mj_header beginRefreshing];
}

-(void)clickSouSuo {
    AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    TaskTanVC * VC = [[TaskTanVC alloc]init];
    VC.delegate = self;
    //设置模式展示风格
    [VC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    //必要配置
    appdelegate.window.rootViewController.modalPresentationStyle =UIModalPresentationOverFullScreen;
    appdelegate.window.rootViewController.providesPresentationContextTransitionStyle = YES;
    appdelegate.window.rootViewController.definesPresentationContext = YES;
    //    VC.tanModel = self.model;
    [appdelegate.window.rootViewController presentViewController:VC animated:YES completion:nil];
    //    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    //    TaskTanVC *vc=[[TaskTanVC alloc]init];
    //    appdelegate.window.rootViewController.modalPresentationStyle=UIModalPresentationCurrentContext;
    //
    //    [appdelegate.window.rootViewController presentViewController:vc animated:YES completion:^{
    //        vc.view.backgroundColor=[UIColor colorWithRed:135/255 green:135/255 blue:135/255 alpha:0.1];;
    //        appdelegate.window.rootViewController.modalPresentationStyle=UIModalPresentationFullScreen;
    //
    //    }];
}

-(void)load_taskIndex:(BOOL)isYes {
    [HttpTool get:API_POST_taskIndex dic:@{@"type":self.type,@"price":self.price,@"label":self.labelStr,@"client":@"2",@"page":[NSString stringWithFormat:@"%d",self.page],@"pagesize":@"15",@"keyword":self.keyword} success:^(id  _Nonnull responce) {
        self.taskCollection.ly_emptyView =[MyDIYEmpty diyNoDataEmpty];
        [self.taskCollection.mj_header endRefreshing];
        [self.taskCollection.mj_footer endRefreshing];
        if ([responce[@"code"] intValue] == 200) {
            if (isYes) {
                [self.lableArr removeAllObjects];
                [self.listArr removeAllObjects];
                self.taskCollection.mj_footer.hidden = YES;
            }
            
            [self.listArr addObjectsFromArray:[ListModel mj_objectArrayWithKeyValuesArray:responce[@"data"]]];
            [responce[@"data"] enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.lableArr addObject:[LableModel mj_objectArrayWithKeyValuesArray:dic[@"label"]]];
            }];
            if ([ListModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count==0) {
                self.taskCollection.mj_footer.hidden = YES;
            }else if ([ListModel mj_objectArrayWithKeyValuesArray:responce[@"data"]].count<15) {
                [self.taskCollection.mj_footer endRefreshingWithNoMoreData];
            }else if (isYes) {
                self.taskCollection.mj_footer.hidden = NO;
            }
            
            NSLog(@"=====%@",responce[@"data"][0][@"label"]);
            
        }else{
            [self.lableArr removeAllObjects];
            [self.listArr removeAllObjects];
            self.taskCollection.mj_footer.hidden=YES;
        }
        [self.taskCollection reloadData];
    } faile:^(NSError * _Nonnull erroe) {
        
    }];
}
-(UICollectionView*)taskCollection{
    if (!_taskCollection) {
        UICollectionViewFlowLayout * flow =[[UICollectionViewFlowLayout alloc]init];
        
        _taskCollection =[[UICollectionView alloc]initWithFrame:CGRectMake(0, height(60), kScreenWidth, kScreenHeight-NavHeight-TabBaHeight-height(60)) collectionViewLayout:flow];
        _taskCollection.delegate =self;
        _taskCollection.dataSource=self;
        [_taskCollection registerClass:[HomeCell4 class] forCellWithReuseIdentifier:@"HomeCell4"];
        
        _taskCollection.backgroundColor =UIColor.whiteColor;
    }
    return _taskCollection;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  self.listArr.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCell4 * cell4=[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell4" forIndexPath:indexPath];
    
    cell4.backgroundColor =BassColor(255,255,255);
    ListModel * model =self.listArr[indexPath.row];
    
    [cell4 chuanZhiListModel:model modelArr:self.lableArr[indexPath.row]];
    cell4.numLable.text =[NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell4;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth, height(85));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1, 0, 1, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self showDGActView];
    ListModel * model =self.listArr[indexPath.row];
    [HttpTool get:API_POST_taskInfo dic:@{@"id":model.listID} success:^(id  _Nonnull responce) {
        [self stopDGActView];
        TaskInfoModel *model = [TaskInfoModel mj_objectWithKeyValues:responce[@"data"]];
        if ([responce[@"code"] intValue] == 200 && model != nil) {
            if ([responce[@"data"][@"cateid"] intValue]==1) {
                RegisDetailVC * VC = [[RegisDetailVC alloc] initModel:model];
                VC.hidesBottomBarWhenPushed = YES;
                VC.homeIndex = 101;
                VC.dataDic = responce[@"data"];
                [self.navigationController pushViewController:VC animated:YES];
            }else {
                OrdinaryVC * VC = [[OrdinaryVC alloc] initModel:model];
                VC.hidesBottomBarWhenPushed = YES;
                VC.dataDic = responce[@"data"];
                VC.homeIndex = 101;
                [self.navigationController pushViewController:VC animated:YES];
            }
        }else {
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self stopDGActView];
        [self showToastInView:self.view message: @"网络错误" duration:0.8];
    }];
}
-(void)chuanZhiType:(int)indexType{
    switch (indexType) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            //  self.cateid = @"";
            self.type=@"2";
            self.labelStr=@"";
            self.price=@"";
            self.keyword = @"";
        }
            break;
        case 2:
        {
            //  self.cateid = @"";
            self.type=@"3";
            self.labelStr=@"";
            self.price=@"";
            self.keyword = @"";
        }
            break;
        case 3:
        {
            // self.cateid = @"";
            self.type=@"4";
            self.labelStr=@"";
            self.keyword = @"";
            
        }
            break;
        case 4:
        {
            // self.cateid = @"";
            self.type=@"5";
            self.labelStr=@"";
            self.price=@"";
            self.keyword = @"";
        }
            break;
        default:
            break;
    }
    [self.taskCollection.mj_header beginRefreshing];
}
-(void)chuanZhiBOOL:(BOOL)isBool{
    if (isBool==YES) {
        [self showToastInView:self.view message:@"价格有高到底" duration:0.8];
        self.price=@"2";
    }else{
        [self showToastInView:self.view message:@"价格有底到高" duration:0.8];
        self.price=@"1";
    }
}
-(void)chuanZhiLeiXing:(NSString *)cateid{
    //self.cateid = cateid;
    self.type=@"1";
    self.labelStr=cateid;
    self.price=@"";
    self.keyword = @"";
    [self.taskCollection.mj_header beginRefreshing];
}
-(void)chuanZhiTaskTanID:(NSString *)ID{
    self.labelStr=ID;
    self.keyword = @"";
    [self.taskCollection.mj_header beginRefreshing];
}
-(void)chuanZhiTaskTanName:(NSString *)name{
    self.keyword=name;
    self.labelStr=@"";
    [self.taskCollection.mj_header beginRefreshing];
}


@end
