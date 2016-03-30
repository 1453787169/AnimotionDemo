//
//  BezierViewController.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/24.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "BezierViewController.h"
#import "BezierView.h"

@interface BezierViewController ()


@end

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BezierView *bezierView = [[BezierView alloc] initWithFrame:self.view.bounds];
    bezierView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bezierView];
    
   
    
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
