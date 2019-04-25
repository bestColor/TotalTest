//
//  AssistiveTouch.m
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "AssistiveTouch.h"

@interface AssistiveTouch ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton *spButton;
@end

@implementation AssistiveTouch

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"可以任意拖动的小图标";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width-82,self.view.frame.size.height - 82,82,82);
    [btn setCenter:self.view.center];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    self.spButton = btn;
    [self.spButton addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //添加手势
    UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panRcognize.delegate = self;
    [btn addGestureRecognizer:panRcognize];
    
}

- (void)addEvent:(UIButton *)sender
{
    NSLog(@"点击来小红球");
}

#pragma mark - UIPanGestureRecognizerDelegate

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    //移动状态
    UIGestureRecognizerState recState =  recognizer.state;
    
    switch (recState) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.view];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"UIGestureRecognizerStateEnded");
            
            /// 手机屏幕实际宽高
            float kSCREEN_HEIGHT = [UIScreen mainScreen].bounds.size.height;
            float kSCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
            
            CGPoint stopPoint = CGPointMake(0, kSCREEN_HEIGHT / 2.0);
            
            if (recognizer.view.center.x < kSCREEN_WIDTH / 2.0) {
                if (recognizer.view.center.y <= kSCREEN_HEIGHT/2.0) {
                    //左上
                    if (recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, self.spButton.frame.size.width/2.0);
                    }else{
                        stopPoint = CGPointMake(self.spButton.frame.size.width/2.0, recognizer.view.center.y);
                    }
                }else{
                    //左下
                    if (recognizer.view.center.x  >= kSCREEN_HEIGHT - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, self.view.frame.size.height - self.spButton.frame.size.width/2.0);
                    }else{
                        stopPoint = CGPointMake(self.spButton.frame.size.width/2.0, recognizer.view.center.y);
                        //                        stopPoint = CGPointMake(recognizer.view.center.x, SCREEN_HEIGHT - self.spButton.frame.size.width/2.0);
                    }
                }
            }else{
                if (recognizer.view.center.y <= kSCREEN_HEIGHT/2.0) {
                    //右上
                    if (kSCREEN_WIDTH - recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, self.spButton.frame.size.width/2.0);
                    }else{
                        stopPoint = CGPointMake(kSCREEN_WIDTH - self.spButton.frame.size.width/2.0, recognizer.view.center.y);
                    }
                }else{
                    //右下
                    if (kSCREEN_WIDTH - recognizer.view.center.x  >= kSCREEN_HEIGHT - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, self.view.frame.size.height - self.spButton.frame.size.width/2.0);
                    }else{
                        stopPoint = CGPointMake(kSCREEN_WIDTH - self.spButton.frame.size.width/2.0,recognizer.view.center.y);
                    }
                }
            }
            
            //如果按钮超出屏幕边缘
            if (stopPoint.y + self.spButton.frame.size.width+40>= kSCREEN_HEIGHT) {
                stopPoint = CGPointMake(stopPoint.x, self.view.frame.size.height - self.spButton.frame.size.width/2.0);
                //                NSLog(@"超出屏幕下方了！！"); //这里注意iphoneX的适配。。X的SCREEN高度算法有变化。
            }
            if (stopPoint.x - self.spButton.frame.size.width/2.0 <= 0) {
                stopPoint = CGPointMake(self.spButton.frame.size.width/2.0, stopPoint.y);
            }
            if (stopPoint.x + self.spButton.frame.size.width/2.0 >= kSCREEN_WIDTH) {
                stopPoint = CGPointMake(kSCREEN_WIDTH - self.spButton.frame.size.width/2.0, stopPoint.y);
            }
            if (stopPoint.y - self.spButton.frame.size.width/2.0 <= 0) {
                stopPoint = CGPointMake(stopPoint.x, self.spButton.frame.size.width/2.0);
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
            
        default:
            break;
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
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
