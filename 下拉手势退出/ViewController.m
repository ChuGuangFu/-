//
//  ViewController.m
//  下拉手势退出
//
//  Created by 处光夫 on 2018/12/11.
//  Copyright © 2018 处光夫. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)buttonClick:(UIButton *)sender {
    TestViewController *vc = [[TestViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
