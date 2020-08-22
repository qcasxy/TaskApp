



//
//  HomeWebViC.m
//  taskApp
//
//  Created by per on 2020/1/4.
//  Copyright © 2020 per. All rights reserved.
//

#import "HomeWebViC.h"

@interface HomeWebViC ()<UIWebViewDelegate>
@property (nonatomic , weak) UIWebView *webView;
@end

@implementation HomeWebViC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:self.name];
    [self showDGActView];
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(goToBack)];
    // 正文
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    
    webView.delegate = self;
    webView.scrollView.scrollEnabled = YES;
    [self.view addSubview:webView];
    _webView = webView;
    
    if (@available(iOS 11.0, *)) {
        
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
    
    // Do any additional setup after loading the view.
}
-(void)goToBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self stopDGActView];
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
