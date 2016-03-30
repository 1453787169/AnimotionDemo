//
//  PopTransition.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/28.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "PopTransition.h"

@implementation PopTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //通过上下文transitionContext获得前后两个view,也是发生动画的具体对象
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    //containerView 就是动画发生的地方，我们需要把后一个视图添加上去，为了保证后一个视图加上去之后不遮住前一个视图的动画，我们还要把后一个视图放到最后
    UIView *contentView = [transitionContext containerView];
    [contentView addSubview:toView];
    
    //增加透视的transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    contentView.layer.sublayerTransform = transform;
    
    //给fromVC和toVC分别设置相同的起始的frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    //改变view的锚点
    [self updateAnchorPointAndOffset:CGPointMake(0.0, 0.5) view:toView];
    
    //让toView的截图旋转90度
    //保证视图产生的3D效果，我们需要设置layer的仿射变换
    //向外旋转，表示-M_PI,1.0表示绕着Y轴旋转
    toView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0.0, 1.0, 0.0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //旋转fromView90度
        toView.layer.transform = CATransform3DMakeRotation(0, 0, 1.0, 0);
    } completion:^(BOOL finished) {
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
//        [transitionContext com];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
    
}

//给传入的view改变锚点
- (void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view{
    view.layer.anchorPoint = anchorPoint;
    view.layer.position = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
}

@end
