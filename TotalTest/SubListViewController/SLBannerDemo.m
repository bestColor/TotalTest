//
//  SLBannerDemo.m
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "SLBannerDemo.h"
#import "SLBannerView.h"

@interface SLBannerDemo ()<SLBannerViewDelegate>

@end

@implementation SLBannerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"轮播图";
    
    SLBannerView *banner = [SLBannerView bannerView];
    
    //2. banner 的位置和大小
    banner.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    
    
    //7.如果将要传入的数组有空值或图片路径不正确，建议在传入前设置占位图,否则第一次运行不显示占位图，
    //如果将要传入的数组不为空和图片路径都正确，占位图可不设
    banner.placeholderImg = [UIImage imageNamed:@"SLPlaceholderImageName.jpg"];
    //3. 需要传入的图片数组，如果设置了占位图，数组可以传空
    banner.slImages = @[
                        @"2.jpg",
                        @"http://img3.duitang.com/uploads/item/201601/03/20160103215632_M48zu.thumb.700_0.jpeg",
                        @"未知路径，显示占位图",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535866967519&di=5faf2fc5574462a62fae61b81b5a0935&imgtype=0&src=http%3A%2F%2Fpic31.nipic.com%2F20130708%2F7447430_090100939000_2.jpg",
                        @"http://img.zcool.cn/community/01b34f58eee017a8012049efcfaf50.jpg@1280w_1l_2o_100sh.jpg"];
    
    //工程图片
    //    banner.slImages = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg"];
    
    //设置标题
    banner.slTitles = @[@"第1张图片的标题", @"第2张图片的标题", @"第3张图片的标题", @"第4张图片的标题",@" 第5张图片的标题"];
    
    [banner.titleLabel setTextColor:[UIColor yellowColor]];
    //4. 监听设置代理
    banner.delegate = self;
    //5. banner添加到UI上
    [self.view addSubview:banner];
    
    //6. 自定义动画时间，建议动画持续时间小于停留时间
    banner.durTimeInterval = 0.2;
    banner.imgStayTimeInterval = 2.5;
    
}

#pragma mark - SLBannerViewDelegate
- (void)bannerView:(SLBannerView *)banner didClickImagesAtIndex:(NSInteger)index
{
    NSLog(@"++++++++++songlei 点击了%ld ++++++++++", index);
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
