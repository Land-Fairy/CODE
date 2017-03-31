//
//  ViewController.m
//  DrawBoard
//
//  Created by Mac on 17/3/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
typedef NS_ENUM(NSInteger, ClickedBut){
    ClickedButRed = 100,
    ClickedButBlack,
    ClickedButGreen
};
@interface ViewController ()
@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  切换颜色
 */
- (IBAction)colorButClcked:(UIButton *)sender {
    if (sender.tag == ClickedButRed) {
        self.drawView.currColor = [UIColor redColor];
    }
    else if(sender.tag == ClickedButBlack){
        self.drawView.currColor = [UIColor blackColor];
    }
    else{
        self.drawView.currColor = [UIColor greenColor];
    }
}
/**
 *  slider  滑动
 */
- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.drawView.currLineWidth = sender.value;
}
/**
 *  清屏
 */
- (IBAction)clearScreen:(UIBarButtonItem *)sender {
    [self.drawView clearScreen];
}

/**
 *  撤销
 */
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}


/**
 *  橡皮擦
 */
- (IBAction)erase:(UIBarButtonItem *)sender {
    [self.drawView erase];
}

- (IBAction)save:(UIBarButtonItem *)sender {
}

- (IBAction)pic:(UIBarButtonItem *)sender {
}

@end
