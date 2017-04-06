//
//  LeRBlankRefreshView.m
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRBlankRefreshView.h"

@implementation LeRBlankRefreshView


- (id)initWithRealFrame:(CGRect)realFrame
{
    self = [self initWithFrame:realFrame];
    if(self)
    {
        [label setWidth:realFrame.size.width - 80];
        [label setOriginX:(realFrame.size.width - label.width)/2.0];
        [label setOriginY:(realFrame.size.height - label.height)/2.0];
        
        indicatorView.center = CGPointMake(realFrame.size.width / 2, realFrame.size.height / 2);
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 44 + STATUSBAR_SHIFT, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - STATUSBAR_SHIFT)];
    
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 80, 0)];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedStringFromTable(@"Touch Reload", @"Common", nil);
        label.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:19];
        [label sizeToFit];
        [label setOriginX:(SCREEN_WIDTH - label.width)/2];
        [label setOriginY:(187 * SCREEN_WIDTH / 320)];
        [self addSubview:label];
        
        indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-44-STATUSBAR_SHIFT);
        [indicatorView startAnimating];
        [self addSubview:indicatorView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tap];
        
        self.refreshState = RefreshStateRefreshing;
    }
    return  self;
}


- (void)tapView:(UITapGestureRecognizer *)recognizer
{
    if(self.refreshState == RefreshStateFailed)
    {
        self.refreshState = RefreshStateRefreshing;
        [self.delegate tryToReloadFailedDate];
    }
}


- (void)setRefreshState:(RefreshState)refreshState
{
    switch (refreshState) {
        case RefreshStateNormal:
            self.hidden = YES;
            break;
        case RefreshStateRefreshing:
            self.hidden = NO;
            [indicatorView startAnimating];
            label.hidden = YES;
            break;
        case RefreshStateFailed:
            self.hidden = NO;
            [indicatorView stopAnimating];
            label.hidden = NO;
            break;
        case  RefreshStateBlank:
            label.hidden = YES;
            [indicatorView stopAnimating];
            self.hidden = NO;
            break;
        default:
            break;
    }
    _refreshState = refreshState;
}


- (UILabel *)getFailedLabel
{
    return label;
}


- (UIActivityIndicatorView *)getIndicatorView
{
    return indicatorView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
