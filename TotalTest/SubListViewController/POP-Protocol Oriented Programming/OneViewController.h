//
//  OneViewController.h
//  TotalTest
//
//  Created by libx on 2019/4/11.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "PublicViewController.h"

typedef void (^GetResult) (int result, NSError * _Nonnull error);

NS_ASSUME_NONNULL_BEGIN

@interface OneViewController : PublicViewController

- (void)getResultAction:(GetResult)result;

@end

NS_ASSUME_NONNULL_END
