//
//  TestViewController.m
//  下拉手势退出
//
//  Created by 处光夫 on 2018/12/11.
//  Copyright © 2018 处光夫. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat imgScale;//图片的宽高比
@property (nonatomic, assign) BOOL isPullDown;//是否向下拖拽过，默认为NO
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = [UIImage imageNamed:@"qwerdf"];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    
//    //轻扫手势
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFunction:)];
//    swipe.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
//    swipe.delegate = self;
//    [self.view addGestureRecognizer:swipe];
    
    //轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFunction:)];
    [self.imageView addGestureRecognizer:tap];
    
    //拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFunction:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    self.imgScale = CGRectGetWidth(self.imageView.frame) / CGRectGetHeight(self.imageView.frame);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //是否支持多手势触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
    //NSLog(@"gestureRecognizer---%@    otherGestureRecognizer---%@",gestureRecognizer,otherGestureRecognizer);
    return YES;
}

#pragma mark 轻扫手势响应
-(void)swipeFunction:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"不是向下扫了");
}

#pragma mark 点按手势响应
-(void)tapFunction:(UITapGestureRecognizer *)tap {
    NSLog(@"点按手势响应");
}

#pragma mark 拖拽手势响应
-(void)panFunction:(UIPanGestureRecognizer *)pan {
    //获取到的是手指着手点作为相对坐标的原点的偏移量
    CGPoint transPoint = [pan translationInView:self.view];
    //NSLog(@"transViewPoint: x--%f  y--%f",transPoint.x,transPoint.y);
    
    if (transPoint.y > 0) {
        self.isPullDown = YES;
    }
    
    if (!self.isPullDown) {
        return;
    }
    
    CGRect tempRect = self.imageView.frame;
    
    tempRect.origin.y = transPoint.y;
    tempRect.size.height = CGRectGetHeight(self.view.frame) - transPoint.y;
    tempRect.size.width = tempRect.size.height * self.imgScale;
    tempRect.origin.x = (CGRectGetWidth(self.view.frame) - tempRect.size.width) / 2.0 + transPoint.x;
    
    self.imageView.frame = tempRect;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (transPoint.y > 250) {
            [self dismiss];
        }else {
            self.isPullDown = NO;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect temp = self.imageView.frame;
                temp.origin = CGPointZero;
                temp.size = self.view.bounds.size;
                self.imageView.frame = temp;
            }];
        }
    }
    
}

-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    //这个方法返回YES，第一个手势和第二个互斥时，第一个会失效
//    return YES;
//}
//
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    //这个方法返回YES，第一个和第二个互斥时，第二个会失效
//    return NO;
//}

@end
