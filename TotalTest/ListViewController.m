//
//  ListViewController.m
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "ListViewController.h"
#import "TotalTest-Swift.h"
#import "DrawViewDemo.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *classArray;
@property (nonatomic, strong) NSMutableArray *noteArray;

@property (nonatomic, strong) UIImageView *headView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"有好的demo都会陆续加进来";
    
    _classArray = [[NSMutableArray alloc] init];
    _noteArray = [[NSMutableArray alloc] init];

    [_classArray addObjectsFromArray:@[@"ifly_demo",
                                       @"AssistiveTouch",
                                       @"SPActivityIndicatorView_animationButton",
                                       @"DBConnectBViewController_Demo",
                                       @"_TtC9TotalTest20MJRefresh_Swift_Demo",
                                       @"_TtC9TotalTest13Switf_OC_Demo",
                                       @"OC_Swift_Demo",
                                       @"SLBannerDemo",
                                       @"TYCyclePagerViewDemo",
                                       @"KMTagListViewDemo",
                                       @"AJAnimationAlertView",
                                       @"IDCardRecognitionDemo",
                                       @"ProtocolTestViewController",
                                       @"HeartRateViewController",
                                       @"DrawViewDemo",
                                       @"DoubleSliderViewController"]];

    [_noteArray addObjectsFromArray:@[@"讯飞长时间语音识别+存储语音pcm文件和播放",
                                      @"任意拖动的小图标-AssistiveTouch",
                                      @"ios的指示器动画-非常好用的第三方",
                                      @"DBConnect使用例子",
                                      @"代理-Alamofire-cell-mode-MJRefresh的Swift版本学习",
                                      @"Swift调用OC代码",
                                      @"OC调用Swift代码",
                                      @"轮播banner图",
                                      @"轮播图-支持各种效果-大小-3D等效果",
                                      @"一个标签选择器",
                                      @"一款自定义动画的alertView",
                                      @"识别身份证信息-不支持ipad",
                                      @"面向协议编程的自己写的demo",
                                      @"获取心率值-将手指放在摄像头上",
                                      @"使用CAShapeLayer实现的涂鸦画板",
                                      @"DoubleSliderViewController"]];

    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    self.tableView.tableHeaderView = tableHeadView;

    self.headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9978.jpg"]];
    self.headView.frame = CGRectMake(0, 0, self.view.frame.size.width, headH);
    [self.tableView addSubview:self.headView];
    self.headView.contentMode = UIViewContentModeScaleAspectFill;
    self.headView.clipsToBounds = YES;
    

}


static CGFloat headH  = 250;

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offy = scrollView.contentOffset.y;
    
    if (offy < 0)
    {
        CGRect frame = self.headView.frame;
        frame.origin.y = offy;
        frame.size.height = -offy + headH;
        //contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        self.headView.frame = frame;
    }
    
    
    
}


/// UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = @"listViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    cell.textLabel.text = _classArray[indexPath.row];
    cell.detailTextLabel.text = _noteArray[indexPath.row];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _classArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class = NSClassFromString(_classArray[indexPath.row]);
    
    if ([_classArray[indexPath.row] isEqualToString:@"DrawViewDemo"]) {
        DrawViewDemo *drawVC = (DrawViewDemo *)[[class alloc] init];
        drawVC.editImage = [UIImage imageNamed:@"9978.jpg"];

        __weak typeof(ListViewController *)weakSelf = self;
        drawVC.success = ^(UIImage * _Nonnull image) {
            weakSelf.headView.image = image;
        };
        
        [self presentViewController:drawVC animated:YES completion:^{
        }];
        return;
    }
    
    [self.navigationController pushViewController:[[class alloc] init] animated:YES];
}

@end
