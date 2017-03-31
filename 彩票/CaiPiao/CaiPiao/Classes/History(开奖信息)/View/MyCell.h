//
//  MyCell.h
//  FirstVC
//
//  Created by mac on 2017/3/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *numLabel;
@property(nonatomic,strong)NSMutableArray *labelArray;
@property(nonatomic,strong)NSMutableArray *buttonArray;
- (void)getCell:(NSDictionary *)dic;
@end
