//
//  DBDHomeCollectionViewCell.m
//  DBDMeiZi
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "DBDHomeCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <UIImageView+WebCache.h>
@interface DBDHomeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *bgImgV;
@end
@implementation DBDHomeCollectionViewCell

/**
 *  懒加载 添加 背景 view
 *  由于不知道 什么时候 添加好，因此使用 懒加载
 */
- (UIImageView *)bgImgV{
    if (!_bgImgV) {
        _bgImgV = [[UIImageView alloc] init];
        [self addSubview:_bgImgV];
        [_bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(self);
        }];
    }
    return _bgImgV;
}
/**
 *  设置数据的时候，懒加载 背景 view
 *
 *  @param urlStr 图片url地址
 */
- (void)setUrl:(NSURL *)url{
    _url = url;
    [self.bgImgV sd_setImageWithURL:url placeholderImage:nil];
}
@end
