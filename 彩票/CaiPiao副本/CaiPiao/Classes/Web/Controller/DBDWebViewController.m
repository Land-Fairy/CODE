//
//  DBDWebViewController.m
//  CaiPiao
//
//  Created by 高凯轩 on 2017/3/17.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "DBDWebViewController.h"
#import <WebKit/WebKit.h>
#import "DBDGlobal.h"
#define url @"https://www.baidu.com/"
@interface DBDWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation DBDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  添加 WebView
     */
    [self addWebView];
}
/**
 *  添加 WebView
 */
- (void)addWebView{
    DBDGlobal *global = [DBDGlobal sharedManager];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    [webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:global.weburl]]];
    [webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:url]]];
    [self.view addSubview: webView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 代理


@end
