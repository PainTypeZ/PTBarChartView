//
//  PTBarChartView.h
//  PTBarChartView
//
//  Created by 彭平军 on 2017/3/29.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTBarChartModel.h"

@interface PTBarChartView : UIView

@property (strong, nonatomic) PTBarChartModel *barChartModel;

// 绘制barChart
- (void)drawBarChart;
// 清除barChart
- (void)cleanBarChart;

@end
