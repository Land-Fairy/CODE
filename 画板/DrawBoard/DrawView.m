//
//  DrawView.m
//  DrawBoard
//
//  Created by Mac on 17/3/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "DrawView.h"
#import "DBDBezierPath.h"
@interface DrawView()
/**
 *  当前 路径
 */
@property (nonatomic, strong) DBDBezierPath *currPath;
/**
 *  已经 保存 的路径
 */
@property (nonatomic, strong) NSMutableArray<DBDBezierPath *> *pathArray;
@end
@implementation DrawView
/**
 *  懒加载方法
 */
- (UIBezierPath *)currPath{
    if (!_currPath) {
        _currPath = [DBDBezierPath bezierPath];
    }
    return _currPath;
}

- (NSMutableArray<DBDBezierPath *> *)pathArray{
    if(!_pathArray){
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UIPanGestureRecognizer *pangeSture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:pangeSture];
    
    /**
     *  设置 颜色 和 线宽 的默认值
     */
    self.currLineWidth = 1;
    self.currColor = [UIColor blackColor];
    
}

- (void)panGesture:(UIPanGestureRecognizer *)pan{
    static CGPoint startP = {0,0};
    static CGPoint currP = {0,0};
    if (pan.state == UIGestureRecognizerStateBegan) {
        startP = [pan locationInView:self];
        /**
           *  每次手指 移动 刚开始的时候，重设  当前 路径
           *  开始 时，移动到 本次路径 起点
           *  保存 此路径 绘画 时的 线宽 和 颜色
           *  由于 颜色 没法 直接 存储 在 UIBezierPath 类型中：
           *  这里，自定义了一个 DBDBezierPath类型，用于 存放  颜色
           *  也可以 用一个 字典 保存 path 和 颜色，存储字典 即可
           */
        [self.currPath moveToPoint:startP];
        self.currPath.lineWidth = self.currLineWidth;
        self.currPath.currColor = self.currColor;
    }
    else if (pan.state == UIGestureRecognizerStateChanged){
        currP = [pan locationInView:self];
        /**
           *  每次手指移动时，将 当前点 加入到 当前 路径
           *  重 绘
           */
        [self.currPath addLineToPoint:currP];
        [self setNeedsDisplay];
    }
    else if (pan.state == UIGestureRecognizerStateEnded){
        /**
           *  每次 手指 移动结束，代表着 一个路径 完成
           *  将 当前路径 添加 到 已 绘制 路径中去
           */
        [self.pathArray addObject:self.currPath];
        self.currPath = nil;
    }
}

- (void)drawRect:(CGRect)rect {
    /**
     *  首先 绘制 前面已保存 的 路径
     */
    for (int i=0; i<self.pathArray.count; i++) {
        DBDBezierPath *path = self.pathArray[i];
        [path.currColor set];
        [path stroke];
    }
    /**
     *   绘制  当前 路径
     */
    [self.currPath.currColor set];
    [self.currPath stroke];
}

/**
 *  橡皮擦
 */
- (void)erase{
    self.currColor = [UIColor whiteColor];
}
/**
 *  撤销
 */
- (void)undo{
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}
/**
 *  清屏
 */
- (void)clearScreen{
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}
@end
