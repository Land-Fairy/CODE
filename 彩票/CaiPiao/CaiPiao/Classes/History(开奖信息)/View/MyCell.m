


//
//  MyCell.m
//  FirstVC
//
//  Created by mac on 2017/3/18.
//  Copyright © 2017年 mac. All rights reserved.
//
#define Lable(lab, text, textColor, textAlignment, font,line)\
\
[lab setText: text];\
[lab setTextColor: textColor];\
[lab setTextAlignment: textAlignment];\
[lab setFont: font];\
[lab setNumberOfLines: line]


//主颜色
#define SystemColor RGB(240,239,247)
#define MainColor RGB(46,166,211)
#define MainBlackColor RGB(48,48,48)
#define MainGrayColor RGB(209,209,209)
#define BackGrayColor RGB(247,247,247)//背景灰
#define FontGrayColor RGB(141,141,141)
#define OrangeColor RGB(244,169,49)//c橙色
#define mRedColor RGB(255,106,106)
#define AgeColor RGB(180,197,211)
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGB(r,g,b) RGBACOLOR(r,g,b,1.0f)
#import "MyCell.h"
#import "Masonry.h"
@implementation MyCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initData];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)initData{
    _labelArray = [NSMutableArray array];
    _buttonArray = [NSMutableArray array];
    
    _titleLabel = [UILabel new];
    Lable(_titleLabel, @"标题", [UIColor blackColor],NSTextAlignmentLeft , [UIFont systemFontOfSize:14.f], 1);
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(17);
        make.top.mas_equalTo(self.mas_top).with.offset(5);
        make.width.mas_lessThanOrEqualTo(200);
        
    }];
    
    _numLabel = [UILabel new];
    Lable(_numLabel, @"你好", OrangeColor,NSTextAlignmentLeft , [UIFont systemFontOfSize:14.f], 1);
    [self addSubview:self.numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.titleLabel.mas_right).with.offset(15);
        make.top.mas_equalTo(self.mas_top).with.offset(5);
        make.width.mas_lessThanOrEqualTo(200);
        
    }];
    
    _dateLabel = [UILabel new];
    Lable(_dateLabel, @"完善个人", OrangeColor,NSTextAlignmentLeft , [UIFont systemFontOfSize:14.f], 1);
    [self addSubview:self.dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-17);
        make.top.mas_equalTo(self.mas_top).with.offset(5);
        make.width.mas_lessThanOrEqualTo(200);
        
    }];
    CGFloat x = 50;
    CGFloat y = 50;
    CGFloat width = 30;
    CGFloat height = 30;
    CGFloat jianGe = 10;
    for (int i = 0; i<10; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x+(width+jianGe)*i,y, width, height);
        [button setBackgroundImage: [UIImage imageNamed:@"红色球"] forState:UIControlStateNormal];
        [button setTitle:@"11" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:.15];
        [self addSubview:button];
        UILabel *label = [UILabel new];
        label.frame = button.frame;
        Lable(label, @"11", [UIColor whiteColor],NSTextAlignmentCenter , [UIFont systemFontOfSize:15.f], 1);
        [self addSubview:label];
        label.layer.cornerRadius = height/2;
        [_buttonArray addObject:button];
        [_labelArray addObject:label];
    }
    
}
- (void)getCell:(NSDictionary *)dic{
    NSArray *array = dic[@"rsultArr"];
    for (int i=0; i<array.count; i++) {
        NSDictionary *titleDic = array[i];
        UILabel *label = _labelArray[i];
        UIButton *button = _buttonArray[i];
        label.text = titleDic[[NSString stringWithFormat:@"%d",i]];
    }
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
