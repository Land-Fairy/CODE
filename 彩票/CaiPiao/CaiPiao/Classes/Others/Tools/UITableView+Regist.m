//
//  UITableView+Regist.m
//  ChatBubble
//
//  Created by on 16/1/4.
//  Copyright © 2016年 . All rights reserved.
//

#import "UITableView+Regist.h"

@implementation UITableView (Regist)

- (void)zy_registNibCell:(Class)aClass {
    NSString *str = NSStringFromClass(aClass);
    [self registerNib:[UINib nibWithNibName:str bundle:nil] forCellReuseIdentifier:str];
}
- (void)zy_registClassCell:(Class)aClass {
    [self registerClass:aClass forCellReuseIdentifier:NSStringFromClass(aClass)];
}

@end