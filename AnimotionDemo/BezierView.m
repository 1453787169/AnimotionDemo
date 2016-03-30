//
//  BezierView.m
//  AnimotionDemo
//
//  Created by 董风荣 on 16/3/24.
//  Copyright © 2016年 董风荣. All rights reserved.
//

#import "BezierView.h"

#define SCREEN_WIDTH  self.bounds.size.width
#define SCREEN_HEIGHT self.bounds.size.height

#define MIN_HEIGHT   100   //图形的最小高度

static NSString *kX = @"curveX";  //这个keyPath的监听应该必须是属性的
static NSString *kY = @"curveY";

@interface BezierView ()

@property (nonatomic) CGFloat curveX; //r5的X坐标
@property (nonatomic) CGFloat curveY;  //r5的Y坐标
@property (nonatomic, strong) UIView *curveView; //r5红点
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic,assign) CGFloat mHeight; //手势移动时相对高度
@property (nonatomic, assign) BOOL isAnimotion; //是否处于动效状态

@property (nonatomic, strong) CADisplayLink *displayLink; //实现不停的重绘


@end



@implementation BezierView




-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addObserver:self forKeyPath:kX options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:kY options:NSKeyValueObservingOptionNew context:nil];
        [self.layer addSublayer:self.shapeLayer];
        [self addSubview:self.curveView];
        [self configAction];
        
        
        
        
        
    }
    return self;
}



- (void)configAction{
    _mHeight = 100; //手势移动时相对高度
    _isAnimotion = NO; //是否处于动效时态
    
    //拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:pan];
    
    
    
    //CADisplayLink与定时器的区别 http://blog.csdn.net/ch_soft/article/details/9408855
    //CADisplayLink默认每秒运行60次，calculatePath是算出在运行期间_curveView的坐标，从而确定_shapeLayer的形状
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatePath)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES;
  
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    
    if (!_isAnimotion) {
        if (pan.state == UIGestureRecognizerStateChanged) {
            
            //手势移动时，_shapeLayer跟着手势向下扩大区域
            CGPoint point = [pan translationInView:self];
            NSLog(@"-----point:%@", NSStringFromCGPoint(point));
            
            
            //这里的 point在向左边移动的时候是负数，向右边移动的时候是正数
            //这部分代码使r5跟着手势走
            _mHeight = point.y * 0.7 + MIN_HEIGHT;
            self.curveX = SCREEN_WIDTH / 2.0 + point.x;
            self.curveY = _mHeight > MIN_HEIGHT ? _mHeight : MIN_HEIGHT;
            
            _curveView.frame = CGRectMake(_curveX, _curveY, 6, 6);
            
            
        }else if(pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateFailed){
            //在放松之后，_shapeLayer返回原状并且产生弹簧效果
            _isAnimotion = YES;
            _displayLink.paused = NO; //开启dispalyLink，会执行方法calculatepath
            //http://www.renfei.org/blog/ios-8-spring-animation.html
            //上面那个网址是这两个参数singSpringWithDamping:，initialSpringVelocity:的使用方法
            
            //singSpringWithDamping:范围是0.0f-1.0f，数值越小，弹簧的震动效果越明显。
            //initialSpringVelocity:则表示初始的速度，数值越大一开始移动速度越快
            
            [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:15.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                //位置的转换即是一个动画慢慢往上移的转换
                //曲线点r5是一个view,所以在block中有弹簧效果，然后根据他的动效路径，在calculate中计算弹性徒刑的形状
                _curveView.frame = CGRectMake(SCREEN_WIDTH / 2.0, MIN_HEIGHT, 6, 6);
            } completion:^(BOOL finished) {
                if (finished) {
                    _displayLink.paused = YES;
                    _isAnimotion = NO;
                }
            }];
            
            
            
            
        }
    }
    
}


- (void)calculatePath{
    //由于手势结束后，r5执行了一个UIview的弹性动画，把这个过程的坐标纪录下来，并相应的画出_shapeLayer的形状
    CALayer *layer = _curveView.layer.presentationLayer;
    self.curveX = layer.position.x;
    self.curveY = layer.position.y;
}



-(CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        
        
    }
    return _shapeLayer;
}

-(UIView *)curveView{
    if (!_curveView) {
        self.curveX = SCREEN_WIDTH / 2.0;
        self.curveY = MIN_HEIGHT;
        _curveView = [[UIView alloc] initWithFrame:CGRectMake(self.curveX, self.curveY, 6, 6)];
        _curveView.backgroundColor = [UIColor redColor];
    }
    return _curveView;
}


-(void)dealloc{
    [self removeObserver:self forKeyPath:kX];
    [self removeObserver:self forKeyPath:kY];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:kX] || [keyPath isEqualToString:kY]) {
        [self updateShapeLayerpath];
    }
}






- (void)updateShapeLayerpath{
    //更新_shapelayer的形状
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH, MIN_HEIGHT)];
    [bezierPath addQuadCurveToPoint:CGPointMake(0, MIN_HEIGHT) controlPoint:CGPointMake(_curveX, _curveY)];
    [bezierPath closePath];
    _shapeLayer.path = bezierPath.CGPath;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
