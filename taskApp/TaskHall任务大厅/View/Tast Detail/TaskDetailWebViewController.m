//
//  TaskDetailWebViewController.m
//  taskApp
//
//  Created by 秦程 on 2020/9/7.
//  Copyright © 2020 per. All rights reserved.
//

#import "TaskDetailWebViewController.h"
#import <WebKit/WebKit.h>

@interface TaskDetailWebViewController ()

@property(nonatomic, strong)WKWebView *webView;

@end

@implementation TaskDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle: @"任务详情"];
    self.view.backgroundColor =BassColor(241, 241, 241);
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(goToBack)];
    
    // 正文
    _webView = [[WKWebView alloc] initWithFrame: self.view.bounds];
    [_webView loadHTMLString:_context baseURL:nil];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
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

@end
