//
//  OneViewController.m
//  TotalTest
//
//  Created by libx on 2019/4/11.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@property (nonatomic, strong)NSError *error;
@property (nonatomic, assign)int result;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSStringFromClass([self class]);

    
    _result = -1;
    _error = [[NSError alloc] initWithDomain:@"错误" code:-1 userInfo:nil];
}



- (void)getResultAction:(GetResult)result
{
    int ret = -1;
    NSError *err = [[NSError alloc] initWithDomain:@"错误" code:-1 userInfo:nil];
    result(ret, err);
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
