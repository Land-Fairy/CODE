//
//  DBDMainTabBarController.m
//  CaiPiao
//
//  Created by 高凯轩 on 2017/3/17.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "DBDMainTabBarController.h"
#import "DBDHallTableViewController.h"
#import "DBDArenaViewController.h"
#import "DBDDiscoverTableViewController.h"
#import "DBDHistoryTableViewController.h"
#import "DBDMeViewController.h"
#import "DBDTradeViewController.h"

#import "DBDTabBar.h"
@interface DBDMainTabBarController ()<DBDTabBarDelegate>
/**
 *  所有item模型
 */
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation DBDMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildVC];
    [self setupTabBar];
    
}

- (NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)setUpChildVC{
    /**
      * 购彩大厅
      */
    DBDHallTableViewController *hallVC = [[DBDHallTableViewController alloc] init];
    [self setupChildController:hallVC image:[UIImage imageNamed:@"TabBar_Hall_new"] seleImage:[UIImage imageNamed:@"TabBar_Hall_selected_new"]title:@"购彩大厅"];
    
    
    /**
     *   趋势图
     */
    DBDTradeViewController *areaVC = [[DBDTradeViewController alloc] init];
    [self setupChildController:areaVC image:[UIImage imageNamed:@"TabBar_Arena_new"] seleImage:[UIImage imageNamed:@"TabBar_Arena_selected_new"] title:@"开奖趋势"];
//    /**
//     * 发现
//     */
//    DBDDiscoverTableViewController *discoverVC = [[DBDDiscoverTableViewController alloc] init];
//    [self setupChildController:discoverVC image:[UIImage imageNamed:@"TabBar_Discovery_new"] seleImage:[UIImage imageNamed:@"TabBar_Discovery_selected_new"] title:@"发现"];
    /**
     * 开奖信息
     */
    DBDHistoryTableViewController *historyVC = [[DBDHistoryTableViewController alloc] init];
    [self setupChildController:historyVC image:[UIImage imageNamed:@"TabBar_History_new"] seleImage:[UIImage imageNamed:@"TabBar_History_selected_new"] title:@"开奖信息"];
    /**
     * 我的彩票
     */
    DBDMeViewController *meVC = [[DBDMeViewController alloc] init];
    [self setupChildController:meVC image:[UIImage imageNamed:@"TabBar_MyLottery_new"] seleImage:[UIImage imageNamed:@"TabBar_MyLottery_selected_new"] title:@"我的彩票"];
    
    
    
}

#pragma mark - 添加tabBar
- (void)setupTabBar{
    //  2. 移除系统TabBar 添加自己的TabBar(简单粗暴)
    //    [self.tabBar removeFromSuperview];
    /*
     添加自己的TabBar UIView
     1.添加button
     2.如何切换控制器 selectedIndex
     */
    
    //    self.selectedIndex = 1;
    
    DBDTabBar *tabBar = [[DBDTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.delegate = self;
    tabBar.items = self.items;
    //tabBar.backgroundColor = [UIColor yellowColor];
    [self.tabBar addSubview:tabBar];
    //[self setValue:tabBar forKeyPath:@"tabBar"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    2.1.2 移除系统TabBar 子控件,添加自己的控件
    // UITabBarButton 私有属性
    
    
    for (UIView *view in self.tabBar.subviews) {
        //        NSLog(@"%@",view);
        // 1.方法 hasPrefix 判断是否以这个前缀开头
        // hasSuffix 判断后缀
        //        NSString *classString = NSStringFromClass([view class]);
        //        if ([classString hasPrefix:@"UITabBarButton"]) {
        //            [view removeFromSuperview];
        //        }
        
        // 2.方法 思路:子类是私有的看父类是否是私有的,
        //        NSLog(@"%@",view.superclass);
        //        if ([view isKindOfClass:[UIControl class]]) {
        //            [view removeFromSuperview];
        //        }
        
        // 3. 逆向思维 判断如果不是 XMGTabBar就移除
        if (![view isKindOfClass:[DBDTabBar class]]) {
            [view removeFromSuperview];
        }
    }
}

// 添加一个自控制器
- (void)setupChildController:(UIViewController *)vc image:(UIImage *)image seleImage:(UIImage *)seleImage title:(NSString *)title{
    
    // 包装导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    if ([vc isKindOfClass:[UINavigationController class]]){
        nav = [[UINavigationController alloc] initWithRootViewController:vc];
    }
    
    [self addChildViewController:nav];
    // 导航控制的标题有栈顶控制器决定
    //    vc.navigationItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = seleImage;
    [self.items addObject:vc.tabBarItem];
}

#pragma mark - XMGTabBarDelegate
- (void)tabBar:(DBDTabBar *)tabBar index:(NSInteger)index{
    //    NSLog(@"%ld",index);
    // 切换控制器
    self.selectedIndex = index;
}
@end
