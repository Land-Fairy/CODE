//
//  DBDTradView.m
//  CaiPiao
//
//  Created by Mac on 17/3/18.
//  Copyright © 2017年 ggg. All rights reserved.
//

#import "DBDTradView.h"
#import "DBDTradeTableViewCell.h"
#import "DBDTradeCellModel.h"
@interface DBDTradView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/**
 *  数据
 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/**
 *  数据显示个数
 */
@property (nonatomic, assign) NSInteger showDataCount;
/**
 *  需要绘制的点的数据
 */
@property (nonatomic, strong) NSMutableArray *pointArray;

@end
@implementation DBDTradView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSValue *value = nil;
    CGPoint pos = CGPointZero;
    for (int i=0; i<self.pointArray.count; i++) {
        value = self.pointArray[i];
        pos = [value CGPointValue];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithArcCenter:pos radius:10. startAngle:0 endAngle:M_PI*2 clockwise:YES];
        [[UIColor redColor] set];
        [roundPath fill];
        if (i == 0) {
            [path moveToPoint:pos];
        }
        else{
            [path addLineToPoint:pos];
        }
    }
    [path setLineWidth:4.];
    [path setLineJoinStyle:kCGLineJoinRound];
    [[UIColor redColor] set];
    [path stroke];
}
//- (void)drawRect:(CGRect)rect {
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    NSValue *value = nil;
//    CGPoint pos = CGPointZero;
//    NSInteger i = self.pointArray.count - self.dataArray.count;
//    for (; i<self.pointArray.count; i++) {
//        value = self.pointArray[i];
//        pos = [value CGPointValue];
//        UIBezierPath *roundPath = [UIBezierPath bezierPathWithArcCenter:pos radius:10. startAngle:0 endAngle:M_PI*2 clockwise:YES];
//        [[UIColor redColor] set];
//        [roundPath fill];
//        if (i == self.dataArray.count) {
//            [path moveToPoint:pos];
//        }
//        else{
//            [path addLineToPoint:pos];
//        }
//    }
//    [path setLineWidth:4.];
//    [path setLineJoinStyle:kCGLineJoinRound];
//    [[UIColor redColor] set];
//    [path stroke];
//}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self generateData];
        /**
           *  添加 tableview
           */
        [self setUpTableView];
    }
    return self;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)pointArray{
    if (!_pointArray) {
        _pointArray = [NSMutableArray array];
    }
    return _pointArray;
}

/**
 *  生成数据
 */
- (void)generateData{
    NSInteger period = 20170105;
    NSString *sGamePeriod = nil;
    NSInteger iOpenNum = 0;
    NSArray *numArray = nil;
    NSInteger randomValue = 0;
    for (int i = 0; i<10; i++) {
        sGamePeriod = [NSString stringWithFormat:@"%ld",(long)period++];
        iOpenNum = arc4random_uniform(9);
        NSMutableArray *randArray = [NSMutableArray array];
        for (int j=0; j<10; j++) {
            randomValue = arc4random_uniform(50);
            [randArray addObject:[NSString stringWithFormat:@"%ld",(long)randomValue]];
        }
        numArray = [randArray copy];
        
        DBDTradeCellModel *model = [DBDTradeCellModel tradeCellModelWithPeriod:sGamePeriod openNum:iOpenNum andNumArray:numArray];
        [self.dataArray addObject:model];
    }
}

/**
 *  添加 tableview
 */
- (void)setUpTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.bounces = NO;
    [self addSubview:tableView];
    self.showDataCount = tableView.bounds.size.height/CellHeight;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return MIN(self.dataArray.count, self.showDataCount);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"DBDTradeTableViewCell";
    DBDTradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [DBDTradeTableViewCell tradeTableViewCellWithPointBlock:^(CGPoint selectPoint) {
            NSValue *value = [NSValue valueWithCGPoint:selectPoint];
            if (self.pointArray.count == MIN(self.dataArray.count, self.showDataCount)) {
                [self.pointArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0]];
                [self.pointArray addObject:value];
                [self setNeedsDisplay];
            }
            else{
                [self.pointArray addObject:value];
            }
        }];
    }
    DBDTradeCellModel *model = self.dataArray[indexPath.row];
    model.lineIndex = indexPath.row;
    cell.dataModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  CellHeight;
}
@end
