//
//  DBConnectBViewController-Demo.m
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "DBConnectBViewController-Demo.h"
#import "DBConnect.h"
#import "MyDrawView.h"

@interface DBConnectBViewController_Demo ()
@property (nonatomic, strong) MyDrawView *myDrawLabel;
@end

@implementation DBConnectBViewController_Demo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"看代码就可以了";
    
    DBConnect *dbConnect = [DBConnect shareConnect];
    NSString *newUserTableSql = [NSString stringWithFormat:@"CREATE TABLE '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'phone' TEXT default '(null)', 'username' TEXT default '(null)', 'sex' TEXT default '(null)', 'birthday' TEXT default '(null)', 'age' INTEGER default 0, 'nickname' TEXT default '(null)', 'head_portrait' TEXT default '(null)', 'signature' TEXT default '(null)', 'school' TEXT default '(null)', 'company' TEXT default '(null)', 'area' TEXT default '(null)', 'personality_bg' TEXT default '(null)', 'ray_number' INTEGER default 0, notename TEXT default '(null)', friend_source INTEGER default 0, user_type INTEGER default 1, feelType INTEGER default 0)", @"abc"];
    
    // 建用户表
    if ([dbConnect isTableOK:@"abc"] == NO) {
        // 初次建表
        [dbConnect createTableSql:newUserTableSql];
    } else {
        // 已经存在表，判断表需要添加字段吗
        NSString *usql = [NSString stringWithFormat:@"SELECT sql FROM sqlite_master WHERE tbl_name='%@' AND type='table'", @"abc"];
        NSDictionary *udict = [dbConnect getDBOneData:usql];
        NSString *oldFeelSql = [udict objectForKey:@"sql"];
        if ([newUserTableSql isEqualToString:oldFeelSql]) {
            NSLog(@"table no update");
            // 表不需要添加字段
        } else {
            // 直接添加字段 不判断有没有添加过，如果添加过，就直接报错，不影响使用
            NSString *updateTableSql1 = [NSString stringWithFormat:@"ALTER TABLE %@ ADD feelType INTEGER default 0", @"abc"];
            [dbConnect executeUpdateSql:updateTableSql1];
        }
    }

    
    MyDrawView *label = [[MyDrawView alloc] initWithFrame:CGRectMake(10, 100, 500, 500)];
    label.backgroundColor = [UIColor redColor];
    label.userInteractionEnabled = YES;
    [self.view addSubview:label];
    self.myDrawLabel = label;
    self.myDrawLabel.isR = NO;
    self.myDrawLabel.point = -0.5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapaa:)];
    [label addGestureRecognizer:tap];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationAction)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    __block typeof(CADisplayLink)*weakLink = link;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1000.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakLink invalidate];
        weakLink = nil;
    });
}

- (void)animationAction
{
    if (self.myDrawLabel.isR) {
        self.myDrawLabel.point -= 0.001;
    } else {
        self.myDrawLabel.point += 0.001;
    }
    if (self.myDrawLabel.point >= 1.501) {
        self.myDrawLabel.isR = YES;
    } else if (self.myDrawLabel.point <= -0.499) {
        self.myDrawLabel.isR = NO;
    }
    [self.myDrawLabel setNeedsDisplay];
    
}

- (void)tapaa:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:tap.view];
    
    NSLog(@"%f - %f",point.x,point.y);

    NSLog(@"点击");
    
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
