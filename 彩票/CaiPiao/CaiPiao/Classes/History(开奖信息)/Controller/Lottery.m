

//
//  Lottery.m
//  FirstVC
//
//  Created by mac on 2017/3/18.
//  Copyright © 2017年 mac. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "Lottery.h"
#import "UITableView+Regist.h"
#import "MyCell.h"
#import "AFNetworking.h"
@interface Lottery ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTable;
@property(nonatomic,strong)NSDictionary *myDic;

@end

@implementation Lottery

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor redColor];
    [self getDataFromServer];
    [self.view addSubview:self.myTable];
}
- (void)getDataFromServer{
    /**
     *  POST 请求
     */
    
    //    URL	http://m.cpbao.com/mobile/kjgg.jsp?v=1
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"1" forKey:@"v"];
    [manager POST:@"http://m.cpbao.com/mobile/kjgg.jsp" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data= [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"str==:%@",str);
//        
//        NSLog(@"%@",responseObject);
        
       self.myDic = responseObject[@"object"];
        [self.myTable reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error===%@",error);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    NSString *str = self.myDic[@"sort"];
    NSArray *array = [str componentsSeparatedByString:@"，"];
    NSString *key = array[indexPath.row];
//    cell.titleLabel.text = key;
    NSDictionary *dic = self.myDic[key];
    [cell getCell:dic];
    return cell;
    
}
- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-49-64) style:UITableViewStylePlain];
        [_myTable zy_registClassCell:[MyCell class]];
        _myTable.rowHeight = 130;
        _myTable.delegate = self;
        _myTable.dataSource = self;
        
        
    }
    return _myTable;
}
@end
