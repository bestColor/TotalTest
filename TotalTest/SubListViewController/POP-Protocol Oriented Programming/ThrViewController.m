//
//  ThrViewController.m
//  TotalTest
//
//  Created by libx on 2019/4/11.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "ThrViewController.h"

@interface ThrViewController ()

@end

@implementation ThrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSStringFromClass([self class]);
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.getTotal) {
            self.getTotal(1,2);
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.getTotal(2,4);
        });
    });
    
    
}
- (void)getNumber:(int)a anotherNumber:(int)b
{
    NSLog(@"%@ a - b = %d",NSStringFromClass([self class]),a-b);
    
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
