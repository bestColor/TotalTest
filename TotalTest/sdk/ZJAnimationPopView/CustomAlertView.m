//
//  CustomAlertView.m
//  ZJAnimationPopViewDemo
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 Abnerzj. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeViewWithTitle:@"提示" message:@""];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super init];
    if (self) {
        [self makeViewWithTitle:title message:message];
    }
    return self;
}

- (void)makeViewWithTitle:(NSString *)title message:(NSString *)message
{
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor redColor];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self.frame = CGRectMake(screenSize.width/4.0, (screenSize.height - screenSize.width/2.0)/2.0, screenSize.width/2.0, screenSize.width/2.0*0.75);
    self.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44.0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:23];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, self.frame.size.height - 54.0, self.frame.size.width/2.0, 54.0);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = titleLabel.font;
    [cancelButton setTitleColor:titleLabel.textColor forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor redColor]];
    cancelButton.tag = 0;
    [cancelButton addTarget:self action:@selector(cancelSureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(self.frame.size.width/2.0, self.frame.size.height - 54.0, self.frame.size.width/2.0, 54.0);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = titleLabel.font;
    [sureButton setTitleColor:titleLabel.textColor forState:UIControlStateNormal];
    [sureButton setBackgroundColor:[UIColor blueColor]];
    sureButton.tag = 1;
    [sureButton addTarget:self action:@selector(cancelSureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureButton];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLabel.frame.size.height + 5, titleLabel.frame.size.width - 40, self.frame.size.height - cancelButton.frame.size.height - titleLabel.frame.size.height - 10)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = [UIFont systemFontOfSize:20];
    messageLabel.numberOfLines = 0;
    messageLabel.adjustsFontSizeToFitWidth = YES;
    if (message.length) {
        messageLabel.text = message;
    } else {
        messageLabel.text = @"这里是一个弹出提示框";
    }
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:messageLabel];
    
}

- (void)cancelSureButton:(UIButton *)sender
{
    if (self.canceSureActionBlock) {
        self.canceSureActionBlock(sender.tag);
    }
}

@end
