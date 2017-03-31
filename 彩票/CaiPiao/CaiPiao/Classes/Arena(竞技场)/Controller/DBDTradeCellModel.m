//
//  DBDTradeCellModel.m
//  CaiPiao
//
//  Created by Mac on 17/3/18.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "DBDTradeCellModel.h"

@implementation DBDTradeCellModel
+ (instancetype)tradeCellModelWithPeriod:(NSString *)sGamePeriod openNum:(NSInteger)iOpenNum andNumArray:(NSArray *)numArray{
    DBDTradeCellModel *model = [[DBDTradeCellModel alloc] init];
    model.sGamePeriod = sGamePeriod;
    model.iOpenNum = iOpenNum;
    model.numArray = numArray;
    return model;
}
@end
