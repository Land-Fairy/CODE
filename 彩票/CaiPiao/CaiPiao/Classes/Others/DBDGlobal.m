//
//  DBDGlobal.m
//  CaiPiao
//
//  Created by 高凯轩 on 2017/3/17.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "DBDGlobal.h"

@implementation DBDGlobal
+ (DBDGlobal *)sharedManager
{
    static DBDGlobal *globalInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalInstance = [[self alloc] init];
    });
    return globalInstance;
}
@end
