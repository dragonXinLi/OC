//
//  LeRAlert.m
//  apple
//
//  Created by sangfor on 17/4/11.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRAlert.h"

@interface LeRAlert()

@property (nonatomic , strong) UIActivityIndicatorView *activityView;
@end

@implementation LeRAlert

@synthesize activityView;

+ (LeRAlert *)sharedPromptView
{
    LeRAlert *sharedView;
    sharedView = [[LeRAlert alloc] initWithFrame:CGRectMake(0, 0, SCREEN_FIXED_WIDTH, SCREEN_HEIGHT)];
    return sharedView;
}


- (id)initWithTitle:(NSString *)title andAlertPromptType:(AlertPromptType)type delegate:(id)delegate
{
    self = [LeRAlert sharedPromptView];
    if(self)
    {
        self.alertView = [self addViewWithTitle:title andAlertPromptType:type];
        alertType = AlertTypePrompt;
        [self addSubview:self.alertView];
    }
    return self;
}


- (UIView *)addViewWithTitle:(NSString *)title andAlertPromptType:(AlertPromptType)type
{
    UIFont *textFont = [UIFont systemFontOfSize:kAlertViewTextFont];
    CGSize widthSize = [title sizeWithFont:textFont forWidth:(kAlertViewMaxWidth - kAlertViewTextMarginLeftRight) lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat alertWidth = MIN(MAX(widthSize.width + kAlertViewTextMarginLeftRight, kAlertViewMinWidth), kAlertViewMaxWidth);
    CGFloat textWidth = alertWidth - kAlertViewTextMarginLeftRight;
    CGSize heightSize = [title sizeWithFont:textFont constrainedToSize:CGSizeMake(textWidth, 480) lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat textHeight = MAX(heightSize.height, kAlertViewTextViewMinHeight);
    if(title.length == 0)
    {
        textHeight = 0;
    }
    
    CGFloat alertHeight = kAlertViewTop + kAlertViewPromptHeight + kAlertViewTextMarge + textHeight + kAlertViewBottomMarge;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, alertWidth, alertHeight)];
    img.center = self.center;
    img.backgroundColor = [UIColor colorWithHexString:kAlertViewColor alpha:kAlertViewAlpha];
    img.layer.cornerRadius = kAlertViewRations;
    UIImageView *tabImageView = [[UIImageView alloc] initWithFrame:CGRectMake((alertWidth - kAlertViewPromptHeight)/2, kAlertViewTop, kAlertViewPromptHeight, kAlertViewPromptHeight)];
    tabImageView.backgroundColor = [UIColor clearColor];
    if(type == AlertPromptTypeError)
    {
        tabImageView.image = [UIImage imageNamed:@"AlertTip_I.png"];
    }else if (type == AlertPromptTypeSuccess)
    {
        tabImageView.image = [UIImage imageNamed:@"AlertOK.png"];
    }else if(type == AlertPromptTypeLoading)
    {
        activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, kAlertViewPromptHeight, kAlertViewPromptHeight)];
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [tabImageView addSubview:activityView];
        [activityView startAnimating];
    }
    
    promptType = type;
    [img addSubview:tabImageView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewTextMarginLeftRight/2.0, kAlertViewTop + kAlertViewPromptHeight + kAlertViewTextMarge, textWidth, textHeight)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexString:kAlertViewTextColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = textFont;
    titleLabel.numberOfLines = 0;
    titleLabel.hidden = title.length==0;
    titleLabel.backgroundColor = [UIColor clearColor];
    if (title.length == 0) {
        tabImageView.centerY = alertHeight/2;
    }
    [img addSubview:titleLabel];
    return img;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
