//
//  DBDTradeTableViewCell.m
//  CaiPiao
//
//  Created by Mac on 17/3/18.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "DBDTradeTableViewCell.h"
#import "DBDTradeCellModel.h"

@interface DBDTradeTableViewCell()
/**
 *  返回 该cell中 选中 点的  中心 位置
 */
@property (nonatomic, copy)PointBlock pointBlock;
@end

@implementation DBDTradeTableViewHeader


/**
 *  快速创建 header方法
 */
+ (instancetype)tradeTableViewHeader{
    DBDTradeTableViewHeader *header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DBDTradeTableViewCell class]) owner:nil options:nil] lastObject];
    header.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CellHeight);
    return header;
}
@end

@implementation DBDTradeTableViewCell


/**
 *  快速创建 cell 方法
 */
+ (instancetype)tradeTableViewCellWithPointBlock:(PointBlock)pointBlock{
    DBDTradeTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DBDTradeTableViewCell class]) owner:nil options:nil] firstObject];
    cell.pointBlock = pointBlock;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CellHeight);
    return cell;
}



/**
 *  设置 数据 set方法
 */
- (void)setDataModel:(DBDTradeCellModel *)dataModel{
    _dataModel = dataModel;
    /*** 子控件 存放在 contentView ***/
    UIView *contentView = self.contentView;
    NSInteger count = contentView.subviews.count;
    NSInteger iOpenNum = dataModel.iOpenNum;
    for (int i =0; i<count; i++) {
        NSInteger diffValue = contentView.subviews[i].tag - LabelTag;
        
        /*** 如果 是 0-9 这几个 label **/
        if (diffValue >= 0 && diffValue < 10 && diffValue <= dataModel.numArray.count) {
            UILabel *label = contentView.subviews[i];
            /*****  如果是选中 label，则显示 序号  ****/
            if (iOpenNum == diffValue) {
                label.text = [NSString stringWithFormat:@"%li",(long)iOpenNum];
            }
            else{
                label.text = dataModel.numArray[diffValue];
            }
        }
        else if (diffValue == 20){
            UILabel *label = contentView.subviews[i];
            label.text = dataModel.sGamePeriod;
        }
    }
    
    [self layoutIfNeeded];
}
/**
 *  布局 子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];

    UIView *contentView = self.contentView;
    NSInteger count = contentView.subviews.count;
    NSInteger iOpenNum = self.dataModel.iOpenNum;
    for (int i =0; i<count; i++) {
        NSInteger diffValue = contentView.subviews[i].tag - LabelTag;
        
        /*** 如果 是 0-9 这几个 label **/
        if (diffValue >= 0 && diffValue < 10 && diffValue <=self.dataModel.numArray.count) {
            UILabel *label = contentView.subviews[i];
            if (diffValue == iOpenNum) {
                CGPoint pos = label.center;
                /*** 根据cell所在 行，返回坐标 **/
                pos.y += self.dataModel.lineIndex * CellHeight ;
                self.pointBlock(pos);
            }
        }
    }
}

/**
 *  不可被 选中，不可被点击
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
//    
//}

@end
