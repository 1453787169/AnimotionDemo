//
//  AffineTransformViewController.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/23.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "AffineTransformViewController.h"

@interface AffineTransformViewController ()

@property (strong, nonatomic) IBOutlet UIView *demoView;



@end

@implementation AffineTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  位移
 */
- (IBAction)pressDisplacementButton:(id)sender{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0 animations:^{
        _demoView.transform = CGAffineTransformMakeTranslation(100, 100);
        }];
}

/**
 *  缩放
 */
- (IBAction)pressScaleButton:(id)sender {
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0 animations:^{
        _demoView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    }];
    
    _demoView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
  
}




/**
 *  旋转
 */
- (IBAction)pressRotationButton:(id)sender{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0 animations:^{
        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

/**
 *   组合
 */
- (IBAction)pressGruopButton:(id)sender {
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transForm1 = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform transForm2 = CGAffineTransformScale(transForm1, 0.1, 0.1);
        _demoView.transform = CGAffineTransformTranslate(transForm2, 100, 200);
    }];
}


/**
 *  反转
 */
- (IBAction)pressInvertButton:(id)sender {
    
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0 animations:^{
        _demoView.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(0.7, 0.7));
    }];
    
    
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
