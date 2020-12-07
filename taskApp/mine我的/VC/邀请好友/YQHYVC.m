///Users/mac1/Desktop/mine/taskApp/taskApp/main.m
//  YQHYVC.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "YQHYVC.h"
#import <UMCommon/UMCommon.h>
#import <UShareUI/UShareUI.h>
@interface YQHYVC ()
@property(nonatomic,strong)UILabel * numLable;
@property(nonatomic,strong)UIImageView * maImg;
@end

@implementation YQHYVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle:@"邀请好友"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    // Do any additional setup after loading the view.
    UIImageView * bachImg =[[UIImageView alloc]init];
    bachImg.image=[UIImage imageNamed:@"yaoqing"];
    bachImg.userInteractionEnabled = YES;
    [self.view addSubview:bachImg];
    [bachImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.bottom.mas_equalTo(self.view);
    }];
    UIButton * leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.titleLabel.font = VFont;
    [leftBtn setTitle:@"保存海报" forState:0];
    [leftBtn addTarget:self action:@selector(dianjiClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitleColor:BassColor(51, 51, 51) forState:0];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"btnBack"] forState:0];
    [bachImg addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bachImg.mas_bottom).offset(-height(60));
        make.centerX.mas_equalTo(bachImg.mas_centerX).offset(-width(80));
        make.height.mas_equalTo(height(39));
        make.width.mas_equalTo(width(143));
    }];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"取消保存图片");
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"确认保存图片");
            
            // 保存图片到相册
                        UIImage * imageBao = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.share]]]; UIImageWriteToSavedPhotosAlbum(imageBao,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
            
        }];
        
        [alertControl addAction:cancel];
        [alertControl addAction:confirm];
        
        [self presentViewController:alertControl animated:YES completion:nil];
    }];
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = VFont;
    [rightBtn setTitle:@"邀请好友" forState:0];
    [rightBtn setTitleColor:BassColor(51, 51, 51) forState:0];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btnBack"] forState:0];
    [bachImg addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bachImg.mas_bottom).offset(-height(60));
        make.centerX.mas_equalTo(bachImg.mas_centerX).offset(width(80));
        make.height.mas_equalTo(height(39));
        make.width.mas_equalTo(width(143));
    }];
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
    
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            [self shareImageToPlatformType:platformType];
            // 根据获取的platformType确定所选平台进行下一步操作
        }];
    }];
    
    self.maImg =[[UIImageView alloc]init];
    [self.maImg sd_setImageWithURL:[NSURL URLWithString:self.share] placeholderImage:nil];
    [bachImg addSubview:self.maImg];
    [self.maImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(leftBtn.mas_top).offset(-height(5));
        make.centerX.mas_equalTo(bachImg.mas_centerX);
        make.height.mas_equalTo(height(112));
        make.width.mas_equalTo(width(111.5));
    }];
   
    
    UILabel * sLable =[HttpTool createLable:BassColor(51, 51, 51) font:VFont textAlignmen:NSTextAlignmentCenter text:[NSString stringWithFormat:@"请扫码下载"]];
    [bachImg addSubview:sLable];
    [sLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.maImg.mas_top).offset(-height(5));
        make.centerX.mas_equalTo(bachImg.mas_centerX);
        make.height.mas_equalTo(height(15.5));
        make.width.mas_equalTo(width(170));
    }];
    
    UIImageView * labImg =[[UIImageView alloc]init];
    labImg.image =[UIImage imageNamed:@"lineMa"];
    [bachImg addSubview:labImg];
    [labImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(sLable.mas_top).offset(-height(10));
        make.centerX.mas_equalTo(bachImg.mas_centerX);
        make.height.mas_equalTo(height(15.5));
        make.width.mas_equalTo(width(170));
    }];
    
    self.numLable = [HttpTool createLable:BassColor(51, 51, 51) font:VFont textAlignmen:NSTextAlignmentCenter text:[NSString stringWithFormat:@"推荐码%@",self.invite]];
    [bachImg addSubview:self.numLable];
    [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.mas_equalTo(sLable.mas_top).offset(-height(10));
        make.centerX.mas_equalTo(bachImg.mas_centerX);
        make.height.mas_equalTo(height(15.5));
        make.width.mas_equalTo(width(170));
    }];
    
    if (OPENID == nil || OPENID.length <= 0) {
        NSLog(@"%@", OPENID);
        UILabel *flagLab = [[UILabel alloc] init];
        flagLab.numberOfLines = 0;
        flagLab.text = @"您还没有关联微信，暂时无法分享，请通过微信登陆方式关联登陆手机号";
        flagLab.textAlignment = NSTextAlignmentCenter;
        flagLab.backgroundColor = [UIColor whiteColor];
        [bachImg addSubview:flagLab];
        [flagLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(leftBtn);
            make.right.equalTo(rightBtn);
            make.top.equalTo(sLable);
        }];
    }
}
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dianjiClick{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消保存图片");
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"确认保存图片");
        
        // 保存图片到相册
        UIImage * imageBao = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.poster]]]; UIImageWriteToSavedPhotosAlbum(imageBao,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
        
    }];
    
    [alertControl addAction:cancel];
    [alertControl addAction:confirm];
    
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo {
    
    NSString *message;
    
    if(!error) {
        
        message =@"成功保存到相册";
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }else {
        
        message = [error description];
        
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }
    
}
    //创建分享消息对象
    - (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
    {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = [UIImage imageNamed:@"icon"];
        [shareObject setShareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL  URLWithString:self.poster]]]];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
    }

@end
