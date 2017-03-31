//
//  DrawView.h
//  DrawBoard
//
//  Created by Mac on 17/3/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
@property (nonatomic, strong) UIColor *currColor;
@property (nonatomic, assign) CGFloat currLineWidth;

/**
 *  橡皮擦
 */
- (void)erase;

/**
 *  撤销
 */
- (void)undo;

/**
 *  清屏
 */
- (void)clearScreen;
@end
