//
//  AppDelegate.m
//  CaiPiao
//
//  Created by 高凯轩 on 2017/3/17.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "AppDelegate.h"
#import "DBDMainTabBarController.h"
#import "DBDRootVC.h"
#import "DBDGlobal.h"
#import "AFNetworking.h"
#define APPID @"155115"
#define BaseUrl @"http://appmgr.jwoquxoc.com/frontApi/getAboutUs"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)getDataFromServer{
    
    /**
     *  获取单利 用来存放 url,是否需要加载 web 等信息
     */
    DBDGlobal *global = [DBDGlobal sharedManager];
    
    /**
      *  POST 请求
      */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:APPID forKey:@"appid"];
    [manager POST:BaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *responseData = [[NSData alloc]initWithData:responseObject];
        NSDictionary *jsonToDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        /** 
          *  接口 返回 为空
          */
        if(responseData.length == 0){
            self.window.rootViewController = [DBDRootVC chooseRootVCforWindowWithShowWeb:NeedShowWebNo];
        }
        else{
            NSString *status = jsonToDictionary[@"status"];
            /*** 返回成功   *****/
            if ([status integerValue] == 1) {
                /** 是否 显示 web ; 为 1 显示，为 2 不显示**/
                if([jsonToDictionary[@"isshowwap"] isEqualToString:@"1"])
                {
                    global.weburl = jsonToDictionary[@"wqpurl"];
                    global.isShowWeb = YES;
                    self.window.rootViewController = [DBDRootVC chooseRootVCforWindowWithShowWeb:NeedShowWebYes];
                }
                else{
                    global.isShowWeb = NO;
                    self.window.rootViewController = [DBDRootVC chooseRootVCforWindowWithShowWeb:NeedShowWebNo];
                }
            }
            else{/****  返回失败 ***/
                
            }
            
        }
        [self.window makeKeyAndVisible];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = [DBDRootVC chooseRootVCforWindowWithShowWeb:NeedShowWebYes];
    self.window.rootViewController = [[DBDMainTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    //[self getDataFromServer];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
