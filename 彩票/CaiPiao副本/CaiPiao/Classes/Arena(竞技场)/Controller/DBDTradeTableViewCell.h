//
//  DBDTradeTableViewCell.h
//  CaiPiao
//
//  Created by Mac on 17/3/18.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  labelTag ： 0-9 label 为 1000-1009
 *  期号 labelTag : 1020
 */
#define LabelTag 1000
#define PeriodTag 1020
#define CellHeight 40
typedef void(^PointBlock)(CGPoint selectPoint);
@class DBDTradeCellModel;
@interface DBDTradeTableViewCell : UITableViewCell
/**
 *  cell 数据 模型
 */
@property (nonatomic, strong) DBDTradeCellModel *dataModel;

+ (instancetype)tradeTableViewCellWithPointBlock:(PointBlock)pointBlock;
@end
