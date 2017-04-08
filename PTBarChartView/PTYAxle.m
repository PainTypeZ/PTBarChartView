//
//  PTYAxle.m
//  PTBarChartView
//
//  Created by 彭平军 on 2017/3/29.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import "PTYAxle.h"
#import "PTConstant.h"
@implementation PTYAxle
// 显示y轴标签
- (void)showYAxleTextsWithBarMaxHeight:(CGFloat)barMaxHeight {
    for (int i = 0; i < self.numberOfParts; i++) {
        // label相关设置
        UILabel *yAxleLabel = [[UILabel alloc] init];
//        UILabel *yAxleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yAxleLabelY, kYAxleWidth, kYAxleHeight)];
//        yAxleLabel.backgroundColor = [UIColor blackColor];
        yAxleLabel.text = self.texts[i];
        yAxleLabel.textColor = self.textColor;
        yAxleLabel.textAlignment = NSTextAlignmentRight;
        yAxleLabel.font = [UIFont systemFontOfSize:kYAxleFontSize];
        yAxleLabel.numberOfLines = 0;
        CGRect rect = [yAxleLabel.text boundingRectWithSize:CGSizeMake(kYAxleWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:yAxleLabel.font} context:nil];// 根据字体大小计算label高度
        CGFloat yAxleLabelY = barMaxHeight / (self.numberOfParts - 1) * (self.numberOfParts - i - 1) + (self.bounds.size.height - barMaxHeight - kXAxleHeight);
        yAxleLabel.frame = CGRectMake(0, yAxleLabelY, kYAxleWidth, rect.size.height);
        [self addSubview:yAxleLabel];
        // 添加刻度线
        UIView *scaleLine = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width - kScaleLineWidth, yAxleLabelY, kScaleLineWidth, kScaleLineHeight)];
        scaleLine.backgroundColor = yAxleLabel.textColor;
        [self addSubview:scaleLine];
    }
}

@end
