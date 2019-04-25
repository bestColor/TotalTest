//
//  SliderView.h
//  TotalTest
//
//  Created by libx on 2019/4/25.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SliderView : UIView

@property (nonatomic, assign) float minSliderValue;
@property (nonatomic, assign) float maxSliderValue;

- (instancetype)initWithLeftLabel:(UILabel *)leftLabel rightLabel:(UILabel *)rightLabel;

@end

NS_ASSUME_NONNULL_END
