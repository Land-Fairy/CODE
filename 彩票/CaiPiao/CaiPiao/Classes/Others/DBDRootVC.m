//
//  DBDRootVC.m
//  CaiPiao
//
//  Created by 高凯轩 on 2017/3/17.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "DBDRootVC.h"
#import "DBDFeatureCollectionVC.h"
#import "DBDMainTabBarController.h"
#import "DBDWebViewController.h"
@implementation DBDRootVC
/**
 *  返回 根 控制器
 */
+ (UIViewController *)chooseRootVCforWindowWithShowWeb:(NeedShowWeb)needShowWeb{
    UIViewController *rootVC = nil;
    /**
      *  1. 取出 当前 版本
      */
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    /**
      *  2. 已经保存的版本号
      */
    NSString *storeVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"Verson"];
    
    /**
      *  3. 判断是否有新版本呢
      */
    if ([currentVersion isEqualToString:storeVersion]) {/** 如果 没有新版本，则直接加载 **/
        /** 如果不需要 加载 web **/
        if (needShowWeb == NeedShowWebNo) {
            rootVC = [[DBDMainTabBarController alloc] init];
        }
        else{
            rootVC = [[DBDWebViewController alloc] init];
        }
    }
    else{
        /*** 如果有新版本， 首先存储 当前 版本号 *****/
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:currentVersion forKey:@"Verson"];
        [defaults synchronize];
        /*** 设置跟控制器 为 特性界面 ***/
        rootVC = [[DBDFeatureCollectionVC alloc] init];
    }
    return [[DBDWebViewController alloc] init];
}

@end
