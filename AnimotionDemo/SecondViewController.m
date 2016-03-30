//
//  SecondViewController.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/22.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "SecondViewController.h"
#import "UIView+SDExtension.h"


#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height

@interface SecondViewController ()

@property (strong, nonatomic) IBOutlet UIView *demoView;




@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




#pragma mark - 正经的分割线-------关键帧动画


//关键帧动画
- (IBAction)pressKeysButton:(id)sender {
    CAKeyframeAnimation *keyAnimotion = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(0, self.view.sd_height / 2.0 - 50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(400, 200)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(400, 400)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(100, 500)];
    NSValue *value7 = [NSValue valueWithCGPoint:CGPointMake(400, 600)];
    keyAnimotion.delegate = self;
    keyAnimotion.duration = 6.0;
    keyAnimotion.values = @[value1, value2, value3, value4, value5, value6, value7 ];
    keyAnimotion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_demoView.layer addAnimation:keyAnimotion forKey:@"positionAnimotion"];
}

//路径动画
- (IBAction)pressKeypathButton:(id)sender {
    
    CAKeyframeAnimation *animotion = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH / 2.0 - 200, SCREEN_HEIGHT / 2.0 - 200, 400, 400)];
    animotion.path = path.CGPath;
    animotion.duration = 2.0;
    [_demoView.layer addAnimation:animotion forKey:@"positionAnimation"];
    
}

//抖动动画
- (IBAction)pressShakeButton:(id)sender {
    CAKeyframeAnimation *animotion = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animotion.repeatCount = MAXFLOAT;
    NSValue *value1 = [NSNumber numberWithFloat:M_PI /  30];
    NSValue *value2 = [NSNumber numberWithFloat:-M_PI / 30];
    animotion.values = @[value1, value2];
    [_demoView.layer addAnimation:animotion forKey:@"shakeAnimotion"];
}



- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画开始");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画结束");
}


#pragma mark - 正经的分割线 ----- 组动画



- (IBAction)pressSameButton:(UIButton *)sender {
    CAKeyframeAnimation *keyAnimotion1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(0, self.view.sd_height / 2.0 - 50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(400, 200)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(400, 400)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(100, 500)];
    NSValue *value7 = [NSValue valueWithCGPoint:CGPointMake(400, 600)];
    keyAnimotion1.delegate = self;
//    keyAnimotion1.duration = 6.0;
    keyAnimotion1.values = @[value1, value2, value3, value4, value5, value6, value7 ];
    keyAnimotion1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *animotion2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animotion2.fromValue = [NSNumber numberWithInt:0.5];
    animotion2.toValue = [NSNumber numberWithInt:2.0];
//    animotion2.duration = 3.0;
    [_demoView.layer addAnimation:animotion2 forKey:@"transform.scale.Animotion"];
    
    CABasicAnimation *animotion3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animotion3.fromValue = [NSNumber numberWithFloat:1.0];
    animotion3.toValue = [NSNumber numberWithFloat:0.1f];
//    animotion3.duration = 2.0;
    [_demoView.layer addAnimation:animotion3 forKey:@"opacityAnimotion"];
    
    CAAnimationGroup *animotionGrop = [CAAnimationGroup animation];
    animotionGrop.animations = @[keyAnimotion1, animotion2, animotion3];
    animotionGrop.duration = 5.0;
    [_demoView.layer addAnimation:animotionGrop forKey:@"groupAnimotion"];    
}


- (IBAction)pressContinueButton:(UIButton *)sender {
    CFTimeInterval currentTime = CACurrentMediaTime();
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 260)];
    animation.beginTime = currentTime;
    animation.duration = 1.0;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //加上下面这两个fillMode=kCAFillModeForwards,removedOnCompletion=NO,之后，图层会保持显示动画执行后的状态，但是实质上，图层的属性值还是动画执行前的初始值，并没有真正的改变
    //    animation.fillMode = kCAFillModeForwards;
    //    animation.removedOnCompletion = NO;
    [_demoView.layer addAnimation:animation forKey:@"position"];
    
    CABasicAnimation *animotion2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animotion2.fromValue = [NSNumber numberWithFloat:1.0];
    animotion2.toValue = [NSNumber numberWithFloat:0.1f];
    animotion2.beginTime = currentTime + 1.0;
    animation.duration = 2.0;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_demoView.layer addAnimation:animotion2 forKey:@"opacityAnimotion"];

    
    CABasicAnimation *animotion3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animotion3.toValue = [NSNumber numberWithFloat:M_PI];
    animotion3.duration = currentTime + 3.0;
    animotion3.duration = 2.0;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_demoView.layer addAnimation:animotion3 forKey:@"transformAnomoiton"];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
