//
//  WebXieViewController.m
//  全民帮
//
//  Created by per on 2019/10/22.
//  Copyright © 2019 二恒. All rights reserved.
//

#import "WebXieViewController.h"
#import <WebKit/WebKit.h>

@interface WebXieViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWeb;
@end

@implementation WebXieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:self.name];
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(goToBack)];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    _wkWeb = [[WKWebView alloc] initWithFrame: CGRectZero configuration:wkWebConfig];
    self.wkWeb.navigationDelegate = self;
    self.wkWeb.scrollView.scrollEnabled = YES;
    self.wkWeb.backgroundColor = UIColor.whiteColor;
    self.wkWeb.opaque = false;
    [self.view addSubview:self.wkWeb];
    [self.wkWeb loadHTMLString:self.context baseURL:nil];
    [self.wkWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    if (@available(iOS 11.0, *)) {
//        _wkWeb.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        //        _wkWeb.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        //        _wkWeb.scrollView.scrollIndicatorInsets = _wkWeb.scrollView.contentInset;
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

-(void)goToBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //改变背景颜色
    [webView evaluateJavaScript:@"document.body.style.backgroundColor = '#ffffff'" completionHandler: nil];
    //改变字体颜色
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'" completionHandler: nil];
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'" completionHandler: nil];
    NSString *js = @"function imgAutoFit() { var imgs = document.getElementsByTagName('img');document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%';for (var i = 0; i < imgs.length; i++) {var img = imgs[i];img.style.width = %f;}}";
    
    js = [NSString stringWithFormat:js, kScreenWidth - 20];
    [webView evaluateJavaScript:js completionHandler: nil];
    [webView evaluateJavaScript:@"imgAutoFit()" completionHandler: nil];
}

@end
