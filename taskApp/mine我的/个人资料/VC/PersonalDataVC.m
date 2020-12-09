//
//  PersonalDataVC.m
//  taskApp
//
//  Created by per on 2019/11/13.
//  Copyright © 2019 per. All rights reserved.
//

#import "PersonalDataVC.h"
#import "PersinDataCell1.h"
#import "PersinDataCell0.h"
#import "RealNameVC.h"
#import "UIView+Toast.h"
#import "MineModel.h"

@interface PersonalDataVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,PersinDataCell0Delegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic, strong) MineModel *userModel;
@property(nonatomic,strong)UIImageView * touImg;
@property(nonatomic,strong)UIImage *img;
@property(nonatomic,copy)NSString * nickStr;
@property(nonatomic,copy)NSString * sex;
@end

@implementation PersonalDataVC
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setNavTitle:@"个人资料"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self.view addSubview:self.tableView];
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"保存修改" forState:0];
    [sureBtn setTitleColor:UIColor.whiteColor forState:0];
    sureBtn.titleLabel.font =VFont;
    sureBtn.backgroundColor = BassColor(17, 151, 255);
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(height(20));
        make.height.mas_equalTo(height(45));
        make.width.mas_equalTo(width(345));
        
    }];
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self load_API_POST_userUpdate];
    }];
    // Do any additional setup after loading the view.
    [self load_userIndex];
}
-(void)chuanZhiNick:(NSString *)nickStr andSex:(NSString *)sexStr{
    self.nickStr = nickStr;
    self.sex=sexStr;
}
-(void)load_API_POST_userUpdate{
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
    
    
    [manager POST:API_POST_userUpdate parameters:@{@"nickname":self.nickStr,@"sex":self.sex} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
            NSString *name = @"headimg";
            NSData *imageData = UIImageJPEGRepresentation(self.img, 0.01);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSLog(@"222222%@",str);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@.jpg",str] mimeType:@"image/jpg/file"];
     
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([resultDic[@"code"] intValue]==200) {
            
            [self showToastInView:self.view message:resultDic[@"message"] duration:0.8];
        }else{
            [self showToastInView:self.view message:resultDic[@"message"] duration:0.8];
            NSLog(@"11111%@",resultDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self showToastInView:self.view message:@"网络错误" duration:0.8];
    }];
}

-(void)load_userIndex{
    [self showDGActView];
    [HttpTool get:API_POST_userIndex dic:@{} success:^(id  _Nonnull responce) {
        [self stopDGActView];
        if ([responce[@"code"] intValue]==200) {
            self.dataDic = responce[@"data"];
            self.userModel = [MineModel mj_objectWithKeyValues:responce[@"data"]];
            if (self.userModel.headimg) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.userModel.headimg]];
                self.img=[UIImage imageWithData:data];
            }else {
                self.img = nil;
            }
            [self.tableView reloadData];
        }else {
            [self.view hideAllToasts];
            [self.view makeToast: responce[@"message"] duration:0.8 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:true];
            }];
        }
    } faile:^(NSError * _Nonnull erroe) {
        [self stopDGActView];
        [self.view hideAllToasts];
        [self.view makeToast: @"连接超时，请检查您的网络！" duration:0.8 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
            [self.navigationController popViewControllerAnimated:true];
        }];
    }];
}

-(UITableView*)tableView {
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height(435)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor =BassColor(241, 241, 241);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.scrollEnabled=NO;
        _tableView.dataSource =self;
        [_tableView registerClass:[PersinDataCell0 class] forCellReuseIdentifier:@"PersinDataCell0"];
        [_tableView registerClass:[PersinDataCell1 class] forCellReuseIdentifier:@"PersinDataCell1"];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 2;
    }else{
        return 1;
    }
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        PersinDataCell0 * cell0 =[tableView dequeueReusableCellWithIdentifier:@"PersinDataCell0"];
        cell0.backgroundColor =BassColor(255, 255, 255);
        cell0.delegate =self;
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        cell0.dataDic = self.dataDic;
        return cell0;
    }else{
        PersinDataCell1 * cell1 =[tableView dequeueReusableCellWithIdentifier:@"PersinDataCell1"];
        cell1.backgroundColor =BassColor(255, 255, 255);
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section==1) {
            if (indexPath.row == 0) {
                cell1.leftLable.text = @"账号等级";
                if ([self.dataDic[@"level"] intValue] == 0) {
                   cell1.rightLable.text = @"";
                }else if (self.dataDic[@"levelname"] != nil) {
                   cell1.rightLable.text = [NSString stringWithFormat:@"%@",self.dataDic[@"levelname"]];
                }
            }else {
                cell1.leftLable.text = @"我的ID";
                if (self.dataDic[@"id"] != nil) {
                    cell1.rightLable.text = [NSString stringWithFormat:@"%@",self.dataDic[@"id"]];
                }
            }
        }else{
            cell1.leftLable.text = @"实名认证";
            if ([self.dataDic[@"authentic"] intValue]==1) {
                cell1.rightLable.text = @"已认证";
            }else{
            cell1.rightLable.text = @"未认证";
            }
        }
        return cell1;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
      return height(96);
    }else{
      return height(50);
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return height(80);
    }
    return height(15);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heardView =[[UIView alloc]init];
    if (section==0) {
        heardView.frame=CGRectMake(0, 0, kScreenWidth, height(80));
        UILabel *leftLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", height(14)) textAlignmen:NSTextAlignmentLeft text:@"头像"];
        [heardView addSubview:leftLable];
        [leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(heardView).offset(width(15));
            make.top.mas_equalTo(heardView.mas_top).offset(height(15));
            make.width.mas_equalTo(width(120));
            make.height.mas_equalTo(height(65));
        }];
        UIImageView *rightImg =[[UIImageView alloc]init];
        rightImg.image =[UIImage imageNamed:@"jinru"];
        [heardView addSubview:rightImg];
        [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(heardView.mas_right).offset(-width(15));
            make.centerY.mas_equalTo(leftLable.mas_centerY);
            make.width.mas_equalTo(width(7));
            make.height.mas_equalTo(height(13));
        }];
        self.touImg =[[UIImageView alloc]init];
        [heardView addSubview:self.touImg];
        [self.touImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightImg.mas_left).offset(-width(15));
            make.centerY.mas_equalTo(leftLable.mas_centerY);
            make.width.mas_equalTo(height(55));
            make.height.mas_equalTo(height(55));
        }];
        self.touImg.layer.masksToBounds =YES;
        self.touImg.layer.cornerRadius = height(27.5);
        heardView.backgroundColor = BassColor(241, 241, 241);
        [self.touImg sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"headimg"]] placeholderImage:nil];
        heardView.backgroundColor = BassColor(255, 255, 255);
        UIButton * touBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        touBtn.backgroundColor = UIColor.clearColor;
        [heardView addSubview:touBtn];
        [touBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightImg.mas_left).offset(-width(15));
            make.centerY.mas_equalTo(leftLable.mas_centerY);
            make.width.mas_equalTo(height(55));
            make.height.mas_equalTo(height(55));
        }];
        [[touBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self scanBigImageClick];
        }];
    }else{
        heardView.frame=CGRectMake(0, 0, kScreenWidth, height(15));
        heardView.backgroundColor = BassColor(241, 241, 241);
    }
    
    return heardView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    footView.backgroundColor = BassColor(241, 241, 241);
    return footView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        if ([self.dataDic[@"authentic"] intValue]==1) {
           // cell1.rightLable.text = @"已认证";
        }else{
            RealNameVC * VC =[[RealNameVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}
-(void)scanBigImageClick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"拍照", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相机");
        [self selectedCamera];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"从相册选择", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相册");
        [self selectedLocal];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
////本地图片
- (void)selectedLocal
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

//相机
- (void)selectedCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{}];
    }else{
        NSLog(@"该设备无摄像头");
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //    [imgBtn setImage: forState:0];
    //self.addImg.image =info[UIImagePickerControllerEditedImage];
   
        self.img =info[UIImagePickerControllerEditedImage];
        self.touImg.image =info[UIImagePickerControllerEditedImage];
//        NSData*_data =UIImageJPEGRepresentation(self.zizhiImg,1.0f);
//        self.zizhiStr = [_data base64Encoding];

    
    [picker dismissViewControllerAnimated:YES completion:nil];
    // [self loadUploadHeaderImageData];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
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
