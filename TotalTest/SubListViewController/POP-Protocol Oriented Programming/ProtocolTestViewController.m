//
//  ProtocolTestViewController.m
//  TotalTest
//
//  Created by libx on 2019/4/11.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "ProtocolTestViewController.h"
#import "PublicObject.h"
#import "OneViewController.h"
#import "ThrViewController.h"

@interface ProtocolTestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *classArray;
@end

@implementation ProtocolTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _classArray = [[NSMutableArray alloc] init];
    [_classArray addObject:@"1"];
    [_classArray addObject:@"2"];
    [_classArray addObject:@"3"];

    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    _tableView.tableHeaderView = [self createView];
}

- (UIView *)createView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 300)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.text = @"note：关于代理相关的有以下几点：\n1. 首先创建一个协议类，定义方法。 \n2. 创建一个中间组件，也就是控制遵守协议类的句柄，用来生成遵守协议的类，其中要引用协议和引用所有遵守协议的类。\n3. 创建一个遵守协议的主类，比如PublicViewController。只是遵守协议，其他什么都不做。\n4. 生成一堆类，继承与这个遵守协议的主类，并且实现遵守的协议方法。\n 5. 使用的时候，利用中间组件，生成遵守协议的自类的实例（也可以利用runtime动态生成遵守协议的实例），然后利用runtime判断该类是否实现了遵守的协议。";
    label.font = [UIFont systemFontOfSize:25];
    label.numberOfLines = 0;
    return label;
    
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
    id<ProjectPublicProtocol> vc = [PublicObject getViewControllerWithType:(int)indexPath.row];
    if ([vc respondsToSelector:@selector(getNumber:anotherNumber:)]) {
        [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
        
        if ([vc isKindOfClass:[OneViewController class]]) {
            OneViewController *v = (OneViewController *)vc;
            [v getResultAction:^void(int result, NSError * _Nonnull error) {
                NSLog(@"result = %d, %@",result, error.domain);
            }];
        } else if ([vc isKindOfClass:[ThrViewController class]]) {
            ThrViewController *v = (ThrViewController *)vc;
            v.getTotal = ^(int a, int b) {
                NSLog(@"a = %d, b = %d",a,b);
            };
        }
        
    } else {
        NSLog(@"没有实现代理方法，不跳转");
    }
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
