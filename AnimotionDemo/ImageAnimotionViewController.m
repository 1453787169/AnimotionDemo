//
//  ImageAnimotionViewController.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/30.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "ImageAnimotionViewController.h"
#import "UIView+SDExtension.h"

@interface ImageAnimotionViewController (){
    NSTimer *timer;
}


@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ImageAnimotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.imageView addObserver:self forKeyPath:@"imageView.frame.size.x" options:NSKeyValueObservingOptionNew context:nil];
    
   timer =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(widthImageView) userInfo:nil repeats:YES];
    [self.view addSubview:self.imageView];
}


-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, 30, 250)];
        _imageView.image = [UIImage imageNamed:@"apple.jpg"];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeTopLeft;
    }
    return _imageView;
}

- (void)widthImageView{
    self.imageView.sd_width += 10;
//    CGRect rect = self.imageView.frame;
//    rect.size.width += 10;
//    self.imageView.frame = rect;
    
    if (self.imageView.sd_width >= self.view.bounds.size.width) {
        [timer invalidate];
    }
}



//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"imageView.frame.size.x"]) {
//        _imageView.frame.size.width
//    }
//}

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
