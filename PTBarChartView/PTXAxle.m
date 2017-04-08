//
//  PTXAxle.m
//  PTBarChartView
//
//  Created by 彭平军 on 2017/3/29.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import "PTXAxle.h"
#import "PTConstant.h"
@implementation PTXAxle
// 显示x轴标签
- (void)showXAxleTextsWithBarSpacing:(CGFloat)barSpacing {
    CGFloat xAxleLabelWidth = (self.bounds.size.width - self.numberOfParts * barSpacing - kYAxleLineWidth) / self.numberOfParts;
    for (int i = 0; i < self.numberOfParts; i++) {
        UILabel *xAxleLabel = [[UILabel alloc] initWithFrame:CGRectMake((xAxleLabelWidth + barSpacing) * i + kYAxleLineWidth, self.bounds.origin.y, xAxleLabelWidth, kXAxleHeight)];
//        xAxleLabel.backgroundColor = [UIColor whiteColor];
        xAxleLabel.text = self.texts[i];
        xAxleLabel.textColor = self.textColor;
        xAxleLabel.textAlignment = NSTextAlignmentCenter;
        xAxleLabel.font = [UIFont systemFontOfSize:kXAxleLabelFontSize];
        [self addSubview:xAxleLabel];
    }
}

@end
