//
//  IDCardRecognitionDemo.m
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "IDCardRecognitionDemo.h"
#import "AVCaptureViewController.h"

@interface IDCardRecognitionDemo ()

@end

@implementation IDCardRecognitionDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"识别身份证信息";

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width-82,self.view.frame.size.height - 82,200,82);
    [btn setCenter:self.view.center];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"点击扫描身份证" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(checkCard) forControlEvents:UIControlEventTouchUpInside];


}

- (void)checkCard
{
    AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
    [self.navigationController pushViewController:AVCaptureVC animated:YES];
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
