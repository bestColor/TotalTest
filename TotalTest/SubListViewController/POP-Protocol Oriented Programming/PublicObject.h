//
//  PublicObject.h
//  TotalTest
//
//  Created by libx on 2019/4/11.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface PublicObject : NSObject

+ (id<ProjectPublicProtocol>)getViewControllerWithType:(int)type;

@end

NS_ASSUME_NONNULL_END
