//
//  PopInteractiveTransition.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/28.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "PopInteractiveTransition.h"

@interface PopInteractiveTransition (){
    UIViewController *presentedVC;
}

@end


@implementation PopInteractiveTransition

//给目标视图控制器添加一个边缘华东手势
- (void)addPopGesture:(UIViewController *)viewController{
    presentedVC = viewController;
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgeGesPan:)];
    edgeGes.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:edgeGes];
}

- (void)edgeGesPan:(UIScreenEdgePanGestureRecognizer *)edgePan{
    CGFloat translation = [edgePan translationInView:presentedVC.view].x;
    CGFloat percent = translation / presentedVC.view.bounds.size.width;
    percent = MIN(0.99, MAX(0.0, percent));
    
    NSLog(@"percent---%f", percent);
    
    switch (edgePan.state) {
        case UIGestureRecognizerStateBegan:{
            self.interacting = YES;
            [presentedVC.navigationController popViewControllerAnimated:YES];
            break;}
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:percent];
            break;}
        case UIGestureRecognizerStateEnded:{
            self.interacting = NO;
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;}
            
        default:
            break;
    }
    
}

@end
