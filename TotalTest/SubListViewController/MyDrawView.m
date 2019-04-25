//
//  MyDrawView.m
//  TotalTest
//
//  Created by libx on 2019/4/15.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "MyDrawView.h"

@interface MyDrawView()
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)UILabel *label;
@end

@implementation MyDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeView];
    }
    return self;
}

- (void)makeView
{
    self.image = [UIImage imageNamed:@"0321_yuyin"];
    

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
        self.label.backgroundColor = [UIColor blackColor];
        self.label.textColor = [UIColor whiteColor];
        self.label.text = @"ABC";
        self.label.textAlignment = NSTextAlignmentCenter;
        
        self.image = [UIImage imageNamed:@"0321_paizhao"];
        
        [self setNeedsDisplay];
    });
}



- (void)drawRect:(CGRect)rect {
    
    /// 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /// 设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    /// 设置线条粗细
    CGContextSetLineWidth(context, 3.0);
    
    /// 设置颜色
    CGContextSetRGBStrokeColor(context, 0.5, 0.3, 0.9, 1.0);
    
    /*
    /// 准备开始一个路径
    CGContextBeginPath(context);
    
    /// 设置起始点为0.0
    CGContextMoveToPoint(context, 0, 0);
    
    /// 添加一条线
    CGContextAddLineToPoint(context, 50, 50);
    
    /// 添加一条线
//    CGContextAddLineToPoint(context, 0, 100);
    
    CGContextAddRect(context, CGRectMake(50, 1, 49, 49));
    
    /// 准备结束一个路径
    CGContextStrokePath(context);
    
    
    
    /// 画图片
    if (self.image) {
        [self.image drawInRect:CGRectMake(50, 50, 50, 50)];
    }
    
    if (self.label.text.length) {
        
        NSDictionary *attriDict = @{
                                    NSFontAttributeName: [UIFont systemFontOfSize:25.0],
                                    NSForegroundColorAttributeName: [UIColor whiteColor]
                                    };
        
        [self.label.text drawInRect:CGRectMake(50, 12.5, 50, 25) withAttributes:attriDict];
    }
    */
    
    CGContextBeginPath(context);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    CGContextAddArc(context, 200, 200, 50, 0, 2*M_PI, 0);
    CGContextStrokePath(context);
    
    CGContextBeginPath(context);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextAddArc(context, 200, 200, 50, -M_PI/2.0, _point*M_PI, 0);
    CGContextStrokePath(context);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attriDict = @{
                                NSFontAttributeName: [UIFont systemFontOfSize:25.0],
                                NSForegroundColorAttributeName: [UIColor whiteColor],
                                NSParagraphStyleAttributeName:paragraphStyle
                                };
    
    int ar = ((self.point+0.5) / 2.0) * 100;
    [[NSString stringWithFormat:@"%d%@",ar,@"%"] drawInRect:CGRectMake(150, 187.5, 100, 25) withAttributes:attriDict];
    

    
    
    
    /*
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddCurveToPoint(context, 200, 50, 100, 400, 300, 400);
    CGContextStrokePath(context);

    
     CGContextBeginPath(context);
    CGContextSetLineWidth(context, 5.0);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextMoveToPoint(context, self.point, self.point);//开始画线, x，y 为开始点的坐标
    CGContextAddCurveToPoint(context, 310, 100, 300, 200, 220, 220);//画三次点曲线
    CGContextAddCurveToPoint(context, 290, 140, 280, 180, 240, 190);//画三次点曲线
    CGContextStrokePath(context);
*/
}


@end
