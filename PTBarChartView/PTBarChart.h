//
//  PTBarChart.h
//  PTBarChartView
//
//  Created by 彭平军 on 2017/3/29.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTBarChart : UIView
// bar数量
@property (assign, nonatomic)NSInteger barNumber;
// bar间距
@property (assign, nonatomic)CGFloat barSpacing;
// bar颜色
@property (strong, nonatomic)UIColor *barColor;
// 动画执行时间
@property (assign, nonatomic)CGFloat barAnimationDuration;
// 数据数组
@property (strong, nonatomic)NSArray<NSNumber *> *barValues;
// value最大值(用于计算bar高度，barHeight = self.height * (barValue / maxBarValue)
@property (assign, nonatomic)CGFloat maxBarValue;


// 绘制barChart
- (void)drawBarChart;
// 删除barChart
- (void)cleanBarChart;

@end
