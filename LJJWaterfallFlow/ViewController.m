//
//  ViewController.m
//  LJJWaterfallFlow
//
//  Created by peony on 2018/6/21.
//  Copyright © 2018年 peony. All rights reserved.
//

#import "ViewController.h"
#import "LJJWaterfallFlowViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *rowSpace;
@property (weak, nonatomic) IBOutlet UITextField *columnSpace;
@property (weak, nonatomic) IBOutlet UITextField *columnCount;

@property (weak, nonatomic) IBOutlet UITextField *top;
@property (weak, nonatomic) IBOutlet UITextField *left;
@property (weak, nonatomic) IBOutlet UITextField *bottom;
@property (weak, nonatomic) IBOutlet UITextField *right;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startButtonClick:(id)sender {
    [self start];
}

- (void)start{
    float rs = [self.rowSpace.text floatValue];
    if (rs == 0.0) {
        rs = 5.0;
    }
    NSString *rowSpace = [NSString stringWithFormat:@"%f",rs];
    float cs = [self.columnSpace.text floatValue];
    if (cs == 0.0) {
        cs = 5.0;
    }
    NSString *columnSpace = [NSString stringWithFormat:@"%f",cs];
    NSInteger co = [self.columnCount.text integerValue];
    if (co == 0) {
        co = 3;
    }
    NSString *columnCount = [NSString stringWithFormat:@"%ld",co];
    NSString *top = [NSString stringWithFormat:@"%.2f",[self.top.text floatValue]];
    NSString *left = [NSString stringWithFormat:@"%.2f",[self.left.text floatValue]];
    NSString *bottom = [NSString stringWithFormat:@"%.2f",[self.bottom.text floatValue]];
    NSString *right = [NSString stringWithFormat:@"%.2f",[self.right.text floatValue]];
    
    __weak typeof(self) weakSelf = self;
    LJJWaterfallFlowViewController *VC = [[LJJWaterfallFlowViewController alloc] init];
    
    VC.infoBlock = ^id{
        NSDictionary *dic = @{@"rowSpace" : rowSpace, @"columnSpace" : columnSpace, @"columnCount" : columnCount, @"top" : top, @"left" : left, @"bottom" : bottom, @"right" : right};
        return dic;
    };
    
    [self.navigationController pushViewController:VC animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
