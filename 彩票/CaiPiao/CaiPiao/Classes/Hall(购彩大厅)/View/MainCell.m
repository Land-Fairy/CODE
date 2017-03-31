//
//  GoodsListCell.m
//  Gou9
//
//  Created by gkm on 16/7/11.
//  Copyright © 2016年 gkm. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self iniData];
    }
    return self;
}
- (void)iniData{
    _Ima = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-0.6, self.frame.size.height-0.6)];
    _Ima.backgroundColor = [UIColor redColor];
    [self addSubview:self.Ima];
    
}
- (void)getCell:(NSString *)str{
    _Ima.image  = [UIImage imageNamed:str];
}
@end
