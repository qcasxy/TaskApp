



//
//  HomeWebViC.m
//  taskApp
//
//  Created by per on 2020/1/4.
//  Copyright © 2020 per. All rights reserved.
//

#import "HomeWebViC.h"
#import <WebKit/WebKit.h>

@interface HomeWebViC ()<WKNavigationDelegate>

@property(nonatomic, strong)WKWebView *webView;

@end

@implementation HomeWebViC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:self.name];
    [self showDGActView];
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(goToBack)];
    
    // 正文
    _webView = [[WKWebView alloc] initWithFrame: self.view.bounds];
    _webView.navigationDelegate = self;
    [_webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:_urlStr]]];
    [self.view addSubview:_webView];
    
    if (@available(iOS 11.0, *)) {
        
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
}

-(void)goToBack{
    [self.navigationController popViewControllerAnimated:YES];
}

// 开始接收到返回数据
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [self stopDGActView];
}

@end
