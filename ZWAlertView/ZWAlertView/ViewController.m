//
//  ViewController.m
//  ZWAlertView
//
//  Created by MyMac on 11/15/15.
//  Copyright (c) 2015 sanzhimayi. All rights reserved.
//

#import "ViewController.h"
#import "ZWAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /****************The following are an example ******************/
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [customBtn setFrame:CGRectMake(100, 200, 120, 30)];
    [customBtn setTitle:@"show model 1" forState:UIControlStateNormal];
    [customBtn addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customBtn];
    
    customBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [customBtn setFrame:CGRectMake(100, 250, 120, 30)];
    [customBtn setTitle:@"show model 1" forState:UIControlStateNormal];
    [customBtn addTarget:self action:@selector(showAlertView2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customBtn];
}

- (void)showAlertView {
    ZWAlertView *alertView = [[ZWAlertView alloc] initWithTitle:@"提示" message:@"自定义AletView" buttonTitles:@[@"确定", @"取消"] directionForButtons:CustomButtonDirectionHorizontal callBackBlock:^(ZWAlertView *alertView, NSInteger buttonClickedIndex) {
        if (buttonClickedIndex == 1) {
            [alertView dismiss];
        }
    }];
    [alertView show];
}

- (void)showAlertView2 {
    ZWAlertView *alertView = [[ZWAlertView alloc] initWithTitle:@"提示" message:@"自定义AletView" buttonTitles:@[@"确定", @"取消"] directionForButtons:CustomButtonDirectionVertical callBackBlock:^(ZWAlertView *alertView, NSInteger buttonClickedIndex) {
        if (buttonClickedIndex == 1) {
            [alertView dismiss];
        }
    }];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
