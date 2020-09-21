//
//  OrdinaryVC.m
//  taskApp
//
//  Created by per on 2019/11/12.
//  Copyright © 2019 per. All rights reserved.
//
//视频和注册
#import "OrdinaryVC.h"
#import "TaskDetailCell0.h"
#import "TaskDetailCell1.h"
#import "TaskDetailCollCell.h"
#import "UploadScreenshotsVC.h"
#import "VideoViewController.h"
#import "TaskDetailTableViewCell.h"

@interface OrdinaryVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UICollectionView *collection;

@property(nonatomic, strong)NSMutableArray<NSDictionary *> *showInfos;

@end

@implementation OrdinaryVC

-(instancetype)initModel:(TaskInfoModel *) model {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _taskModel = model;
    }
    return self;
}

- (void)clickBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =UIColor.whiteColor;
    [self setNavTitle:@"领取任务"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self.view addSubview:self.tableView];
    UIButton*sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self.dataDic[@"cateid"] intValue]==3) {
        if ([self.dataDic[@"draw"] intValue]==5) {
            [sureBtn setTitle:@"观看视频" forState:0];
            
        }else{
            [sureBtn setTitle:@"已完成" forState:0];
            
        }
    }else{
        if ([self.dataDic[@"draw"] intValue]==5) {
            [sureBtn setTitle:@"领取任务" forState:0];
        }else if ([self.dataDic[@"draw"] intValue]==1) {
            [sureBtn setTitle:@"请上传此任务完成截图" forState:0];
            
        }else if ([self.dataDic[@"draw"] intValue]==2) {
            [sureBtn setTitle:@"正在审核" forState:0];
        }else if ([self.dataDic[@"draw"] intValue]==4) {
            [sureBtn setTitle:@"已完成" forState:0];
        }else{
            [sureBtn setTitle:@"重新上传截图" forState:0];
        }
    }
    sureBtn.backgroundColor =BassColor(17, 151, 255);
    [sureBtn setTitleColor:BassColor(255, 255,255) forState:0];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(height(40));
        make.width.mas_equalTo(width(345));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-height(80));
    }];
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([self.dataDic[@"cateid"] intValue]==3) {
            if ([self.dataDic[@"draw"] intValue]==5) {
                [HttpTool get:API_POST_videoTask dic:@{@"id":self.dataDic[@"id"]} success:^(id  _Nonnull responce) {
                    if ([responce[@"code"] intValue]==200) {
                        [self showToastInView:self.view message:responce[@"message"] duration:0.8];
                        VideoViewController*videoVC =[[VideoViewController alloc]init];
                        videoVC.dataDic =self.dataDic;
                        [self.navigationController pushViewController:videoVC animated:YES];
                    }else{
                        [self showToastInView:self.view message:responce[@"message"] duration:0.8];
                    }
                } faile:^(NSError * _Nonnull erroe) {
                    [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
                }];
                
            }else{
                [self showToastInView:self.view message:@"已完成" duration:0.8];
                
            }
        }else{
            if ([self.dataDic[@"draw"] intValue]==5) {
                [sureBtn setTitle:@"领取任务" forState:0];
                [self load_lingQu_drawTask];
            }else if ([self.dataDic[@"draw"] intValue] == 1 && self.taskModel != nil) {
                UploadScreenshotsVC * VC = [[UploadScreenshotsVC alloc] initModel:self.taskModel];
                VC.hidesBottomBarWhenPushed=YES;
                VC.nameStr = self.dataDic[@"title"];
                VC.orderid = self.dataDic[@"id"];
                VC.indx=self.homeIndex;;
                [self.navigationController pushViewController:VC animated:YES];
            }else if ([self.dataDic[@"draw"] intValue]==2) {
                [self showToastInView:self.view message:@"正在审核" duration:0.8];
                return ;
            }else if ([self.dataDic[@"draw"] intValue]==4) {
                [self showToastInView:self.view message:@"已完成" duration:0.8];
                return ;
            }else{
//                UploadScreenshotsVC * VC =[[UploadScreenshotsVC alloc]init];
//                VC.hidesBottomBarWhenPushed=YES;
//                VC.nameStr = self.dataDic[@"title"];
//                VC.orderid = self.dataDic[@"id"];
//                VC.indx=self.homeIndex;;
//                [self.navigationController pushViewController:VC animated:YES];
            }
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)setDataDic:(NSDictionary *)dataDic {
    if (dataDic == nil) {
        return;
    }
    _dataDic = dataDic;
    if (!_showInfos) {
        _showInfos = [NSMutableArray array];
    }else {
        [_showInfos removeAllObjects];
    }
    [_showInfos addObject: @{@"截止时间：": [[NSAttributedString alloc] initWithString:_dataDic[@"cuttime"] attributes:@{}]}];
    if (_dataDic[@"download"] != nil) {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:_dataDic[@"download"] attributes:@{NSForegroundColorAttributeName : BassColor(17, 151, 255)}];
        [_showInfos addObject:@{@"下载链接：": attrStr}];
    }
    if (_dataDic[@"desc"] != nil) {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:[_dataDic[@"desc"] componentsJoinedByString:@";\n"] attributes:@{}];
        [_showInfos addObject:@{@"任务要求：": attrStr}];
    }
    if (_dataDic[@"filetype"] != nil && [_dataDic[@"filetype"] intValue] != 0) {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"显示任务详情" attributes:@{NSForegroundColorAttributeName : BassColor(17, 151, 255)}];
        
        if ([_dataDic[@"filetype"] intValue] == 1) {
            NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
            para.lineSpacing = 5;
            para.paragraphSpacing = 10;
            
            NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                                       NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding),
                                       NSParagraphStyleAttributeName : para,
                                       NSFontAttributeName : VPFont(@"PingFang-SC-Medium", height(13))};
            
            attrStr = [[NSAttributedString alloc] initWithData:[_dataDic[@"infodetail"] dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil error:nil];
            
        }
        [_showInfos addObject:@{@"任务详情：": attrStr}];
    }
}

//领取任务
-(void)load_lingQu_drawTask{
    [HttpTool get:API_POST_drawTask dic:@{@"id":[NSString stringWithFormat:@"%@",self.dataDic[@"id"]]} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerClass:[TaskDetailCell0 class] forCellReuseIdentifier:@"TaskDetailCell0"];
        [_tableView registerClass:[TaskDetailCell1 class] forCellReuseIdentifier:@"TaskDetailCell1"];
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return _showInfos.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TaskDetailCell0* cell0 =[tableView dequeueReusableCellWithIdentifier:@"TaskDetailCell0"];
        cell0.backgroundColor=BassColor(255, 255, 255);
        cell0.datadic = self.dataDic;
        return cell0;
    }else if (indexPath.section == 1 && indexPath.row < _showInfos.count) {
        TaskDetailTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"TaskDetailTableViewCell"];
        if (cell == nil) {
            cell = [[TaskDetailTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"TaskDetailTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [[cell.goBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                NSURL *tempURL = [NSURL URLWithString:self.dataDic[@"download"]];
                if (tempURL != nil && [[UIApplication sharedApplication] canOpenURL:tempURL]) {
                    [[UIApplication sharedApplication] openURL:tempURL];
                }else {
                    [self showToastInView:self.view message: @"无法打开该链接" duration: 0.8];
                }
            }];
            [[cell.fuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = self.dataDic[@"download"];
                [self showToastInView:self.view message:@"复制成功" duration:0.8];
            }];
        }
        cell.contentVlaue = _showInfos[indexPath.row];
        return cell;
    }
    return [[UITableViewCell alloc] init];
    //    else {
    //        TaskDetailCell1 * cell1 =[tableView dequeueReusableCellWithIdentifier:@"TaskDetailCell1"];
    //        cell1.selectionStyle =  UITableViewCellSelectionStyleNone;
    //        cell1.datadic =self.dataDic;
    //        return cell1;
    //    }
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0) {
//        return height(330);
//    }
//    return 45;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return height(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0.0001;
    }
    if ([self.dataDic[@"cover"] count]<=3) {
        return (height(60)+kScreenWidth/3);;
    }else if ([self.dataDic[@"cover"] count]>3&&[self.dataDic[@"cover"] count]<=6){
        return (height(60)+2*(kScreenWidth/3));
    }else{
        return (height(60)+3*(kScreenWidth/3));
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heardView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height(10))];
    heardView.backgroundColor = BassColor(241, 241, 241);
    return heardView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]init];
    if (section==0) {
        footView.frame = CGRectMake(0, 0, kScreenWidth, 0.0001);
    }else{
        footView.frame = CGRectMake(0, 0, kScreenWidth, 100);
        UILabel * nameLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Medium", height(13)) textAlignmen:NSTextAlignmentLeft text:@"   任务示列图："];
        [footView addSubview:nameLable];
        nameLable.backgroundColor= UIColor.whiteColor;
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(footView);
            make.top.mas_equalTo(footView.mas_top).offset(height(10));
            make.height.mas_equalTo(height(50));
        }];
        [footView addSubview:self.collection];
    }
    footView.backgroundColor = BassColor(241, 241, 241);
    
    return footView;
}

-(UICollectionView*)collection{
    if (!_collection) {
        UICollectionViewFlowLayout * flow =[[UICollectionViewFlowLayout alloc]init];
        CGFloat coverHeight;
        if ([self.dataDic[@"cover"] count]<=3) {
            coverHeight =+kScreenWidth/3;
        }else if ([self.dataDic[@"cover"] count]>3&&[self.dataDic[@"cover"] count]<=6){
            coverHeight = +2*(kScreenWidth/3);
        }else{
            coverHeight = 3*(kScreenWidth/3);
        }
        _collection =[[UICollectionView alloc]initWithFrame:CGRectMake(0, height(60), kScreenWidth, coverHeight) collectionViewLayout:flow];
        _collection.scrollEnabled=NO;
        _collection.delegate =self;
        _collection.dataSource=self;
        [_collection registerClass:[TaskDetailCollCell class] forCellWithReuseIdentifier:@"TaskDetailCollCell"];
        
        _collection.backgroundColor =UIColor.whiteColor;
    }
    return _collection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataDic[@"cover"] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskDetailCollCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TaskDetailCollCell" forIndexPath:indexPath];
    
    cell.backgroundColor =BassColor(255, 255, 255);
    [cell.img sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"cover"][indexPath.row]] placeholderImage:nil];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kScreenWidth/3-3,kScreenWidth/3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0001;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0001;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    
    //browser.sourceImagesContainerView = 原图的父控件;
    
    browser.imageCount = [self.dataDic[@"cover"] count];
    
    browser.currentImageIndex = indexPath.row;
    
    browser.delegate = self;
    
    [browser show]; // 展示图片浏览器
}

-(UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return nil;
}

// 返回高质量图片的url
-(NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    NSURL *url= [NSURL URLWithString:self.dataDic[@"cover"][index]];
    
    return url;
}

@end
