//
//  DoubleSliderViewController.m
//  TotalTest
//
//  Created by libx on 2019/4/24.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "DoubleSliderViewController.h"
#import "SliderView.h"

@interface DoubleSliderViewController ()


@property (nonatomic, strong) UILabel *spaceMinLabel;
@property (nonatomic, strong) UILabel *spaceMaxLabel;

@end

@implementation DoubleSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"DoubleSlider";
    
    _spaceMinLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 100, 50)];
    _spaceMinLabel.textColor = [UIColor redColor];
    _spaceMinLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_spaceMinLabel];
    
    _spaceMaxLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 600 - 50, 300, 100, 50)];
    _spaceMaxLabel.textColor = [UIColor redColor];
    _spaceMaxLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_spaceMaxLabel];
    
 
    SliderView *slider = [[SliderView alloc] initWithLeftLabel:_spaceMinLabel rightLabel:_spaceMaxLabel];
    [self.view addSubview:slider];
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
