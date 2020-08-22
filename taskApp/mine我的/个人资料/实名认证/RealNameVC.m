//
//  RealNameVC.m
//  taskApp
//
//  Created by per on 2019/11/13.
//  Copyright © 2019 per. All rights reserved.
//

#import "RealNameVC.h"
#import "SuccessViewController.h"
@interface RealNameVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITextField * nameField;
@property(nonatomic,strong)UITextField * numField;
@property(nonatomic,strong)UIButton* zBtn;
@property(nonatomic,strong)UIButton* fBtn;
@property(nonatomic,strong)UIImage * zImg;
@property(nonatomic,strong)UIImage * fImg;
@property(nonatomic,assign)int seleIndex;
@end


@implementation RealNameVC
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.seleIndex=0;
    // Do any additional setup after loading the view.
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setNavTitle:@"实名认证"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    
    self.nameField =[HttpTool createField:@"请输入您的姓名" font:VFont color:BassColor(51, 51, 51) name:@"   姓   名" ishidden:NO foalt:width(120)];
   self.nameField.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.nameField];
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(height(10));
        make.height.mas_equalTo(height(50));
    }];
    self.numField =[HttpTool createField:@"输入您的证件号码" font:VFont color:BassColor(51, 51, 51) name:@"   证件号码" ishidden:NO foalt:width(120)];
    self.numField.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.numField];
    [self.numField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.nameField.mas_bottom).offset(height(10));
        make.height.mas_equalTo(height(50));
    }];
    UILabel * lab =[HttpTool createLable:BassColor(51, 51, 51) font:VFont textAlignmen:NSTextAlignmentLeft text:@"   证件照片"];
    lab.font =[UIFont systemFontOfSize:20];
    lab.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.numField.mas_bottom).offset(height(0));
        make.height.mas_equalTo(height(50));
    }];
    UIView * backView =[[UIView alloc]init];
    backView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lab.mas_bottom).offset(height(0));
        make.height.mas_equalTo(height(140));
    }];
    self.zBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.zBtn setImage:[UIImage imageNamed:@"zhengmian"] forState:0];
    [backView addSubview:self.zBtn];
    [self.zBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(backView.mas_centerX).offset(-width(15));
        make.top.mas_equalTo(backView.mas_top);
        make.width.mas_equalTo(width(158));
        make.height.mas_equalTo(height(99));
    }];
    self.fBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.fBtn setImage:[UIImage imageNamed:@"fanmian"] forState:0];
    [backView addSubview:self.fBtn];
    [self.fBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_centerX).offset(width(15));
        make.top.mas_equalTo(backView.mas_top);
        make.width.mas_equalTo(width(158));
        make.height.mas_equalTo(height(99));
    }];
    [[_zBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.seleIndex = 1;
        [self scanBigImageClick];
    }];
    [[_fBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.seleIndex = 2;
        [self scanBigImageClick];
    }];
    
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"提 交" forState:0];
    [sureBtn setTitleColor:UIColor.whiteColor forState:0];
    sureBtn.titleLabel.font =VFont;
    sureBtn.backgroundColor = BassColor(17, 151, 255);
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(backView.mas_bottom).offset(height(40));
        make.height.mas_equalTo(height(45));
        make.width.mas_equalTo(width(345));
        
    }];
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self load_authentic];
    }];
}
-(void)load_authentic{
    if (self.nameField.text.length==0) {
        [self showToastInView:self.view message:@"请输入姓名" duration:0.8];
        return;
    }
    if (self.numField.text.length==0) {
        [self showToastInView:self.view message:@"请输入身份证号" duration:0.8];
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
    NSArray  * imgArr =[[NSArray alloc]initWithObjects:self.zImg,self.fImg, nil];
    NSArray * titleArr =[[NSArray alloc]initWithObjects:@"cardimg",@"cardimgs", nil];
    
    [manager POST:API_POST_authentic parameters:@{@"username":self.nameField.text,@"card":self.numField.text} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<imgArr.count; i++) {
            NSString *name = titleArr[i];
            NSData *imageData = UIImageJPEGRepresentation(imgArr[i], 0.01);
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
            VC.status = @"认证成功";
            VC.beiZhu = @"认证成功，可以操作认证成功之后的功能";
            VC.btnStr = @"确定";
            VC.indexType=2;
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            [self showToastInView:self.view message:resultDic[@"msg"] duration:0.8];
            SuccessViewController *VC =[[SuccessViewController alloc]init];
            VC.imgName = @"shibai";
            VC.status = @"认证失败";
            VC.beiZhu = @"认证失败，请检查自己的网络以及从新认证，感谢配合～";
            VC.btnStr = @"确定";
            VC.indexType=2;
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self showToastInView:self.view message:@"网络错误" duration:0.8];
    }];
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
    if (self.seleIndex==1) {
        self.zImg =info[UIImagePickerControllerEditedImage];
        [self.zBtn setImage:info[UIImagePickerControllerEditedImage] forState:0];
    }
    if (self.seleIndex==2) {
        self.fImg =info[UIImagePickerControllerEditedImage];
        [self.fBtn setImage:info[UIImagePickerControllerEditedImage] forState:0];
    }
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
