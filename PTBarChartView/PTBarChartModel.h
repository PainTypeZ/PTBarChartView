//
//  PTBarChartModel.h
//  PTBarChartView
//
//  Created by 彭平军 on 2017/4/5.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PTBarChartModel : NSObject
/* 共用数据 */
@property (assign, nonatomic) CGFloat maxBarValue;// bar最大值
@property (assign, nonatomic) NSInteger barNumber;// bar数量
@property (assign, nonatomic) CGFloat barSpacing;// bar间距
/* PTBarChart自有的数据 */
@property (strong, nonatomic) UIColor *barColor;// bar颜色
@property (assign, nonatomic) CGFloat barAnimationDuration;// 动画执行时间
@property (strong, nonatomic) NSArray<NSNumber *> *barValues;// 数据数组
@property (strong, nonatomic) UIColor *barChartColor;// barChart背景颜色
/* PTXAxle自有的数据 */
@property (assign, nonatomic) NSUInteger numberOfXAxleParts;// x轴分段数
@property (strong, nonatomic) NSArray<NSString *> *xAxleTexts;// x轴文本
@property (strong, nonatomic) UIColor *xAxleColor;// x轴区域背景颜色
@property (strong, nonatomic) UIColor *xAxleTextColor;// x轴标签文字颜色
/* PTYAxle自有的数据 */
@property (assign, nonatomic) NSUInteger numberOfYAxleParts;// y轴分段数
@property (strong, nonatomic) NSArray *yAxleTexts;// y轴文本
@property (strong, nonatomic) UIColor *yAxleColor;// y轴区域背景颜色（包含原点区域）
@property (strong, nonatomic) UIColor *yAxleTextColor;// y轴标签文字颜色
/* xy轴线颜色 */
@property (strong, nonatomic) UIColor *axleLineColor;// y轴线颜色
@end
