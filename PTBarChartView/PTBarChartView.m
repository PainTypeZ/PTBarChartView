//
//  PTBarChartView.m
//  PTBarChartView
//
//  Created by 彭平军 on 2017/3/29.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import "PTConstant.h"
#import "PTBarChart.h"
#import "PTXAxle.h"
#import "PTYAxle.h"
#import "PTBarChartView.h"

@interface PTBarChartView()

@property (strong, nonatomic) PTBarChart *barChart;
@property (strong, nonatomic) PTXAxle *xAxle;
@property (strong, nonatomic) PTYAxle *yAxle;
@property (strong, nonatomic) UIView *xAxleLine;
@property (strong, nonatomic) UIView *yAxleLine;
@property (assign, nonatomic) CGFloat barMaxHeight;

@end
@implementation PTBarChartView

#pragma mark - lazyLoading
- (CGFloat)barMaxHeight {
    if (!_barMaxHeight) {
        _barMaxHeight = self.bounds.size.height - (kBarChartOriginY + kXAxleHeight);
    }
    return _barMaxHeight;
}

- (PTBarChart *)barChart {
    if (!_barChart) {
        _barChart = [[PTBarChart alloc] initWithFrame:CGRectMake(kYAxleWidth + kYAxleLineWidth, kBarChartOriginY, self.bounds.size.width - (kYAxleWidth + kYAxleLineWidth), self.barMaxHeight)];
        _barChart.backgroundColor = [UIColor blackColor];
        [self addSubview:_barChart];
    }
    return _barChart;
}

- (PTXAxle *)xAxle {
    if (!_xAxle) {
        _xAxle = [[PTXAxle alloc] initWithFrame:CGRectMake(kYAxleWidth, self.bounds.size.height - kXAxleHeight, self.bounds.size.width - kYAxleWidth, kXAxleHeight)];
        _xAxle.backgroundColor = [UIColor blackColor];
        [self addSubview:_xAxle];
    }
    return _xAxle;
}

- (PTYAxle *)yAxle {
    if (!_yAxle) {
        _yAxle = [[PTYAxle alloc] initWithFrame:CGRectMake(0, 0, kYAxleWidth, self.bounds.size.height)];
        _yAxle.backgroundColor = [UIColor blackColor];
        [self addSubview:_yAxle];
    }
    return _yAxle;
}

- (UIView *)xAxleLine {
    if (!_xAxleLine) {
        _xAxleLine = [[UIView alloc] initWithFrame:CGRectMake(self.xAxle.frame.origin.x, self.xAxle.frame.origin.y, self.xAxle.bounds.size.width, kXAxleLineHeight)];
        _xAxleLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:_xAxleLine];
    }
    return _xAxleLine;
}

- (UIView *)yAxleLine {
    if (!_yAxleLine) {
        _yAxleLine = [[UIView alloc] initWithFrame:CGRectMake(self.yAxle.bounds.size.width, self.bounds.origin.y, kYAxleLineWidth, self.bounds.size.height - kXAxleHeight)];
        _yAxleLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:_yAxleLine];
    }
    return _yAxleLine;
}

#pragma mark - private methods
// 重写setter方法
- (void)setBarChartModel:(PTBarChartModel *)barChartModel {
    _barChartModel = barChartModel;
    // barChart数据传输
    self.barChart.barNumber = _barChartModel.barNumber;
    self.barChart.barColor = _barChartModel.barColor;
    self.barChart.barSpacing = _barChartModel.barSpacing;
    self.barChart.barAnimationDuration = _barChartModel.barAnimationDuration;
    self.barChart.barValues = _barChartModel.barValues;
    self.barChart.maxBarValue = _barChartModel.maxBarValue;// 需要考虑能否自动生成整百整千等
    self.barChart.backgroundColor = _barChartModel.barChartColor;
    self.backgroundColor = _barChartModel.barChartColor;// 使barChartView的背景色与barChart保持一致
    
    // xAxle数据传输
    self.xAxle.numberOfParts = _barChartModel.numberOfXAxleParts;
    self.xAxle.texts = _barChartModel.xAxleTexts;
    self.xAxle.backgroundColor = _barChartModel.xAxleColor;
    self.xAxle.textColor = _barChartModel.xAxleTextColor;
    // x轴线颜色
    self.xAxleLine.backgroundColor = _barChartModel.axleLineColor;
    
    // yAxle数据传输
    self.yAxle.numberOfParts = _barChartModel.numberOfYAxleParts;
    self.yAxle.texts = _barChartModel.yAxleTexts;
    self.yAxle.backgroundColor = _barChartModel.yAxleColor;
    self.yAxle.textColor = _barChartModel.yAxleTextColor;
    
    // y轴线颜色
    self.yAxleLine.backgroundColor = _barChartModel.axleLineColor;
}
// 显示x轴标签
- (void)showXAxleText {
    self.xAxle.numberOfParts = self.barChartModel.barNumber;
    self.xAxle.texts = self.barChartModel.xAxleTexts;
    [self.xAxle showXAxleTextsWithBarSpacing:self.barChart.barSpacing];
}
// 显示y轴标签
- (void)showYAxleText {
    self.yAxle.numberOfParts = self.barChartModel.numberOfYAxleParts;
    self.yAxle.texts = self.barChartModel.yAxleTexts;
    [self.yAxle showYAxleTextsWithBarMaxHeight:self.barMaxHeight];
    
}
#pragma mark - public methods
// 绘制barChart
- (void)drawBarChart {
    if (self.barChart.layer.sublayers) {
        NSLog(@"已经存在barChart，要重绘请先删除当前barChart");
        return;
    }
    [self.barChart drawBarChart];
    if (self.xAxle) {
        [self showXAxleText];
        [self showYAxleText];
    }
}
// 清除barChart
- (void)cleanBarChart {
    if (self.barChart.layer.sublayers == nil) {
        NSLog(@"没有可清除的barChart, 请先绘制barChart");
        return;
    }
    [self.barChart cleanBarChart];
}

@end
