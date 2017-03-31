//
//  DBDTabBar.m
//  CaiPiao
//
//  Created by Mac on 17/3/18.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "DBDTabBar.h"

@interface DBDTabBar()

/**
 *  上一次选中的按钮
 */
@property (nonatomic, weak) UIButton *seleButton;
@end

@implementation DBDTabBar

/**
 *  set 方法
 */
- (void)setItems:(NSArray *)items{
    _items = items;
    for (UITabBarItem *item in items) {
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255. green:arc4random_uniform(255)/255. blue:arc4random_uniform(255)/255. alpha:1.];
        [button setBackgroundImage:item.image forState:UIControlStateNormal];
        [button setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(tabbarOnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
}

/**
 *  按钮点击，切换 控制器
 */
- (void)tabbarOnClick:(UIButton *)button{
 
    /** 取消上一次按钮的选中 **/
    self.seleButton.selected = NO;
    /** 选中这一次按钮  **/
    button.selected = YES;
    /** 记录这一次选中的按钮 **/
    self.seleButton = button;
    
    /**  通知按钮被点击 **/
    if ([self.delegate respondsToSelector:@selector(tabBar:index:)]) {
        [self.delegate tabBar:self index:button.tag];
    }
    
}
/**
 *  布局  子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.items.count;
    CGFloat buttonH = self.frame.size.height;
    
    int i = 0;
    
    for (UIButton *button in self.subviews) {
        
        buttonX = buttonW * i;
        button.tag = i;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        if (i == 0){
            button.selected = YES;
            /** 记录这次选中的按钮 **/
            self.seleButton = button;
        }
        i++;
    }
}

@end
