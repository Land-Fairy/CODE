//
//  DBDMainTabBarController.m
//  DBDMeiZi
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "DBDMainTabBarController.h"
#import "DBDHomeCollectionViewController.h"
#import "DBDSettingTableViewController.h"
@interface DBDMainTabBarController ()

@end

@implementation DBDMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  添加自控制器
     */
    [self addChildVC];
}
/**
 *  添加自控制器
 */
- (void)addChildVC{
    DBDHomeCollectionViewController *homeVC = [[DBDHomeCollectionViewController alloc] init];
    [self setImg:nil selImg:nil andTitle:@"主页" forVC:homeVC];
    
    DBDSettingTableViewController *setVC = [[DBDSettingTableViewController alloc] init];
    
    [self setImg:nil selImg:nil andTitle:@"设置" forVC:setVC];
    
}
/**
 *  统一设置 导航控制器  ，图片 ，选中图片，标题等
 */
- (void)setImg:(UIImage *)img selImg:(UIImage *)selImg andTitle:(NSString *)title forVC:(UIViewController *)vc{
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.title = title;
    
    [navc.tabBarItem setTitle:title];
    [navc.tabBarItem setImage:img];
    [navc.tabBarItem setSelectedImage:selImg];
    [self addChildViewController:navc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
