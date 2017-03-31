//
//  DBDHomeCellModel.m
//  DBDMeiZi
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "DBDHomeCellModel.h"

@implementation DBDHomeCellModel
+ (instancetype)homeCellModelWithThumbUrl:(NSString *)thumbUrl andImageUrl:(NSString *)imageUrl{
    DBDHomeCellModel *cell = [[DBDHomeCellModel alloc] init];
    cell.thumbUrl = [NSURL URLWithString:thumbUrl];
    cell.imageUrl = [NSURL URLWithString:imageUrl];
    return cell;
}
@end
