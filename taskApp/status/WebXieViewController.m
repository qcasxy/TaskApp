//
//  WebXieViewController.m
//  全民帮
//
//  Created by per on 2019/10/22.
//  Copyright © 2019 二恒. All rights reserved.
//

#import "WebXieViewController.h"

@interface WebXieViewController ()<UIWebViewDelegate>
@property (nonatomic , weak) UIWebView *webView;
@end

@implementation WebXieViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:self.name];
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(goToBack)];
    // 正文
    UIWebView *webView = [[UIWebView alloc] init];
    if ([self.name isEqualToString:@"用户协议"]) {
        webView.frame = CGRectMake(0, NavHeight,kScreenWidth , kScreenHeight-NavHeight);
    }else{
        webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-NavHeight );
    }
    
    webView.delegate = self;
    webView.scrollView.scrollEnabled = YES;
    [self.view addSubview:webView];
    _webView = webView;
    
    [_webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#ffffff'"];
    
    
    _webView.backgroundColor=UIColor.whiteColor;
    
    [_webView setOpaque:FALSE];
    
    if (@available(iOS 11.0, *)) {
        
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    [self load_xiang_wenZhang];
    
    // Do any additional setup after loading the view.
}

-(void)goToBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)load_xiang_wenZhang{
    [self.webView loadHTMLString:self.context baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //改变背景颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#ffffff'"];
    //改变字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'"];
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
    NSString *js = @"function imgAutoFit() { var imgs = document.getElementsByTagName('img');document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%';for (var i = 0; i < imgs.length; i++) {var img = imgs[i];img.style.width = %f;}}";
    
    js = [NSString stringWithFormat:js, kScreenWidth - 20];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
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
