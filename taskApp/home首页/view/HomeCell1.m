//
//  HomeCell1.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "HomeCell1.h"
@interface HomeCell1 ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@end
@implementation HomeCell1

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 图片轮播
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(width(10), 0, kScreenWidth-width(20), height(180)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter; // 设置pageControl居右，默认居中
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
        self.cycleScrollView.imageURLStringsGroup = @[@"http://b-ssl.duitang.com/uploads/blog/201512/01/20151201131252_XHtis.jpeg",@"http://b-ssl.duitang.com/uploads/item/201806/05/20180605182854_vkcpq.jpg"];
        _cycleScrollView.delegate = self ; // 如需监听图片点击，请设置代理，实现代理方法
        _cycleScrollView.autoScrollTimeInterval =2 ;// 自定义轮播时间间隔
        [self addSubview:_cycleScrollView];
        UIView * line =[[UIView alloc]initWithFrame:CGRectMake(0, height(190), kScreenWidth, height(10))];
        line.backgroundColor = BassColor(241, 241, 241);
        [self addSubview:line];
    }
    return self;
}

-(void)setCoverArr:(NSMutableArray *)coverArr{
    self.cycleScrollView.imageURLStringsGroup = coverArr;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(goToWeb:)]) {
        [self.delegate goToWeb:index];
    }
    //NSLog(@"%ld",index);
}
@end
