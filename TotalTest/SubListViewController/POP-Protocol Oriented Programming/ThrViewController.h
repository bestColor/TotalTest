//
//  ThrViewController.h
//  TotalTest
//
//  Created by libx on 2019/4/11.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "PublicViewController.h"

typedef void (^GetTotal) (int a, int b);

NS_ASSUME_NONNULL_BEGIN

@interface ThrViewController : PublicViewController

@property (nonatomic, copy) GetTotal getTotal;

@end

NS_ASSUME_NONNULL_END
