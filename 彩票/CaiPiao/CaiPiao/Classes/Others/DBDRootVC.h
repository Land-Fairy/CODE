//
//  DBDRootVC.h
//  CaiPiao
//
//  Created by 高凯轩 on 2017/3/17.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DBDGlobal.h"
@interface DBDRootVC : NSObject
/**
 *  返回 根 控制器
 */
+ (UIViewController *)chooseRootVCforWindowWithShowWeb:(NeedShowWeb)needShowWeb;
@end
