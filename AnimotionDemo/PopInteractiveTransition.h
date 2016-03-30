//
//  PopInteractiveTransition.h
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/28.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

//给目标视图控制器添加一个边缘滑动手势
- (void)addPopGesture:(UIViewController *)viewController;

@end
