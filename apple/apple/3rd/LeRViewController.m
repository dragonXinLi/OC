//
//  LeRViewController.m
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "LeRViewController.h"

@interface LeRViewController ()<UIGestureRecognizerDelegate>
{
    __weak id popGestureDelegate;
}

@end

@implementation LeRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated
{
    //继承了此类的子类，都会添加一个监听app是否进入前台的通知和后台的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForeground:) name:APP_ENTER_FOREGROUND_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [super viewDidAppear:animated];
    
    if(self.noNeedPopGesture == YES && ISIOS7)
    {
        //>=iOS7的设备禁止手势返回
        __weak typeof (self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if([weakSelf.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
            {
                weakSelf.navigationController.interactivePopGestureRecognizer.enabled = NO;
            }
        });
    }
}


- (void)enterForeground:(NSNotification *)notification
{
    [self appEnterForeground];
}


- (void)enterBackground:(NSNotification *)notification
{
    [self appEnterBackground];
}


- (void)appEnterForeground
{
    
}


- (void)appEnterBackground
{

}


-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:APP_ENTER_FOREGROUND_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil
     ];
    
    [super viewDidDisappear:animated];
    
    if(self.noNeedPopGesture == YES && ISIOS7)
    {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}


-(id)initWithType:(NSString *)viewType
{
    self = [super init];
    if(self)
    {
        if([viewType isEqualToString:@"viewSecond"])
        {
            // $$$$$$$$$$$$ 1
            self.viewType = @"viewSecond";
        }
    }
    return  self;
}


- (void)backToRootViewController
{
    UIViewController *viewController = self;
    while (viewController.presentingViewController) {
        if([viewController isKindOfClass:[LeRViewController class]])
        {
            viewController = viewController.presentingViewController;
        }else
        {
            break;
        }
    }
    
    if(viewController)
    {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)viewWillLayoutSubviews
{
    UIView *dimmingView;
    for (UIView *subView in self.view.subviews) {
        if([subView isKindOfClass:NSClassFromString(@"UISearchDisplayControllerContainerView")])
        {
            dimmingView = [self searchDimmingView:subView];
            if(dimmingView)
            {
                break;
            }
        }
    }
}


- (UIView *)searchDimmingView:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        if([subView isKindOfClass:NSClassFromString(@"_UISearchDisplayControllerDimmingView")])
        {
            //_UISeachDisplayControllerDimmingView(透明遮盖)向下移动20(>=ios7)
            CGRect frame = subView.frame;
            frame.origin.y = STATUSBAR_SHIFT;
            subView.frame = frame;
            return subView;
        }else
        {
            [self searchDimmingView:subView];
        }
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
