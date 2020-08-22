//
//  MyDIYEmpty.m
//  CheckCoupons
//
//  Created by zhongmao on 2017/12/20.
//  Copyright © 2017年 zhongmao. All rights reserved.
//

#import "MyDIYEmpty.h"

@implementation MyDIYEmpty

+ (instancetype)diyNoDataEmpty{
    MyDIYEmpty *diy = [MyDIYEmpty emptyViewWithImageStr:@"nodata_bg_image"
                                               titleStr:NSLocalizedString(@"暂无数据", @"")
                                              detailStr:@""];
   diy.autoShowEmptyView = YES;
    diy.titleLabTextColor = BassColor(51, 51, 51);
    diy.imageSize = CGSizeMake(150, 150);
    return diy;
}
+ (instancetype)diyNoNetworkEmptyWithTarget:(id)target action:(SEL)action{
    
    MyDIYEmpty *diy = [MyDIYEmpty emptyActionViewWithImageStr:@"noData"
                                                     titleStr:NSLocalizedString(@"暂无数据", @"")
                                                    detailStr:@"请检查您的网络连接是否正确!"
                                                  btnTitleStr:@"重新加载"
                                                       target:target
                                                       action:action];
    diy.imageSize = CGSizeMake(150, 150);
    
    return diy;
}
//通过方法+ (instancetype)emptyViewWithCustomView:(UIView *)customView;
//传入一个View 即可创建一个自定义的emptyView
+ (instancetype)diyCustomEmptyViewWithTarget:(id)target action:(SEL)action{
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"暂无数据，请稍后再试！";
    [customView addSubview:titleLab];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 80, 30)];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"重试" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 50, 80, 30)];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"加载" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:button2];
    
    MyDIYEmpty *diy = [MyDIYEmpty emptyViewWithCustomView:customView];
    return diy;
}

- (void)prepare{
    [super prepare];
    self.autoShowEmptyView = NO;

//    self.subViewMargin = 15.f;
//    self.contentViewOffset = -30;
//
//
//    self.titleLabFont = [UIFont systemFontOfSize:16];
//    self.titleLabTextColor = RGB(90, 180, 160);
//    self.titleLabTextColor = [UIColor grayColor];
//
//    self.detailLabFont = [UIFont systemFontOfSize:17];
//    self.detailLabTextColor = RGB(180, 120, 90);
//    self.detailLabMaxLines = 5;
    
    
//    self.actionBtnBackGroundColor = RGB(90, 180, 160);
//    self.actionBtnTitleColor = [UIColor whiteColor];
//    self.actionBtnBackGroundColor = [UIColor clearColor];
//    self.actionBtnTitleColor = MAIN_COLOR;
//    self.actionBtnFont = [UIFont systemFontOfSize:16];
//    self.actionBtnHeight = 20;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
