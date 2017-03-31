//
//  DBDTradeViewController.m
//  CaiPiao
//
//  Created by Mac on 17/3/18.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "DBDTradeViewController.h"
#import "AFNetworking.h"
#import "DBDTradView.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface DBDTradeViewController ()

@end

@implementation DBDTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
      *  从服务器获取数据
      */
    //[self getDataFromServer];
    [self addTradeView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/**
 *  从服务器获取数据
 */
- (void)getDataFromServer{
    /**
     *  POST 请求
     */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://www.11c8.com/trend/ajaxList.html" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *dict = (NSDictionary *)responseObject;
        NSLog(@"%@",dict[@"Desc"]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)addTradeView{
    DBDTradView *view = [[DBDTradView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH-64-49)];
    [self.view addSubview:view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
