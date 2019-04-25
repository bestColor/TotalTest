//
//  SliderView.m
//  TotalTest
//
//  Created by libx on 2019/4/25.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "SliderView.h"

@interface SliderView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *leftMoveView;
@property (nonatomic, strong) UIView *rightMoveView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) CGRect leftMinFrame;
@property (nonatomic, assign) CGRect leftMaxFrame;

@property (nonatomic, assign) CGRect rightMinFrame;
@property (nonatomic, assign) CGRect rightMaxFrame;

@property (nonatomic, strong) UILabel *spaceMinLabel;
@property (nonatomic, strong) UILabel *spaceMaxLabel;

@end

@implementation SliderView


- (instancetype)initWithLeftLabel:(UILabel *)leftLabel rightLabel:(UILabel *)rightLabel
{
    self = [super init];
    if (self) {
        _spaceMinLabel = leftLabel;
        _spaceMaxLabel = rightLabel;
        [self makeView];
    }
    return self;
}

- (void)makeView
{
    self.frame = CGRectMake(50, 350, 400, 50);
    self.backgroundColor = [UIColor clearColor];
    
    _minSliderValue = 0.00f;
    _maxSliderValue = 1.00f;
    _spaceMinLabel.text = [NSString stringWithFormat:@"%.2f",_minSliderValue];
    _spaceMaxLabel.text = [NSString stringWithFormat:@"%.2f",_maxSliderValue];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(25, 20, self.frame.size.width - 50, 10)];
    lineView.backgroundColor = [UIColor redColor];
    [lineView.layer setCornerRadius:5];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    UIView *leftMoveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    leftMoveView.backgroundColor = [UIColor clearColor];
    [self addSubview:leftMoveView];
    self.leftMoveView = leftMoveView;
    
    UIView *_leftSlider = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [_leftSlider.layer setCornerRadius:15];
    _leftSlider.backgroundColor = [UIColor greenColor];
    [leftMoveView addSubview:_leftSlider];
    
    _leftMinFrame = leftMoveView.frame;
    _leftMaxFrame = CGRectMake(self.lineView.frame.size.width - 50, 0, 50, 50);
    
    UIView *rightMoveView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 0, 50, 50)];
    rightMoveView.backgroundColor = [UIColor clearColor];
    [self addSubview:rightMoveView];
    self.rightMoveView = rightMoveView;
    
    UIView *_rightSlider = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    _rightSlider.backgroundColor = [UIColor blackColor];
    [_rightSlider.layer setCornerRadius:15];
    [rightMoveView addSubview:_rightSlider];
    
    _rightMaxFrame = rightMoveView.frame;
    _rightMinFrame = CGRectMake(50, 0, 50, 50);
    
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPan:)];
    leftPan.delegate = self;
    [leftMoveView addGestureRecognizer:leftPan];
    
    UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightPan:)];
    rightPan.delegate = self;
    [rightMoveView addGestureRecognizer:rightPan];
    
}

- (void)leftPan:(UIPanGestureRecognizer *)pan
{
    
    CGPoint transP = [pan translationInView:pan.view];
    
    // 移动图片控件
    
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, 0);
    
    // 复位,表示相对上一次
    [pan setTranslation:CGPointZero inView:pan.view];
    
    if (pan.view.frame.origin.x <= _leftMinFrame.origin.x) {
        pan.view.frame = _leftMinFrame;
    } else if (pan.view.frame.origin.x >= _leftMaxFrame.origin.x) {
        pan.view.frame = _leftMaxFrame;
    }
    
    
    _rightMinFrame = CGRectMake(pan.view.frame.origin.x + 50, pan.view.frame.origin.y, pan.view.frame.size.width, pan.view.frame.size.height);
    
    _minSliderValue = _leftMoveView.frame.origin.x/self.lineView.frame.size.width;
    _maxSliderValue = _rightMoveView.frame.origin.x/self.lineView.frame.size.width;
    
    _spaceMinLabel.text = [NSString stringWithFormat:@"%.2f",_minSliderValue];
    _spaceMaxLabel.text = [NSString stringWithFormat:@"%.2f",_maxSliderValue];
    
}

- (void)rightPan:(UIPanGestureRecognizer *)pan
{
    CGPoint transP = [pan translationInView:pan.view];
    
    // 移动图片控
    
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, 0);
    
    // 复位,表示相对上一次
    [pan setTranslation:CGPointZero inView:pan.view];
    
    if (pan.view.frame.origin.x >= _rightMaxFrame.origin.x) {
        pan.view.frame = _rightMaxFrame;
    } else if (pan.view.frame.origin.x <= _rightMinFrame.origin.x) {
        pan.view.frame = _rightMinFrame;
    }
    
    _leftMaxFrame = CGRectMake(pan.view.frame.origin.x - 50, pan.view.frame.origin.y, pan.view.frame.size.width, pan.view.frame.size.height);
    
    _minSliderValue = _leftMoveView.frame.origin.x/self.lineView.frame.size.width;
    _maxSliderValue = _rightMoveView.frame.origin.x/self.lineView.frame.size.width;
    
    _spaceMinLabel.text = [NSString stringWithFormat:@"%.2f",_minSliderValue];
    _spaceMaxLabel.text = [NSString stringWithFormat:@"%.2f",_maxSliderValue];
  
}

//重写该方法后可以让超出父视图范围的子视图响应事件
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == nil) {
//        for (UIView *subView in self.lineView.subviews) {
//            CGPoint tp = [subView convertPoint:point fromView:self.lineView];
//            if (CGRectContainsPoint(subView.bounds, tp)) {
//                view = subView;
//            }
//        }
//    }
//    return view;
//}


@end
