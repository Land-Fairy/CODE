//
//  UICollectionView+Regist.m
//  CollectionView布局效果
//
//  Created by 张泽楠 on 15/12/24.
//  Copyright © 2015年 张泽楠. All rights reserved.
//

#import "UICollectionView+Regist.h"

@implementation UICollectionView (Regist)


- (void)zy_registNib:(Class)aClass {
    NSString *name = NSStringFromClass(aClass);
    [self registerNib:[UINib nibWithNibName:name bundle:nil] forCellWithReuseIdentifier:name];
}

- (void)zy_registClass:(Class)aClass {
     NSString *name = NSStringFromClass(aClass);
    [self registerClass:aClass forCellWithReuseIdentifier:name];
}

- (void)zy_registHeader:(Class)aClass {
    NSString *name = NSStringFromClass(aClass);
    [self registerNib:[UINib nibWithNibName:name bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:name];
}

- (void)zy_registFooter:(Class)aClass {
    NSString *name = NSStringFromClass(aClass);
    [self registerNib:[UINib nibWithNibName:name bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:name];
}

@end







