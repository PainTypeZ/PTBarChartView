//
//  ViewController.m
//  PTBarChartView
//
//  Created by 彭平军 on 2017/3/29.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import "ViewController.h"
#import "PTBarChartModel.h"
#import "PTBarChartView.h"
@interface ViewController ()
@property (strong, nonatomic) PTBarChartView *barChartView;
@property (strong, nonatomic) PTBarChartModel *barChartModel;
@end

@implementation ViewController
#pragma marl - override getter methods
// 重写getter方法设置barModel假数据
- (PTBarChartModel *)barChartModel {
    if (!_barChartModel) {
        // 创建PTBarChartModel实例,设置各项属性
        _barChartModel = [[PTBarChartModel alloc] init];
        _barChartModel.barNumber = 10;// 设置bar数量为10
        _barChartModel.maxBarValue = 1000;// 设置bar数值上限为1000
        _barChartModel.barValues = [self setBarValues];// 使用随机数假数据
        // 设置bar颜色，间距，动画播放时间
        _barChartModel.barColor = [UIColor greenColor];
        _barChartModel.barSpacing = 2.0;
        _barChartModel.barAnimationDuration = 1.5;
        // 设置barChart背景颜色
        _barChartModel.barChartColor = [UIColor grayColor];
        
        // 设置xAxle
        _barChartModel.numberOfXAxleParts = _barChartModel.barNumber;// 自定义的时候，数量必须与下面的数组长度对应
//        NSMutableArray *fakeXAxleTextsArray = [NSMutableArray array];
//        for (int i = 0; i < _barChartModel.numberOfXAxleParts; i++) {
//            NSString *xAxleText = [NSString stringWithFormat:@"%d", i + 1];
//            [fakeXAxleTextsArray addObject:xAxleText];
//        }
//        _barChartModel.xAxleTexts = fakeXAxleTextsArray;
        _barChartModel.xAxleTexts = @[@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十"];
        _barChartModel.xAxleColor = [UIColor blackColor];
        _barChartModel.xAxleTextColor = [UIColor whiteColor];
        
        // 设置yAxle
        _barChartModel.numberOfYAxleParts = 5;// 数量必须与下面的数组长度对应
        _barChartModel.yAxleTexts = @[@"0", @"250", @"500", @"750", @"1000"];// 还未想好如何自动生成数值标签
        _barChartModel.yAxleColor = [UIColor blackColor];
        _barChartModel.yAxleTextColor = [UIColor whiteColor];
        
        // 设置xy轴线颜色
        _barChartModel.axleLineColor = [UIColor whiteColor];
    }
    return _barChartModel;
}
// barChartView懒加载
- (PTBarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[PTBarChartView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height / 2)];
        _barChartView.backgroundColor = [UIColor lightGrayColor];// 建议与barChart的背景色保持一致
        // 传递model到view
        _barChartView.barChartModel = self.barChartModel;
        // 添加为ViewController的子视图
        [self.view addSubview:_barChartView];
    }
    return _barChartView;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.barChartView drawBarChart];
}
- (IBAction)cleanBarAction:(UIButton *)sender {
    [self.barChartView cleanBarChart];
}

- (IBAction)redrawBarAction:(UIButton *)sender {
    self.barChartModel.barValues = [self setBarValues];// 重新获取假数据
    self.barChartView.barChartModel = self.barChartModel;// barChartView变更数据
    [self.barChartView drawBarChart];
}

#pragma mark - custom methods
// 生成随机数假数据
- (NSArray<NSNumber *> *)setBarValues {
    NSMutableArray<NSNumber *> *fakeDataArray = [NSMutableArray array];
    for (int i = 0; i < _barChartModel.barNumber; i++) {
        CGFloat fakeBarValue = arc4random() % (NSInteger)_barChartModel.maxBarValue;
        [fakeDataArray addObject:@(fakeBarValue)];
    }
    return fakeDataArray;
}

@end
