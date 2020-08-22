//
//  QianDaoViewController.m
//  CalendarSign
//
//  Created by WYN on 2017/5/31.
//  Copyright © 2017年 WYN. All rights reserved.
//

#import "QianDaoViewController.h"
#import <FSCalendar/FSCalendar.h>
#import "DIYCalendarCell.h"
#import "FSCalendarExtensions.h"
#import "WXApi.h"
#define mainColor BassColor(51, 51, 51)
@interface QianDaoViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (weak, nonatomic) FSCalendar *calendar;

@property (weak, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;



@end

@implementation QianDaoViewController

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    UIImageView * qianImg =[[UIImageView alloc]init];
    qianImg.backgroundColor =BassColor(50, 165, 252);
    [view addSubview:qianImg];
    [qianImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(view);
        make.top.mas_equalTo(view);
        make.height.mas_equalTo(height(266));
    }];
    UIButton*qianbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [qianbtn setTitle:@"签到" forState:UIControlStateNormal];
    [qianbtn setTitleColor:mainColor forState:UIControlStateNormal];
    [qianbtn setBackgroundImage:[UIImage imageNamed:@""] forState:0];
    [qianbtn addTarget:self action:@selector(clickQiandao) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:qianbtn];
    [qianbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right).offset(-width(40));
        make.width.height.mas_equalTo(width(100));
        make.top.mas_equalTo(view).offset(height(34.5));
    }];
    UILabel * num =[[UILabel alloc]init];
    num.textColor = BassColor(255, 255, 255);
    num.font =[UIFont systemFontOfSize:18];
    num.text = [NSString stringWithFormat:@"%@次",self.datadic[@"continuous"]];
    num.textAlignment = NSTextAlignmentCenter;
    [view addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(height(50));
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(height(18));
    }];
    
    UILabel * num1 =[[UILabel alloc]init];
    num1.textColor = BassColor(255, 255, 255);
    num1.font =[UIFont systemFontOfSize:18];
    num1.text = @"连续签到";
    num1.textAlignment = NSTextAlignmentCenter;
    [view addSubview:num1];
    [num1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view);
        make.top.mas_equalTo(num.mas_bottom).offset(height(10));
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(height(18));
    }];
    UILabel * num2 =[[UILabel alloc]init];
    num2.textColor = BassColor(255, 255, 255);
    num2.font =[UIFont systemFontOfSize:18];
    num2.text = [NSString stringWithFormat:@"%@次",self.datadic[@"accumulate"]];
    num2.textAlignment = NSTextAlignmentCenter;
    [view addSubview:num2];
    [num2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view);
        make.top.mas_equalTo(num1.mas_bottom).offset(height(10));
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(height(18));
    }];
    
    
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0,height(180), view.frame.size.width, height)];
    calendar.scrollEnabled=NO;
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.appearance.weekdayTextColor=mainColor;
    calendar.appearance.headerTitleColor=mainColor;
    calendar.allowsMultipleSelection = YES;
    [view addSubview:calendar];
    self.calendar = calendar;
    calendar.backgroundColor =UIColor.whiteColor;
    calendar.calendarHeaderView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    calendar.calendarWeekdayView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    calendar.appearance.selectionColor =[UIColor clearColor];
    
    calendar.today = nil; // Hide the today circle
    [calendar registerClass:[DIYCalendarCell class] forCellReuseIdentifier:@"cell"];
//    UIView * clearView=[[UIView alloc]initWithFrame:CGRectMake(0,height(180), view.frame.size.width, height)];
//    clearView.backgroundColor =[UIColor clearColor];
//    [view addSubview:clearView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"success" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payFail) name:@"fail" object:nil];
    [self setNavTitle:@"打卡签到"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    //_dataArr=[[NSMutableArray alloc]init];
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    for (int i=0; i<_dataArr.count; i++) {
        [self.calendar selectDate:[self.dateFormatter dateFromString:_dataArr[i]] scrollToDate:YES];
    }

    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    _calendar.locale = locale;  // 设置周次是中文显示
    // 设置不能翻页
       _calendar.pagingEnabled = NO;
         //   _calendar.scrollEnabled = NO;
    self.calendar.accessibilityIdentifier = @"calendar";
    
   
        
    
    
}
//定制今天的日期还有好多有趣的API可以自己去看看
- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @"今";
    }
    return nil;
}


#pragma mark - FSCalendarDataSource
//设置最小日期
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter dateFromString:@"2016-07-08"];
}
//最大
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:0 toDate:[NSDate date] options:0];
}

//定制cell
- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    DIYCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    //定制图片
    //cell.circleImageView.image=[UIImage imageNamed:@"勾16"];
    return cell;
}

#pragma mark - FSCalendarDelegate
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    //当天不能点击
//    if ([self.gregorian isDateInToday:date]) {
        return NO;
//    }else{
//        return YES;
//    }
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    if ([_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
        return;
    }

        if (![_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
            [_dataArr addObject:[self.dateFormatter stringFromDate:date]];
            NSLog(@"%@",_dataArr);
            [calendar reloadData];
            
        }else{
            //重复的不加
        }
  
    
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
 
}

/**
 * Asks the delegate for day text color in selected state for the specific date.
 */
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date{
    return [UIColor blackColor];
    
}
-(void)clickQiandao
{
    [HttpTool post:API_POST_clockIn dic:@{@"paytype":@"2"} success:^(id  _Nonnull responce) {
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = responce[@"appId"];
        request.prepayId= [[responce[@"package"] componentsSeparatedByString:@"="] lastObject];
        request.package = @"Sign=WXPay";
        request.nonceStr= responce[@"nonceStr"];
        request.timeStamp= [responce[@"timeStamp"] intValue];
        request.sign= responce[@"signType"];
        [WXApi sendReq:request];
    } faile:^(NSError * _Nonnull erroe) {
        
    }];
    if (![_dataArr containsObject:[self.dateFormatter stringFromDate:[NSDate date]]]) {
        [_dataArr addObject:[self.dateFormatter stringFromDate:[NSDate date]]];
        NSLog(@"%@",_dataArr);
        for (int i=0; i<_dataArr.count; i++) {
            [self.calendar selectDate:[self.dateFormatter dateFromString:_dataArr[i]] scrollToDate:YES];
        }
        [_calendar reloadData];
    }
    
}

- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(nonnull NSDate *)date
{
    
    return 0.0;
}

- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    
    if ([_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
        return [UIImage imageNamed:@"勾16"];
    }else{
        return nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"success" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"fail" object:nil];
     NSLog(@"%s",__FUNCTION__);
}
-(void)paySuccess{
   
}
-(void)payFail{
   
}
@end
