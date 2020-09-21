//
//  CustomerServiceVC.m
//  taskApp
//
//  Created by per on 2019/11/18.
//  Copyright © 2019 per. All rights reserved.
//

#import "CustomerServiceVC.h"
#import "FeedBackTextView.h"
@interface CustomerServiceVC ()<UITextViewDelegate>
@property(nonatomic,strong)UITextField * nameField;
@property(nonatomic,strong)UITextField * phoneField;
@property(nonatomic,strong)UITextField * emsField;
@property(nonatomic,strong)UITextField * addressField;
@property(nonatomic,strong)FeedBackTextView * contentTextView;
@end

@implementation CustomerServiceVC

-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle:@"联系客服"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI
{
    UILabel * nameLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", 15) textAlignmen:NSTextAlignmentLeft text:@"姓  名:"];
    [self.view addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(10));
        make.height.mas_equalTo(height(20));
        make.top.mas_equalTo(self.view).offset(height(10));
    }];
    self.nameField =[HttpTool createField:@"请输入您的姓名" font:VPFont(@"PingFangSC-Regular", 15) color:BassColor(51, 51, 51) ishidden:NO];
    [self.view addSubview:self.nameField];
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
        make.height.mas_equalTo(height(25));
        make.top.mas_equalTo(nameLable.mas_bottom).offset(height(0));
    }];
    UIView * line =[[UIView alloc]init];
    line.backgroundColor = BassColor(215, 215, 215);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
        make.top.mas_equalTo(self.nameField.mas_bottom).offset(height(10));
        make.height.mas_equalTo(1);
    }];
    
    UILabel * phoneLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", 15) textAlignmen:NSTextAlignmentLeft text:@"手机号:"];
    [self.view addSubview:phoneLable];
    [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(10));
        make.height.mas_equalTo(height(20));
        make.top.mas_equalTo(line.mas_bottom).offset(height(10));
    }];
    self.phoneField =[HttpTool createField:@"请输入您的手机号(必填)" font:VPFont(@"PingFangSC-Regular", 15) color:BassColor(51, 51, 51) ishidden:NO];
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
        make.height.mas_equalTo(height(25));
        make.top.mas_equalTo(phoneLable.mas_bottom).offset(height(0));
    }];
    UIView * line1 =[[UIView alloc]init];
    line1.backgroundColor = BassColor(215, 215, 215);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(height(10));
        make.height.mas_equalTo(1);
    }];
    UILabel * emsLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", 15) textAlignmen:NSTextAlignmentLeft text:@"邮  箱:"];
    [self.view addSubview:emsLable];
    [emsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(10));
        make.height.mas_equalTo(height(20));
        make.top.mas_equalTo(line1.mas_bottom).offset(height(10));
    }];
    self.emsField =[HttpTool createField:@"请输入您的联系邮箱" font:VPFont(@"PingFangSC-Regular", 15) color:BassColor(51, 51, 51) ishidden:NO];
    [self.view addSubview:self.emsField];
    [self.emsField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
        make.height.mas_equalTo(height(25));
        make.top.mas_equalTo(emsLable.mas_bottom).offset(height(0));
    }];
    UIView * line2 =[[UIView alloc]init];
    line2.backgroundColor = BassColor(215, 215, 215);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
        make.top.mas_equalTo(self.emsField.mas_bottom).offset(height(10));
        make.height.mas_equalTo(1);
    }];
    UILabel * addressLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", 15) textAlignmen:NSTextAlignmentLeft text:@"地  址:"];
    [self.view addSubview:addressLable];
    [addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(10));
        make.height.mas_equalTo(height(20));
        make.top.mas_equalTo(line2.mas_bottom).offset(height(10));
    }];
    self.addressField =[HttpTool createField:@"请输入您的地址" font:VPFont(@"PingFangSC-Regular", 15) color:BassColor(51, 51, 51) ishidden:NO];
    [self.view addSubview:self.addressField];
    [self.addressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
        make.height.mas_equalTo(height(25));
        make.top.mas_equalTo(addressLable.mas_bottom).offset(height(0));
    }];
    UIView * line3 =[[UIView alloc]init];
    line3.backgroundColor = BassColor(215, 215, 215);
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(15));
        make.top.mas_equalTo(self.addressField.mas_bottom).offset(height(10));
        make.height.mas_equalTo(1);
    }];
    UILabel * comentLable =[HttpTool createLable:BassColor(51, 51, 51) font:VPFont(@"PingFangSC-Regular", 15) textAlignmen:NSTextAlignmentLeft text:@"反馈内容:"];
    [self.view addSubview:comentLable];
    [comentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(10));
        make.height.mas_equalTo(height(30));
        make.top.mas_equalTo(line3.mas_bottom).offset(height(10));
    }];
    
    self.contentTextView =[[FeedBackTextView alloc]init];
    self.contentTextView.textColor = BassColor(51,51,51);
    self.contentTextView.font = VPFont(@"PingFang-SC-Medium", 15);
    self.contentTextView.delegate = self;
    self.contentTextView.placeholder = @"请输入您的反馈内容,最多输入300个字符串(必填)";
    self.contentTextView.textAlignment = NSTextAlignmentLeft;
    self.contentTextView.backgroundColor = BassColor(241, 241, 241);
    [self.view addSubview:self.contentTextView];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height(150));
        make.top.mas_equalTo(comentLable.mas_bottom).offset(height(15));
        make.left.mas_equalTo(self.view).offset(width(15));
        make.right.mas_equalTo(self.view.mas_right).offset(-width(10));
    }];
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"提 交" forState:0];
    sureBtn.backgroundColor = BassColor(17, 151, 255);
    [sureBtn setTitleColor:BassColor(255, 255, 255) forState:0];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(height(45));
        make.width.mas_equalTo(width(345));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-height(60));
    }];
    sureBtn.layer.masksToBounds =YES;
    sureBtn.layer.cornerRadius = height(22.5);
    [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.nameField.text.length==0) {
            self.nameField.text=@"";
        }
        if (self.emsField.text.length==0) {
            self.emsField.text=@"";
        }
        if (self.addressField.text.length==0) {
            self.addressField.text=@"";
        }
        if (self.phoneField.text.length==0) {
            [self showToastInView:self.view message:@"请输入手机号" duration:0.8];
            return ;
        }
        NSString *checkPhone = [StringUtils checkPhone:self.phoneField.text];
        if (nil != checkPhone) {
            [self showToastInView:self.view message:checkPhone duration:0.8];
            return;
        }
        if (self.contentTextView.text.length==0) {
            [self showToastInView:self.view message:@"请输入反馈内容" duration:0.8];
            return ;
        }
        [self load_feedback];
    }];
}
-(void)load_feedback{
    [HttpTool post:API_POST_service dic:@{@"username":self.nameField.text,@"phone":self.phoneField.text,@"email":self.emsField.text,@"address":self.addressField.text,@"content":self.contentTextView.text} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
            self.nameField.text = @"";
            self.phoneField.text = @"";
            self.emsField.text = @"";
            self.addressField.text = @"";
            self.contentTextView.text = @"";
        }else{
            [self showToastInView:self.view message:responce[@"message"] duration:0.8];
        }
        
    } faile:^(NSError * _Nonnull erroe) {
        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
    }];
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>300) {
        [self showToastInView:self.view message:@"最多输入300个字符串" duration:0.8];
        self.contentTextView.text= [textView.text substringToIndex:300];
        return;
    }
}
@end
