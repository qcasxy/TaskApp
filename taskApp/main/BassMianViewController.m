//
//  BassMianViewController.m
//  全民帮
//
//  Created by per on 2019/10/18.
//  Copyright © 2019 per. All rights reserved.
//

#import "BassMianViewController.h"
#import "DGActivityIndicatorView.h"
#import "UIView+Toast.h"

@interface BassMianViewController ()<UINavigationControllerDelegate>

@end

@implementation BassMianViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setNavTitle:(NSString *)title{
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.textColor = BassColor(51, 51, 51);
    titleLable.text = title;
    titleLable.font = [UIFont systemFontOfSize:16];
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;
}
-(void)showToastInView:(UIView*)view message:(NSString*)message duration:(NSTimeInterval)duration {
    [view hideAllToasts];
    [view makeToast:message duration:duration position:CSToastPositionCenter];
}
//右边按钮
-(void)setRightButton:(NSString*)title imgStr:(NSString*)imgStr selector:(SEL)selector{
    if (title.length==0) {
        UIImage * imageName = [UIImage imageNamed:imgStr];
        imageName = [imageName imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithImage:imageName style:UIBarButtonItemStylePlain target:self action:selector];
        self.navigationItem.rightBarButtonItem = rightItem;
    }else{
        UIButton  * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightbtn setTitleColor:BassColor(17, 151, 255) forState:0];
        rightbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightbtn setTitle:title forState:0];
        rightbtn.frame = CGRectMake(0, 0, 60, 0);
        [rightbtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
        self.navigationItem.rightBarButtonItem =rightItem;
    }
}
//左边按钮
-(void)setLeftButton:(NSString*)title imgStr:(NSString*)imgStr selector:(SEL)selector{
    if (title.length==0) {
        UIImage * imageName = [UIImage imageNamed:imgStr];
        imageName = [imageName imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:imageName style:UIBarButtonItemStylePlain target:self action:selector];
        self.navigationItem.leftBarButtonItem = leftItem;
    }else{
        UIButton  * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbtn setTitleColor:BassColor(51, 51,51) forState:0];
        leftbtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [leftbtn setTitle:title forState:0];
        leftbtn.frame = CGRectMake(0, 0, 60, 0);
        [leftbtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
        self.navigationItem.leftBarButtonItem =leftItem;
        
    }
}
-(void)showDGActView{
    [[UIApplication sharedApplication].keyWindow addSubview:self.DGActView];
    [self.DGActView startAnimating];
}
-(void)stopDGActView{
    [self.DGActView removeFromSuperview];
    [self.DGActView stopAnimating];
}
//加载view
- (DGActivityIndicatorView *)DGActView {
    if (!_DGActView) {
        _DGActView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor redColor]];
        CGFloat width =kScreenWidth / 5.0f;
        CGFloat height = kScreenHeight / 7.0f;
        _DGActView.frame = CGRectMake((kScreenWidth - width) / 2, (kScreenHeight - height) / 2, width, height);
    }
    return _DGActView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_DGActView removeFromSuperview];
    [_DGActView stopAnimating];
}
//是否隐藏
-(void)isHidden
{
    self.navigationController.delegate = self;
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL isShow = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShow animated:YES];
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
