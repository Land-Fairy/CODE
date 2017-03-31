//
//  DBDHomeCellModel.h
//  DBDMeiZi
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBDHomeCellModel : NSObject
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, strong) NSURL *imageUrl;
+ (instancetype)homeCellModelWithThumbUrl:(NSString *)thumbUrl andImageUrl:(NSString *)imageUrl;
@end
