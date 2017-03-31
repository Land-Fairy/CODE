//
//  DBDTradeCellModel.h
//  CaiPiao
//
//  Created by Mac on 17/3/18.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBDTradeCellModel : NSObject
/**
 *  开奖 其号
 */
@property (nonatomic, strong) NSString *sGamePeriod;
/**
 *  开奖序号
 */
@property (nonatomic, assign) NSInteger iOpenNum;
/**
 *  10 个开奖 号码
 */
@property (nonatomic, strong) NSArray *numArray;

/**
 *  cell所在的行
 */
@property (nonatomic, assign) NSInteger lineIndex;
/**
 *  快速创建方法
 */
+ (instancetype)tradeCellModelWithPeriod:(NSString *)sGamePeriod openNum:(NSInteger)iOpenNum andNumArray:(NSArray *)numArray;
@end
