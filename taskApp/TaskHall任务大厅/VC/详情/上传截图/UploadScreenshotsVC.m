//
//  UploadScreenshotsVC.m
//  taskApp
//
//  Created by per on 2019/11/12.
//  Copyright © 2019 per. All rights reserved.
//

#import "UploadScreenshotsVC.h"
#import "TZImagePickerController.h"
#import "TZTestCell.h"
#import "SuccessViewController.h"
@interface UploadScreenshotsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collection;
@property (nonatomic, strong)NSMutableArray *selectedPhotos;
@property (nonatomic, strong)NSMutableArray *selectedAssets;
@property(nonatomic, strong)HGOrientationLabel * name;
@property(nonatomic, strong)UILabel * beiLable;

@property(nonatomic, strong)UITextField *trueNameField;
@property(nonatomic, strong)UITextField *mobileField;

@end

@implementation UploadScreenshotsVC

-(instancetype)initModel:(TaskBaseModel *) model {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _taskModel = model;
    }
    return self;
}

-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sureBtn{
    [self load_screenshot];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =UIColor.whiteColor;
    [self setNavTitle:@"上传图片"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self setRightButton:@"提交" imgStr:@"" selector:@selector(sureBtn)];
    // Do any additional setup after loading the view.CGRectGetMaxY(self.rightAddress.frame)
    UIView * line =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height(15))];
    line.backgroundColor = BassColor(241, 241,241);
    [self.view addSubview:line];
    self.name=[[HGOrientationLabel alloc]init];
    self.name.textColor = BassColor(0,0,0);
    self.name.backgroundColor = UIColor.whiteColor;
    self.name.font = VPFont(@"PingFang-SC-Medium", height(15));
    self.name.text = [NSString stringWithFormat:@"任务：%@,完成后请发送截图",self.nameStr];
    self.name.numberOfLines = 3;
    self.name.textAlignment = NSTextAlignmentLeft;
    [self.name textAlign:^(HGMaker *make) {
        make.addAlignType(textAlignType_left).addAlignType(textAlignType_top);
    }];
    [self.view addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height(85));
        make.top.mas_equalTo(line.mas_bottom).offset(height(10));
        make.left.right.mas_equalTo(self.view).inset(width(10.0));
    }];
    
    NSMutableAttributedString *nameStr = [[NSMutableAttributedString alloc] initWithString: @"姓名：" attributes:@{NSFontAttributeName : VPFont(@"PingFang-SC-Medium", height(13)),
                                                                                                                NSForegroundColorAttributeName: [UIColor blackColor]}];
//    if (_taskModel.realneed == 1) {
//        [nameStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"*" attributes:@{NSFontAttributeName : VPFont(@"PingFang-SC-Medium", height(13)),
//                                                                                                     NSForegroundColorAttributeName: [UIColor redColor]}] atIndex: 2];
//    }
    
    NSMutableAttributedString *phoneStr = [[NSMutableAttributedString alloc] initWithString: @"手机号：" attributes:@{NSFontAttributeName : VPFont(@"PingFang-SC-Medium", height(13)),
                                                                                                                 NSForegroundColorAttributeName: [UIColor blackColor]}];
//    if (_taskModel.phoneneed == 1) {
//        [phoneStr insertAttributedString:[[NSAttributedString alloc] initWithString:@"*" attributes:@{NSFontAttributeName : VPFont(@"PingFang-SC-Medium", height(13)),
//                                                                                                      NSForegroundColorAttributeName: [UIColor redColor]}] atIndex: 3];
//    }
    
    UIView *trueNameView = [[UIView alloc] init];
    [trueNameView setHidden: _taskModel.realneed != 1];
    [self.view addSubview: trueNameView];
    
    UIView *mobileView = [[UIView alloc] init];
    [mobileView setHidden: _taskModel.phoneneed != 1];
    [self.view addSubview: mobileView];
    
    UILabel *trueNameFlagLabel = [[UILabel alloc] init];
    trueNameFlagLabel.attributedText = nameStr;
    [trueNameFlagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [trueNameView addSubview:trueNameFlagLabel];
    [trueNameFlagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_equalTo(trueNameView);
        make.height.mas_lessThanOrEqualTo(trueNameView);
    }];
    
    UILabel *mobileFlagLabel = [[UILabel alloc] init];
    mobileFlagLabel.attributedText = phoneStr;
    [mobileFlagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [mobileView addSubview:mobileFlagLabel];
    [mobileFlagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_equalTo(mobileView);
        make.height.mas_lessThanOrEqualTo(mobileView);
    }];
    
    _trueNameField = [[UITextField alloc] init];
    _trueNameField.borderStyle = UITextBorderStyleLine;
    _trueNameField.placeholder = @"请输入真实姓名";
    _trueNameField.font = [UIFont systemFontOfSize:width(13.0)];
    [trueNameView addSubview:_trueNameField];
    [_trueNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(trueNameView);
        make.left.mas_equalTo(trueNameFlagLabel.mas_right);
    }];
    
    _mobileField = [[UITextField alloc] init];
    _mobileField.keyboardType = UIKeyboardTypePhonePad;
    _mobileField.borderStyle = UITextBorderStyleLine;
    _mobileField.placeholder = @"请输入手机号";
    _mobileField.font = [UIFont systemFontOfSize:width(13.0)];
    [mobileView addSubview:_mobileField];
    [_mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(mobileView);
        make.left.mas_equalTo(mobileFlagLabel.mas_right);
    }];
        
    UIView *topView = self.name;
    if (_taskModel.realneed == 1) {
        if (_taskModel.phoneneed == 1) {
            [trueNameView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.name);
                make.top.mas_equalTo(self.name.mas_bottom).offset(height(10));
                make.right.mas_equalTo(mobileView.mas_left).offset(width(-10.0));
            }];
            [mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.name);
                make.centerY.width.mas_equalTo(trueNameView);
            }];
        }else {
            [trueNameView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.name);
                make.top.mas_equalTo(self.name.mas_bottom).offset(height(10));
            }];
        }
        topView = trueNameView;
    }else if (_taskModel.phoneneed == 1) {
        [mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.name);
            make.top.mas_equalTo(self.name.mas_bottom).offset(height(10));
        }];
        topView = mobileView;
    }
    
    [self.view addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).inset(width(10.0));
        make.top.mas_equalTo(topView.mas_bottom).offset(height(10.0));
        make.height.mas_equalTo(height(100.0));
    }];
    
    self.beiLable=[HttpTool createLable:BassColor(161, 161, 161) font:VPFont(@"PingFangSC-Regular", height(11)) textAlignmen:NSTextAlignmentLeft text:@"注：单张图片上传限制2m，9张上传限制9m"];
    [self.view addSubview:self.beiLable];
    [self.beiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).inset(width(10.0));
        make.top.mas_equalTo(_collection.mas_bottom).offset(height(10.0));
        make.bottom.mas_lessThanOrEqualTo(self.view);
    }];
}

-(UICollectionView*)collection{
    if (!_collection) {
        UICollectionViewFlowLayout * flow =[[UICollectionViewFlowLayout alloc]init];
        _collection =[[UICollectionView alloc]initWithFrame:CGRectMake(width(15),height(220), kScreenWidth-width(30), height(100)) collectionViewLayout:flow];
        _collection.backgroundColor = UIColor.whiteColor;
        _collection.delegate =self;
        _collection.dataSource =self;
        [_collection registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    }
    return _collection;
}

#pragma mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_selectedPhotos.count >= 9) {
        return _selectedPhotos.count;
    }else{
        return _selectedPhotos.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    if (indexPath.item == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"add"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.item];
        cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.selectedAssets = _selectedAssets;
    //拿到主窗口的根控制器，用根控制器进行modal需要的modal的控制器
    //    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.collection numberOfItemsInSection:0] <= _selectedPhotos.count) {
        [_selectedPhotos removeObjectAtIndex:sender.tag];
        [_selectedAssets removeObjectAtIndex:sender.tag];
        [self.collection reloadData];
        return;
    }
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    [_collection performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_collection deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self->_collection reloadData];
    }];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [_collection reloadData];
    if (_selectedAssets.count<=3) {
       self.collection.frame = CGRectMake(width(15),height(100), kScreenWidth-width(30),height(100));
        self.beiLable.frame = CGRectMake(width(15),height(220), kScreenWidth-width(30), height(20));
    }else if (_selectedAssets.count>3&&_selectedAssets.count<=6){
       self.collection.frame = CGRectMake(width(15),height(100), kScreenWidth-width(30),height(200));
        self.beiLable.frame = CGRectMake(width(15),height(320), kScreenWidth-width(30), height(20));
    }else{
     self.collection.frame = CGRectMake(width(15),height(100), kScreenWidth-width(30), height(300));
        self.beiLable.frame = CGRectMake(width(15),height(420), kScreenWidth-width(30), height(20));
    }
    
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@",phAsset.location);
    }
}

- (void)load_screenshot {
    NSString *tempName = _trueNameField.text;
    if (_taskModel.realneed == 1 && (tempName != nil && tempName.length <= 0)) {
        [self showToastInView:self.view message:@"请输入真实姓名" duration:0.8];
        return;
    }
    
    NSString *tempMobile = self.mobileField.text;
    if (_taskModel.phoneneed == 1 && (tempMobile != nil && tempMobile.length <= 0)) {
        [self showToastInView:self.view message:@"请输入手机号" duration:0.8];
        return;
    }
    NSString *checkPhone = [StringUtils checkPhone:tempMobile];
    if (nil != checkPhone) {
        [self showToastInView:self.view message:checkPhone duration:0.8];
        return;
    }
    
    if (self.selectedPhotos.count==0) {
        [self showToastInView:self.view message:@"请上传图片" duration:0.8];
        return;
    }
    
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    manager.responseSerializer   = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    NSString * heaedStr = TOKEN;
    if (heaedStr.length>0) {
        NSDictionary *headerFieldValueDictionary = @{@"token":TOKEN};
        if (headerFieldValueDictionary != nil) {
            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
                NSString *value = headerFieldValueDictionary[httpHeaderField];
                [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
            }
        }
    }
    manager.requestSerializer = requestSerializer;
    
    [manager POST:API_POST_screenshot parameters:@{@"id" : self.orderid, @"truename" : tempName, @"phone" : tempMobile} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<self.selectedPhotos.count; i++) {
            NSString *name = @"screenshot[]";
            NSData *imageData = UIImageJPEGRepresentation(self.selectedPhotos[i], 0.01);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSLog(@"222222%@",str);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@.jpg",str] mimeType:@"image/jpg/file"];
            
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([resultDic[@"code"] intValue]==200) {
            
            [self showToastInView:self.view message:resultDic[@"msg"] duration:0.8];
            SuccessViewController *VC =[[SuccessViewController alloc]init];
            VC.imgName = @"success";
            VC.status = @"审核中";
            VC.beiZhu = @"审核中，后台正在审核请耐心等待，感谢配合～";
            VC.btnStr = @"确定";
            if (self.indx==100) {
                VC.indexType=4;
            }else if (self.indx==101) {
              VC.indexType=3;
            }else {
            VC.indexType=5;
            }
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            [self showToastInView:self.view message:resultDic[@"msg"] duration:0.8];
            NSLog(@"11111%@",resultDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self showToastInView:self.view message:@"网络错误" duration:0.8];
    }];
}

@end
