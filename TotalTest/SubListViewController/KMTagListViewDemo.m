//
//  KMTagListViewDemo.m
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "KMTagListViewDemo.h"
#import "KMTagListView.h"

@interface KMTagListViewDemo ()<KMTagListViewDelegate>

@end

@implementation KMTagListViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"标签选择器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    KMTagListView *tagListView = [[KMTagListView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 0)];
    [tagListView setupSubViewsWithTitles:@[@"哈哈哈哈哈哈", @"哈试发",@"哈你发",@"哈哈试会计给你发",@"哈哈试会计给你发",@"哈哈试会计给你发",@"哈哈试会计给你发",@"哈哈试会计给你发",@"哈哈试会计给你发",@"哈哈试会计给你发"]];
    tagListView.delegate_ = self;
    [self.view addSubview:tagListView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tagListView setupSubViewsWithTitles:@[@"哈哈哈哈哈哈", @"哈试发",@"哈你发",@"哈哈试会计给你发",@"哈哈你发",@"哈哈哈哈哈发", @"哈哈哈哈哈哈考试会计给你发",@"哈哈哈哈哈发",@"哈哈发",@"哈哈哈哈哈发",@"哈哈计给你发",@"哈哈哈哈哈发",@"哈哈哈发",@"哈哈哈哈哈发",@"哈哈你发",@"哈发",@"哈哈哈哈哈哈", @"哈试发",@"哈你发",@"哈哈试会计给你发", @"哈试发",@"哈你发",@"哈哈试会计给你发",@"哈哈你发",@"哈哈哈哈哈发", @"哈哈哈哈哈哈考试会计给你发",@"哈哈哈哈哈发",@"哈哈发",@"哈哈哈哈哈发",@"哈哈计给你发",@"哈哈哈哈哈发",@"哈哈哈发",@"哈哈哈哈哈发",@"哈哈你发",@"哈发", @"哈试发",@"哈你发",@"哈哈试会计给你发", @"哈试发",@"哈你发",@"哈哈试会计给你发",@"哈哈你发",@"哈哈哈哈哈发", @"哈哈哈哈哈哈考试会计给你发",@"哈哈哈哈哈发",@"哈哈发",@"哈哈哈哈哈发",@"哈哈计给你发"]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tagListView setupSubViewsWithTitles:@[@"哈哈哈哈哈哈", @"哈试发",@"哈你发"]];
        });
    });
}

#pragma mark - KMTagListViewDelegate
-(void)ptl_TagListView:(KMTagListView *)tagListView didSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content {
    NSLog(@"content: %@ index: %zd", content, index);
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
