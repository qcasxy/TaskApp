
//
//  OrderVC.m
//  taskApp
//
//  Created by per on 2019/11/9.
//  Copyright © 2019 per. All rights reserved.
//

#import "OrderVC.h"
#import "JohnTopTitleView.h"
#import "DFSegmentView.h"
#import "OrderAllVC.h"
#import "SubmissionVC.h"
#import "InAuditVC.h"
#import "UnqualifiedVC.h"
#import "CompletedVC.h"
@interface OrderVC ()
@property (nonatomic,strong) JohnTopTitleView *titleView;
@end

@implementation OrderVC
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"我的接单"];
    self.view.backgroundColor = BassColor(241, 241, 241);
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    [self createUI];
}
- (void)createUI{
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"全部",@"待提交",@"审核中",@"不合格",@"已完成",nil];
    self.titleView.A = _typeIndex;
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
    
}
- (NSArray <UIViewController *>*)setChildVC{
    
    //
    //    AllOrderViewController * allVC = [[AllOrderViewController alloc]init];
   OrderAllVC *VC1 = [[OrderAllVC alloc]init];
    SubmissionVC *VC2 = [[SubmissionVC alloc]init];
    InAuditVC *VC3 = [[InAuditVC alloc]init];
   UnqualifiedVC *VC4 = [[UnqualifiedVC alloc]init];
    CompletedVC *VC5 = [[CompletedVC alloc]init];
    NSArray *childVC = [NSArray arrayWithObjects:VC1 ,VC2 ,VC3 ,VC4 ,VC5,nil];
    
    
    return childVC;
}

#pragma mark - getter
- (JohnTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    }
    return _titleView;
}
- (UIViewController *)subViewControllerWithIndex:(NSInteger)index {
    
    if (index == 0) {
        
        OrderAllVC *VC = [[OrderAllVC alloc]init];
        
        return VC;
    }else if(index==1){
        SubmissionVC *VC = [[SubmissionVC alloc]init];
        
        return VC;
    }else if(index==2){
        InAuditVC *VC = [[InAuditVC alloc]init];
        
        return VC;
    }else if(index==3){
        UnqualifiedVC *VC = [[UnqualifiedVC alloc]init];
        
        return VC;
    }else{
        CompletedVC *VC = [CompletedVC new];
        
        //        FVC.index = [NSString stringWithFormat:@"第%ld页",index];
        
        return VC;
    }
    return nil;
}


- (void)headTitleSelectWithIndex:(NSInteger)index {
    
    //  在这里可以获取到当前的baseViewController
    //  对VC里面进行赋值 调方法进行网络请求或者一些逻辑操作
    //  可以在当前控制器增加属性 currentIndex = index 在当前控制器 随时都可以用currentIndex获取到baseViewController
    
    NSLog(@"---%ld",index);
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
