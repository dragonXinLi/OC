//
//  BitOperationViewController.m
//  iOSTest
//
//  Created by lilong on 2018/6/28.
//  Copyright © 2018年 LL. All rights reserved.
//

#import "BitOperationViewController.h"
#import "BCMath.h"
typedef NS_OPTIONS(NSInteger, SeasonType) {
    SeasonTypeSpring = 1<<0,//春 0001 <<左移运算
    SeasonTypeSummer = 1<<1,//夏 0010
    SeasonTypeAutumn = 1<<2,//秋 0100
    SeasonTypeWinter = 1<<3,//冬 1000
};


@interface BitOperationViewController ()
@property (nonatomic, weak) NSString * a;
@property (nonatomic, weak) BCMath *b;

@end

@implementation BitOperationViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //定义一个SeasonType表示春夏两个季节
    SeasonType seasonType = SeasonTypeSpring | SeasonTypeSummer;
    //对应的进行按位或运算SeasonType = 0001 | 0010 = 0011
    
    //添加冬季
    seasonType = seasonType | SeasonTypeWinter;
//    seasonType |= SeasonTypeWinter;
    //0011 | 1000 = 1011 ,此时seasonType 同时表示了3种枚举 分别是 春夏冬
    
    //去掉冬季
    seasonType = seasonType & ~SeasonTypeWinter;
//    seasonType &= ~SeasonTypeWinter;
    //1011 & (~1000) = 1011 & 0111 = 0011;此时又表示春夏两季节
    
    if(seasonType & SeasonTypeSpring)
    {
        NSLog(@"Spring");
    }
    if(seasonType & SeasonTypeSummer)
    {
        NSLog(@"Sunmer");
    }
    if(seasonType & SeasonTypeAutumn)
    {
        NSLog(@"Autumn");
    }
    if(seasonType & SeasonTypeWinter)
    {
        NSLog(@"Winter");
    }
    int a = 1 ,b = 2;
    a = a ^ b ; // a = 0001 ^ 0010 = 0011
    b = a ^ b ; // b = 0011 ^ 0010 = 0001
    a = a ^ b ; // a = 0011 ^ 0001 = 0010
//    a ^= b;
//    b ^= a;
//    a ^= b;
    
    if(0)
    {
        NSString *str = [[NSString alloc] initWithFormat:@"aa"];
        BCMath *p = [[BCMath alloc] init];
        _a = str;
        _b = p;
        
        NSLog(@"str --------%@",_a);
        NSLog(@"obj --------%@",_b);
        
        /*
         字符串是字符串常量，在编译的时候已经确定了他的值，不受内存管理
         编译器在编译的时候，把这个变量值添加到常量表里面，常量表里面的变量在APP结束之后才会被释放，指向这块常量表的指针都不受retainCount管理
         */
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"str --------%@",_a);
    NSLog(@"obj --------%@",_b);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"str --------%@",_a);
    NSLog(@"obj --------%@",_b);
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Initial Methods

#pragma mark - Override Methods

#pragma mark - Target Methods

#pragma mark - Privater Methods

#pragma mark - Notification Methods

#pragma mark - KVO Methods

#pragma mark - UITableViewDelegate, UITableViewDataSource

#pragma mark - Setter Getter Methods

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
