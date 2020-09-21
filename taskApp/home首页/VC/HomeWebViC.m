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
@property(nonatomic, assign)BOOL isURL;

@end

@implementation HomeWebViC


-(instancetype)initWithURL:(NSURL *) url {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _isURL = YES;
        _url = url;
    }
    return self;
}

-(instancetype)initWithContent:(NSString *) htmlString {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _isURL = NO;
        _context = htmlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.name == nil) {
        [self setNavTitle: @"详情"];
    }else {
        [self setNavTitle: self.name];
    }
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(goToBack)];
    
    // 正文
    _webView = [[WKWebView alloc] initWithFrame: self.view.bounds];
    _webView.navigationDelegate = self;
    _webView.scrollView.bounces = false;
    if (_isURL) {
        [_webView loadRequest: [NSURLRequest requestWithURL: _url]];
        [self showDGActView];
    }else if (_context != nil) {
        [_webView loadHTMLString:_context baseURL:[NSURL URLWithString:API_URL]];
    }
    [self.view addSubview:_webView];
    
    if (@available(iOS 11.0, *)) {
        
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        
    }else {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
}

-(void)goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

// 开始接收到返回数据
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [self stopDGActView];
}

@end
