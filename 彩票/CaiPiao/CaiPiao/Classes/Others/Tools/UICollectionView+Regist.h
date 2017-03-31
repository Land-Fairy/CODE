//
//  UICollectionView+Regist.h
//  CollectionView布局效果
//
//  Created by 张泽楠 on 15/12/24.
//  Copyright © 2015年 张泽楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Regist)
/*  注:想要使用者两个方法,需要保证重用标识符和类名相同*/


/**
 *  注册带有Xib的单元格
*/
- (void)zy_registNib:(Class)aClass;
/**
 *  注册类的单元格
 */
- (void)zy_registClass:(Class)aClass;
/**
 *  注册带有Xib的区头
 */
- (void)zy_registHeader:(Class)aClass;
/**
 *  注册带有Xib的区尾
 */
- (void)zy_registFooter:(Class)aClass;

@end











