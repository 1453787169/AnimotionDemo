//
//  PushViewController.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/28.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "PushViewController.h"
#import "PushTransition.h"
#import "PopTransition.h"
#import "PopViewController.h"
#import "PopInteractiveTransition.h"

@interface PushViewController ()<UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>{
    PopInteractiveTransition *popInteractive;
}

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
}

//-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    if (operation == UINavigationControllerOperationPush) {
//        PushTransition *push = [PushTransition new];
//        return push;
//    }else if (operation == UINavigationControllerOperationPop){
//        PopTransition *pop = [PopTransition new];
//        return pop;
//    }else{
//        return nil;
//    };
//}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        PushTransition *push = [PushTransition new];
        return push;
    }else if(operation == UINavigationControllerOperationPop){
        PopTransition *pop = [PopTransition new];
        return pop;
    }else{
        return nil;
    }
 
    
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return popInteractive.interacting ? popInteractive : nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    PopViewController *popVC = (PopViewController *)segue.destinationViewController;
    popVC.transitioningDelegate = self;
    popInteractive  = [PopInteractiveTransition new];
    [popInteractive addPopGesture:popVC];
}


@end
