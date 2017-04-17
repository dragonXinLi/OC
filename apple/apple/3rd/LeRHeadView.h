//
//  LeRHeadView.h
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>

//视图返回上一级的方式
typedef enum
{
    DisappearWayPop,
    DisappearWayDismiss,
    DisappearWayNormal,
    DisappearWayNone,
}DisappearingWay;

@interface LeRHeadView : UIView
{
    UILabel *titleLabel;
    DisappearingWay disappearingWay;
    UILabel *lineLabel;
}


- (UILabel *)addTitle:(NSString *)title;
- (UIButton *)addbackButtonForDisappearingWay:(DisappearingWay)way;

- (UILabel *)returnTitleLabel;

@end
