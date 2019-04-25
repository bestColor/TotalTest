//
//  PublicObject.m
//  TotalTest
//
//  Created by libx on 2019/4/11.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "PublicObject.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThrViewController.h"

@implementation PublicObject

+ (id<ProjectPublicProtocol>)getViewControllerWithType:(int)type
{
    if (type == 0) {
        OneViewController *vc = [[OneViewController alloc] init];
        return vc;
    }
    
    if (type == 1) {
        TwoViewController *vc = [[TwoViewController alloc] init];
        return vc;
    }
    
    ThrViewController *vc = [[ThrViewController alloc] init];
    return vc;
    
}

@end
