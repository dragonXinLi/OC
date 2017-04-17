//
//  LeRHeadView.m
//  apple
//
//  Created by sangfor on 17/4/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRHeadView.h"
#import "LeRTitleButton.h"

#define HEAD_TITLE_WIDTH (SCREEN_FIXED_WIDTH - 160)
NSString *const HeadViewBackgroundColor = @"#F9F9F9";
NSString *const HeadViewSeparetorLineColor = @"#E4E4E4";

NSString *const TitleButtonColor = @"#EB5A39";


const NSInteger BackButtonTag = 1110;
const NSInteger RightButtonTag = 1111;
const NSInteger MiddleButtonTag = 1112;

@implementation LeRHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_FIXED_WIDTH, 44 + STATUSBAR_SHIFT)];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithHexString:HeadViewBackgroundColor];
        [self addSeparetorLine];
        self.clipsToBounds = NO;
    }
    return  self;
}


//添加底部分割线
- (void)addSeparetorLine
{
    if(lineLabel)
    {
        [lineLabel removeFromSuperview];
        lineLabel = nil;
    }
    
    lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - UNIT_PIXEL, SCREEN_FIXED_WIDTH, UNIT_PIXEL)];
    lineLabel.backgroundColor = [UIColor colorWithHexString:HeadViewSeparetorLineColor];
    [self addSubview:lineLabel];
}


- (UILabel *)addTitle:(NSString *)title
{
    if(titleLabel)
    {
        titleLabel.text = title;
        return titleLabel;
    }
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, STATUSBAR_SHIFT, HEAD_TITLE_WIDTH, 44)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexString:kHeadViewTitleColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:19];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLabel];
    return titleLabel;
}


- (UIButton *)addbackButtonForDisappearingWay:(DisappearingWay)way
{
    disappearingWay = way;
    UIButton *leftButton = [self addbackButton];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    return leftButton;
}


- (void)back:(UIButton *)button
{
    
}


- (UIButton *)addbackButton
{
    UIButton *leftButton;
    if(disappearingWay == DisappearWayDismiss)
    {
        leftButton = [LeRHeadView addLeftButtonWithTitle:NSLocalizedStringFromTable(@"Cancel", @"Common", nil)];
    }else
    {
        leftButton = [LeRHeadView addLeftButtonWithImage:[UIImage imageNamed:@"TBBackBlack.png"]];
    }
    leftButton.tag = BackButtonTag;
    [self addSubview:leftButton];
    return leftButton;
}


+ (UIButton *)addLeftButtonWithTitle:(NSString *)string
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = BackButtonTag;
    [btn setTitle:string forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [btn setTitleColor:[UIColor colorWithHexString:TitleButtonColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:TitleButtonColor alpha:0.4] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    return btn;
}


+ (UIButton *)addLeftButtonWithImage:(UIImage *)image
{
    LeRTitleButton *btn = [[LeRTitleButton alloc] initWithLeftImage:image];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:[UIColor colorWithHexString:TitleButtonColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:TitleButtonColor alpha:0.4] forState:UIControlStateNormal];
    return btn;
}


- (UILabel *)returnTitleLabel
{
    return titleLabel;
}
@end
