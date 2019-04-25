//
//  OC-Swift-Demo.m
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "OC-Swift-Demo.h"
#import "TotalTest-Swift.h"

@interface OC_Swift_Demo ()

@end

@implementation OC_Swift_Demo

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"OC调用Swift的例子";
    
    /*
     
     1. 首先新建一个 .h 文件， 名字叫做  工程名字-Swift， 然后再oc文件里面引用这个文件，
     就可以在这个文件里面使用所有的OC代码，此时一定要从工程里删除这个你刚新建的 .h文件
     
     */
    
    UIButton *lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lastButton.frame = CGRectMake((self.view.frame.size.width - 250)/2.0, (self.view.frame.size.height-44)/2.0, 250, 44);
    [lastButton setTitle:@"跳转到Swift类" forState:UIControlStateNormal];
    [lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lastButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [lastButton addTarget:self action:@selector(nextToSwiftClass) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lastButton];
    
    
    

    
}

- (void)nextToSwiftClass
{
    MJRefresh_Swift_Demo *swiftDemo = [[MJRefresh_Swift_Demo alloc] init];
    [self.navigationController pushViewController:swiftDemo animated:YES];
    
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
