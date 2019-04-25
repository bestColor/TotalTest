//
//  AJAnimationAlertView.m
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "AJAnimationAlertView.h"
#import "ZJAnimationPopView.h"

@interface AJAnimationAlertView ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataList;
}

@end

@implementation AJAnimationAlertView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"一款自定义动画弹出alert的view";

    [self initDataAndSubViews];

    
}
#pragma mark - UITableView DataSource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ZJAnimationPopViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row >= 0 && indexPath.row < _dataList.count) {
        NSDictionary *dict = _dataList[indexPath.row];
        cell.textLabel.text = dict[@"title"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < _dataList.count) {
        NSDictionary *dict = _dataList[indexPath.row];
        NSInteger style = ((NSNumber *)dict[@"style"]).integerValue;
        [self showPopAnimationWithAnimationStyle:style];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

#pragma mark 显示弹框
- (void)showPopAnimationWithAnimationStyle:(NSInteger)style
{
    ZJAnimationPopStyle popStyle = (style == 8) ? ZJAnimationPopStyleCardDropFromLeft : (ZJAnimationPopStyle)style;
    ZJAnimationDismissStyle dismissStyle = (ZJAnimationDismissStyle)style;
    
    // 1.初始化
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:[[CustomAlertView alloc] init] popStyle:popStyle dismissStyle:dismissStyle];
    
    // 2.设置属性，可不设置使用默认值，见注解
    // 2.1 显示时点击背景是否移除弹框
    popView.isClickBGDismiss = YES;
    // 2.2 显示时背景的透明度
    popView.popBGAlpha = 0.5f;
    // 2.3 显示时是否监听屏幕旋转
    popView.isObserverOrientationChange = NO;
    // 2.4 显示时动画时长
    //    popView.popAnimationDuration = 0.8f;
    // 2.5 移除时动画时长
    //    popView.dismissAnimationDuration = 0.8f;
    
    // 2.6 显示完成回调
    popView.popComplete = ^{
        NSLog(@"显示完成");
    };
    // 2.7 移除完成回调
    popView.dismissComplete = ^{
        NSLog(@"移除完成");
    };
    
    // 3.处理自定义视图操作事件
    [self handleCustomActionEnvent:popView];
    
    // 4.显示弹框
    [popView pop];
}

#pragma mark 处理自定义视图操作事件
- (void)handleCustomActionEnvent:(ZJAnimationPopView *)popView
{
    // 在监听自定义视图的block操作事件时，要使用弱对象来避免循环引用
    
    __weak typeof(popView) weakPopView = popView;
    
    popView.customView.canceSureActionBlock = ^(BOOL isSure) {
        [weakPopView dismiss];
        NSLog(@"点击了%@", isSure ? @"确定" : @"取消");
    };
}

#pragma mark 设备方向改变
- (void)statusBarOrientationChange:(NSNotification *)notification
{
    _tableView.frame = self.view.bounds;
    [_tableView reloadData];
}

- (void)initDataAndSubViews
{
    _dataList = @[@{@"title" : @"卡片式掉落动画(从左侧)", @"style" : @6},
                  @{@"title" : @"卡片式掉落动画(从右侧)", @"style" : @7},
                  @{@"title" : @"卡片式掉落动画(往顶部平滑消失)", @"style" : @8},
                  @{@"title" : @"从顶部掉落晃动动画", @"style" : @2},
                  @{@"title" : @"从底部掉落晃动动画", @"style" : @3},
                  @{@"title" : @"从左侧掉落晃动动画", @"style" : @4},
                  @{@"title" : @"从右侧掉落晃动动画", @"style" : @5},
                  @{@"title" : @"缩放动画", @"style" : @1},
                  @{@"title" : @"无动画", @"style" : @0}];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
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
