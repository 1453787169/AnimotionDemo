//
//  ViewController.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/22.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SDExtension.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *demoView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}





#pragma mark - 华丽丽的分割线，基础动画

//位移
- (IBAction)pressPositionAnimotion:(id)sender {
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(500, 260)];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //加上下面这两个fillMode=kCAFillModeForwards,removedOnCompletion=NO,之后，图层会保持显示动画执行后的状态，但是实质上，图层的属性值还是动画执行前的初始值，并没有真正的改变
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
    [_demoView.layer addAnimation:animation forKey:@"position"];
    //动画属性的改变：backgroundColor,opacity,transform.rotation.x,transform.scale
    
    
}

/**
 *  背景色 *
 *  @param sender 
 */
- (IBAction)pressBackgroundAnimotion:(id)sender {
    CABasicAnimation *animotion = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animotion.toValue = (id)[UIColor redColor].CGColor;
    animotion.duration = 1.0;
    [_demoView.layer addAnimation:animotion forKey:@"backGroundColorAnimotion"];
}


//修改透明度 ,这里不能用 alphe,只能用opacity
- (IBAction)pressOpacityAnimotion:(id)sender {
    CABasicAnimation *animotion = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animotion.fromValue = [NSNumber numberWithFloat:1.0];
    animotion.toValue = [NSNumber numberWithFloat:0.1f];
    animotion.duration = 2.0;
    [_demoView.layer addAnimation:animotion forKey:@"opacityAnimotion"];
}


//缩放或者扩大
- (IBAction)pressScaleAnimotion:(id)sender {
    CABasicAnimation *animotion = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animotion.fromValue = [NSNumber numberWithInt:0.5];
    animotion.toValue = [NSNumber numberWithInt:2.0];
    animotion.duration = 3.0;
    [_demoView.layer addAnimation:animotion forKey:@"transform.scale.animotion"];
}


- (IBAction)pressRotationButton:(id)sender {    
    CABasicAnimation *animotion = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animotion.toValue = [NSNumber numberWithFloat:M_PI];
    animotion.duration = 2.0;
    [_demoView.layer addAnimation:animotion forKey:@"transformAnomoiton"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
