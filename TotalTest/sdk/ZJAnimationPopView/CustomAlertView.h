//
//  CustomAlertView.h
//  ZJAnimationPopViewDemo
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 Abnerzj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertView : UIView

@property (nonatomic, copy) void(^canceSureActionBlock)(BOOL isSure);

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)cancelSureButton:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
