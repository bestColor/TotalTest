//
//  HeartRateViewController.h
//  TotalTest
//
//  Created by libx on 2019/4/11.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CURRENT_STATE) {
    STATE_PAUSED,
    STATE_SAMPLING
};

#define MIN_FRAMES_FOR_FILTER_TO_SETTLE 10

NS_ASSUME_NONNULL_BEGIN


@interface HeartRateViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
