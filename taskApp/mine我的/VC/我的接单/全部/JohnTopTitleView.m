//
//  JohnTopTitleView.m
//  TopTitle
//
//  Created by aspilin on 2017/4/11.
//  Copyright © 2017年 aspilin. All rights reserved.
//

#import "JohnTopTitleView.h"
#define ViewWidth self.frame.size.width
#define ViewHeight self.frame.size.height

@interface JohnTopTitleView ()<UIScrollViewDelegate>{
    CGFloat _titleHeight;  //标题高度
    CGFloat _lineViewWidth;  //记录底部线长度
}

@property (nonatomic,strong) UISegmentedControl *titleSegment;

@property (nonatomic,strong) UIScrollView *pageScrollView;

@property (nonatomic,strong) UIView *lineView;

@end
@implementation JohnTopTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setting];
        
    }
    return self;
}

#pragma mark - 初始化设置
- (void)setting{
    self.backgroundColor = [UIColor whiteColor];
    
    //title
    _titleHeight = height(40);
    self.titleSegment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, ViewWidth,_titleHeight)];
    self.titleSegment.tintColor = [UIColor clearColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:isIPhoneX ? isFont(16) : isFont(14),
                                             NSForegroundColorAttributeName:BassColor(17, 151, 255)};
    [self.titleSegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:isIPhoneX ? isFont(16) : isFont(14),
                                               NSForegroundColorAttributeName:[UIColor colorWithRed:51/225.0 green:51/225.0 blue:51/225.0 alpha:1]};
    [self.titleSegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [self.titleSegment addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    self.titleSegment.selectedSegmentIndex =self.A;
    [self addSubview:self.titleSegment];
    
    //滑动sc
    self.pageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleSegment.frame), ViewWidth, ViewHeight - _titleHeight)];
    self.pageScrollView.bounces = NO;
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.showsVerticalScrollIndicator = NO;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.pageScrollView.delegate = self;
    [self addSubview:self.pageScrollView];
    
    //底部线
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = BassColor(17, 151, 255);
    [self addSubview:self.lineView];

}

#pragma mark - 定制title
- (void)setTitle:(NSArray *)title{
    if (title.count > 0) {
        for (NSInteger i = 0; i < title.count; i ++) {
            [self.titleSegment insertSegmentWithTitle:[title objectAtIndex:i] atIndex:i animated:NO];
        }
    }
   self.titleSegment.selectedSegmentIndex =self.A;
}

#pragma mark - 定制VC
- (void)setupViewControllerWithFatherVC:(UIViewController *)fatherVC childVC:(NSArray<UIViewController *>*)childVC{
    NSInteger page = childVC.count;
    _lineViewWidth = ViewWidth / page;
    self.lineView.frame = CGRectMake(0, _titleHeight - 1,_lineViewWidth, 1);
    self.pageScrollView.contentSize = CGSizeMake(ViewWidth * page, 0);
    
    for (NSInteger i = 0; i < page; i ++) {
        UIViewController *vc = [childVC objectAtIndex:i];
        vc.view.frame = CGRectMake(ViewWidth * i, 0, ViewWidth, ViewHeight);
        [fatherVC addChildViewController:vc];
        [self.pageScrollView addSubview:vc.view];
    }
  [self.pageScrollView setContentOffset:CGPointMake(ViewWidth *self.titleSegment.selectedSegmentIndex,0) animated:NO];
    CGFloat lineViewCenterX = self.titleSegment.selectedSegmentIndex *_lineViewWidth + _lineViewWidth / 2;
    [UIView transitionWithView:self.lineView duration:0.3 options:      UIViewAnimationOptionAllowUserInteraction  animations:^{
        self.lineView.center = CGPointMake(lineViewCenterX,self->_titleHeight - .5);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 联动设置
- (void)pageChange:(UISegmentedControl *)seg{
    [self changeWithPage:seg.selectedSegmentIndex];
    [self.pageScrollView setContentOffset:CGPointMake(ViewWidth *seg.selectedSegmentIndex,0) animated:NO];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / ViewWidth;
    self.titleSegment.selectedSegmentIndex = page;
    [self changeWithPage:page];
}

- (void)changeWithPage:(NSInteger)page{
    CGFloat lineViewCenterX = page *_lineViewWidth + _lineViewWidth / 2;
    [UIView transitionWithView:self.lineView duration:0.3 options:      UIViewAnimationOptionAllowUserInteraction  animations:^{
        self.lineView.center = CGPointMake(lineViewCenterX,self->_titleHeight - .5);
    } completion:^(BOOL finished) {
    }];
}
@end
