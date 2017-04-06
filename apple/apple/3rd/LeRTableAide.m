//
//  LeRTableAide.m
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRTableAide.h"

@implementation LeRTableAide


//tableView无内容时的空白提示
+ (UILabel *)generateEmptyLabel:(NSString *)text
{
    UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH-80, 0)];
    emptyLabel.backgroundColor = [UIColor clearColor];
    emptyLabel.text = text;
    emptyLabel.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    emptyLabel.font = [UIFont systemFontOfSize:19.0];
    emptyLabel.numberOfLines = 0;
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    [emptyLabel sizeToFit];
    [emptyLabel setOriginX:(SCREEN_WIDTH-emptyLabel.width)/2];
    [emptyLabel setOriginY:(SCREEN_HEIGHT-20-44-emptyLabel.height)/2];
    emptyLabel.hidden = YES;
    return emptyLabel;
}


+ (UIView *)generateEmptyViewWithText:(NSString *)text frame:(CGRect)frame
{
    if (CGRectIsEmpty(frame)) {
        frame = CGRectMake(0, HEADVIEW_HEIGT, SCREEN_FIXED_WIDTH, SCREEN_FIXED_HEIGHT-HEADVIEW_HEIGT);
    }
    UIView *emptyView = [[UIView alloc] initWithFrame:frame];
    emptyView.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipsLabel = [LeRTableAide generateEmptyLabel:text];
    tipsLabel.hidden = NO;
    tipsLabel.originY = (emptyView.height-tipsLabel.height)/2.0;
    tipsLabel.backgroundColor = [UIColor clearColor];
    [emptyView addSubview:tipsLabel];
    
    return emptyView;
}


//在emptyLabel之后的子提示
+ (UILabel*)generateSubTipsLabel:(NSString*)text andEmptyLabel:(UILabel*)label
{
    UILabel *subTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH-80, 0)];
    subTipsLabel.backgroundColor = [UIColor clearColor];
    subTipsLabel.text = text;
    subTipsLabel.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    subTipsLabel.font = [UIFont systemFontOfSize:14.0];
    subTipsLabel.numberOfLines = 0;
    subTipsLabel.textAlignment = NSTextAlignmentCenter;
    [subTipsLabel sizeToFit];
    [subTipsLabel setOriginX:(SCREEN_WIDTH-subTipsLabel.width)/2];
    [subTipsLabel setOriginY:CGRectGetMaxY(label.frame)+5];
    subTipsLabel.hidden = YES;
    return subTipsLabel;
}
@end
