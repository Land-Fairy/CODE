//
//  DBDHallViewController.m
//  CaiPiao
//
//  Created by Mac on 17/3/19.
//  Copyright © 2017年 ggg. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "CollectionViewTool.h"
#import "DBDHallViewController.h"
#import "MainCell.h"
#import "AFNetworking.h"
#import "Lottery.h"
#import "WebVC.h"
@interface DBDHallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *myCollectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *urlArray;
@end

@implementation DBDHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.myCollectionView];
    //    [self getDataFromServer];
}
/**
 *  从服务器获取数据
 */
- (void)getDataFromServer{
    /**
     *  POST 请求
     */
    
    //    URL	http://m.cpbao.com/mobile/kjgg.jsp?v=1
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"v"];
    [manager POST:@"http://m.cpbao.com/mobile/kjgg.jsp" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data= [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"str==:%@",str);
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error===%@",error);
        
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}
//单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (SCREEN_WIDTH)/3;
    
    return CGSizeMake(width, width+20);
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
// 单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCell" forIndexPath:indexPath];
    NSString *str = self.dataArray[indexPath.item];
    [cell getCell:str];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //Lottery *vc = [Lottery new];
    NSString *url = self.urlArray[indexPath.item];
    WebVC *vc = [WebVC new];
    vc.webUrl = url;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) collectionViewLayout:layout];
        _myCollectionView.alwaysBounceVertical = YES;
        [_myCollectionView zy_registClass:[MainCell class]];
        
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.showsVerticalScrollIndicator = NO;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
    }
    return _myCollectionView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i =0; i<12;i++) {
            NSString *str = [NSString stringWithFormat:@"图层-%d",i+1];
            [_dataArray addObject:str];
        }
    }
    return _dataArray;
}
- (NSMutableArray *)urlArray{
    if (!_urlArray) {
        _urlArray = [[NSMutableArray alloc]initWithObjects:
                     @"http://www.cqcp.net",//重庆
                     @"http://www.tjflcpw.com",//天津
                     @"http://www.cjcp.com.cn/ssl/shanghai/",//上海
                     @"http://shishicai.cjcp.com.cn/xinjiang/",//新疆
                     @"http://bjscgfwz.twyahoo.top",//北京赛车
                     @"http://caipiao.163.com/order/kuailepuke/",//快乐扑克3
                     @"http://www.sdcp.cn",//山东群英会
                     @"http://www.cjcp.com.cn/kl8/beijing/",//北京快乐8
                     @"http://www.cqcp.net",//重庆
                     @"http://www.ahfc.gov.cn",//安徽快三
                     @"http://www.jslottery.com",//江苏快三
                     @"http://www.jlfc.com.cn/View/Index.aspx",//吉林快三
                     nil];
    }
    return _urlArray;
}
@end
