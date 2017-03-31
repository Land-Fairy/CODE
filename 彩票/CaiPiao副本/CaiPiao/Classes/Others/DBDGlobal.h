//
//  DBDGlobal.h
//  CaiPiao
//
//  Created by 高凯轩 on 2017/3/17.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  0 表示 不加载 Web页面
 *  1 表示 加载 Web 页面
 */
typedef NS_ENUM(NSInteger,NeedShowWeb){
    NeedShowWebNo = 0,
    NeedShowWebYes
};

@interface DBDGlobal : NSObject

/**
 *  是否加载 web 页面
 */
@property (nonatomic, assign) BOOL isShowWeb;
/**
 *  web页面url
 */
@property (nonatomic, strong) NSString *weburl;


/**
 *  单例
 */
+ (DBDGlobal *)sharedManager;
@end
