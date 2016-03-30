//
//  TransformViewController.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/23.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController (){
    NSString *str;
}

@property (strong, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, assign) NSInteger index;


@property (strong, nonatomic) IBOutlet UILabel *testLabel;



@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.index = 0;
    [self changeView:YES];
    
    str = @"复制整段信息，打开👉手机天猫👈可直接查看，衬衫女2016春装新款女装上衣韩范雪纺白色学院风潮长袖打底衫衬衣.复制整段信息，打开👉手机天猫👈可直接查看，衬衫女2016春装新款女装上衣韩范雪纺白色学院风潮长袖打底衫衬衣 ";
}



#pragma mark - Button Action

- (IBAction)pressAirBrushButton:(id)sender {
    
    NSThread *thred = [[NSThread alloc] initWithTarget:self selector:@selector(animotionForShowTItleLabelBigLabelText) object:nil];
    [thred start];
}

- (void)animotionForShowTItleLabelBigLabelText{
    for (int i = 0; i < [str length]; i ++) {
        [self performSelectorOnMainThread:@selector(refreUIFortitleLabelBigLabelText:) withObject:[str substringWithRange:NSMakeRange(0, i + 1)] waitUntilDone:YES];
        [NSThread sleepForTimeInterval:0.05f];
    }
}

- (void)refreUIFortitleLabelBigLabelText:(NSString *)str1{
    self.testLabel.text = str1;
}


- (IBAction)pressFadeButton:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade; //设置动画的类型
    animation.subtype = kCATransitionFromRight; //设置动画的方向
//    animation.startProgress = 0.3;
//    animation.endProgress = 0.8;
    animation.duration = 2.0f;
    [_label.layer addAnimation:animation forKey:@"fadeAnimotion"];
}



- (IBAction)pressMoveInButton:(id)sender {
    [self changeView:YES];
    CATransition *animotion = [CATransition animation];
    animotion.type = kCATransitionMoveIn;
    animotion.subtype = kCATransitionFromRight;
    animotion.duration = 2.0;
    [_label.layer addAnimation:animotion forKey:@"moveInAnimotion"];
}


- (IBAction)pressPushButton:(id)sender {
    [self changeView:YES];
    CATransition *animotion = [CATransition  animation];
    animotion.type = kCATransitionPush;
    animotion.subtype = kCATransitionFromRight;
    animotion.duration = 1.0;
    [_label.layer addAnimation:animotion forKey:@"pushAnimotion"];
}


- (IBAction)pressRevealButton:(id)sender {
    [self changeView:YES];
    CATransition *animotion = [CATransition animation];
    animotion.type = kCATransitionReveal;
    animotion.subtype = kCATransitionFromRight;
    [_label.layer addAnimation:animotion forKey:@"revealAnimotion"];
    
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    animotion.subtype = kCATransitionFromBottom;
    [_label.layer addAnimation:animotion forKey:@"revealAnimotion"];
    
}

//立体的翻滚效果
- (IBAction)pressCubeButton:(id)sender {
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"cube";
    transition.duration = 1.0;
    transition.subtype = kCATransitionFromRight;
    [_label.layer addAnimation:transition forKey:@"subeAnimotion"];
}


- (IBAction)pressSuckButton:(id)sender {
    [self changeView:YES];
    CATransition *transition = [CATransition animation];
    transition.type = @"suckEffect";//设置动画的类型
    transition.subtype = kCATransitionFromRight;//设置动画的方向
    transition.duration = 1.0;
    [_label.layer addAnimation:transition forKey:@"suckAnimotion"];
    
}

- (IBAction)pressOglFlip:(id)sender{
    [self changeView:YES];
    CATransition *animotion = [CATransition animation];
    animotion.type = @"oglFlip";
    animotion.subtype = kCATransitionFromRight;
    animotion.duration = 1.0;
    [_label.layer addAnimation:animotion forKey:@"oglFlipEffrct"];
    
}

- (IBAction)pressRippleButton:(id)sender {
    [self changeView:YES];
    CATransition *animotion = [CATransition animation];
    animotion.type = @"rippleEffect";
    animotion.subtype = kCATransitionFromRight;
    animotion.duration = 1.0;
    [_label.layer addAnimation:animotion forKey:kCATransitionFromRight];
}

- (IBAction)pressCurl:(id)sender {
    [self changeView:YES];
    CATransition *animotion = [CATransition animation];
    animotion.type = @"pageCurl";
    animotion.subtype = kCATransitionFromRight;
    animotion.duration = 1.0;
    [_label.layer addAnimation:animotion forKey:@"curlAnimotion"];
    
    
}
- (IBAction)pressUnCurlButton:(id)sender {
    [self changeView:YES];
    CATransition *animotion = [CATransition animation];
    animotion.type = @"pageUnCurl";
    animotion.subtype = kCATransitionFromRight;
    animotion.duration = 2.0;
    [_label.layer addAnimation:animotion forKey:@"pageUnCurlAnimotion"];
}

- (IBAction)pressCaOpenButton:(id)sender{
    
    [self changeView:YES];
    CATransition *animotion = [CATransition animation];
    animotion.type = @"cameraIrisHollowOpen"; //设置动画的类型
    animotion.subtype = kCATransitionFromRight;
    animotion.duration = 1.0f;
    [_label.layer addAnimation:animotion forKey:@"cameraIrisHollowOpenAnimotion"];
}


- (IBAction)pressCaCloseButton:(id)sender {
    [self changeView:YES];
    CATransition *animotion = [CATransition animation];
    animotion.type = @"cameraIrisHollowClose";
    animotion.subtype = kCATransitionFromRight;
    [_label.layer addAnimation:animotion forKey:@"cameraIrisHollowClose"];
    
    
}

/**
 *  设置view的值
 */

- (void)changeView:(BOOL)isUp{
    
    
    if (_index > 3) {
        _index = 0;
    }
    if (_index < 0) {
        _index = 3;
    }
    
    NSArray *colors = [NSArray arrayWithObjects:[UIColor cyanColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor], nil];
    
    // 这个地方不能写@[@1, @2, @3, @4];这样子在下面赋值的时候 label.text会崩溃，且没有任何提示信息
    NSArray *titles = @[@"1", @"2", @"3", @"4"];
    self.label.backgroundColor = [colors objectAtIndex:_index];
    self.label.text = [titles objectAtIndex:_index];
    if (isUp) {
        _index ++;
    }else{
        _index--;
    }
    
    
    
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
