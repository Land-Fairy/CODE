//
//  DBDTabBar.h
//  CaiPiao
//
//  Created by Mac on 17/3/18.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBDTabBar;

@protocol DBDTabBarDelegate <NSObject>
/**
 *  tabbar 上 按钮 被点击
 */
- (void)tabBar:(DBDTabBar *)tabBar index:(NSInteger)index;

@end


@interface DBDTabBar : UIView
/**
 *  tarbaritem 数组
 */
@property (nonatomic, strong) NSArray *items;
/**
 *  代理
 */
@property (nonatomic, weak) id<DBDTabBarDelegate> delegate;
@end
