//
//  PTBarChart.m
//  PTBarChartView
//
//  Created by 彭平军 on 2017/3/29.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import "PTConstant.h"
#import "PTBarChart.h"
@interface PTBarChart()
/* 不要轻易改变barWidth的默认值 */
// bar宽度
@property (assign, nonatomic) CGFloat barWidth;
/* 不要改变barHeight的默认值 */
// bar高度
@property (assign, nonatomic) CGFloat barHeight;

@end
@implementation PTBarChart

#pragma mark - 重写默认构造方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        _barNumber = 10;
        _barSpacing = 2.0;
        _barColor = [UIColor greenColor];
        _barAnimationDuration = 1.5;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _barNumber = 10;
        _barSpacing = 2.0;
        _barColor = [UIColor greenColor];
        _barAnimationDuration = 1.5;
    }
    return self;
}

#pragma mark - public methods
// 绘制barChart
- (void)drawBarChart {
    // 计算bar宽度
    self.barWidth = (self.bounds.size.width - self.barNumber * self.barSpacing) / self.barNumber;
    // 初始化bezier曲线路径
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    NSInteger barNumber = self.barNumber < self.barValues.count ? self.barNumber : self.barValues.count;
    for (int i = 0; i < barNumber; i++) {
        CGFloat value = self.barValues[i].floatValue;
        [bezierPath moveToPoint:CGPointMake((self.barWidth + self.barSpacing) * i, self.bounds.size.height)];
        // 计算barHeight
        self.barHeight = self.bounds.size.height - value / self.maxBarValue * self.bounds.size.height;
        [bezierPath addLineToPoint:CGPointMake((self.barWidth + self.barSpacing) * i, self.barHeight)];
        
        // 创建显示value的label
        UILabel *valueLabel = [self creatValueLabelWithValue:value andSerialNumber:i];
        [self addSubview:valueLabel];
    }
    // 创建CAShapeLayer（含添加方法）
    CAShapeLayer *shapeLayer = [self createCAShapeLayerWithUIBezierPath:bezierPath];
    [self playAnimationWithCAShapeLayer:shapeLayer];
}
// 删除barChart
- (void)cleanBarChart {
    if (self.layer.sublayers) {
        [[self.layer.sublayers lastObject] removeFromSuperlayer];
        for (UILabel * valueLabel in self.subviews) {
            [valueLabel removeFromSuperview];
        }
    }
}

#pragma mark - private methods
// 创建valueLabel
- (UILabel *)creatValueLabelWithValue:(CGFloat)value andSerialNumber:(NSInteger)serialNumber {
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.barWidth + self.barSpacing) * serialNumber, self.barHeight - kValueLabelHeight, self.barWidth, kValueLabelHeight)];
    valueLabel.text = [NSString stringWithFormat:@"%.lf", value];
    valueLabel.textColor = [UIColor whiteColor];
    valueLabel.font = [UIFont systemFontOfSize:kValueLabelFontSize];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    return valueLabel;
}

// 创建CAShapeLayer并添加到父layer
- (CAShapeLayer *)createCAShapeLayerWithUIBezierPath:(UIBezierPath *)bezierPath {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = self.barWidth;
    layer.frame = CGRectMake(self.bounds.origin.x + _barWidth / 2, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    layer.path = bezierPath.CGPath;
    layer.strokeColor = self.barColor.CGColor;
    layer.lineJoin = kCALineCapRound;
    [self.layer addSublayer:layer];
    return layer;
}

// 播放绘制动画
- (void)playAnimationWithCAShapeLayer:(CAShapeLayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = self.barAnimationDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    [layer addAnimation:animation forKey:@"path"];
}
@end
