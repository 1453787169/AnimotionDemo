//
//  PushTransition.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/28.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "PushTransition.h"
#import "PushViewController.h"
#import "PopViewController.h"
#import "PopInteractiveTransition.h"

@implementation PushTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
  //动画的时间
    return 0.6f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //1.
    //动画的逻辑
    PushViewController *fromVC = (PushViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PopViewController *popVC = (PopViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = popVC.view;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    //2.
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    //3.
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = initialFrame;

    [self updateAnchorPointAndOffset:CGPointMake(0.0, 0.5) view:fromView];
    
    //增加阴影
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = fromView.bounds;
    gradient.colors = @[[UIColor colorWithWhite:0.0 alpha:0.5], [UIColor colorWithWhite:0.0 alpha:0.0]];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(0.8, 0.5);
    
    UIView *shadow = [[UIView alloc] initWithFrame:fromView.bounds];
    shadow.backgroundColor = [UIColor clearColor];
    [shadow.layer insertSublayer:gradient atIndex:1];
    shadow.alpha = 0.0;
    [fromView addSubview:shadow];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //旋转fromView90度
        fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1.0, 0);
        shadow.alpha = 1.0;
    } completion:^(BOOL finished) {
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.layer.position = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        fromView.layer.transform = CATransform3DIdentity;
        [shadow removeFromSuperview];
        [transitionContext completeTransition:YES];
        
    }];
    
    
    
    
}

//给传入的view改变锚点
- (void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view{
    view.layer.anchorPoint = anchorPoint;
    view.layer.position = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
}










@end
