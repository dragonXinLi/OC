//
//  HashViewController.m
//  iOSTest
//
//  Created by LL on 2018/9/1.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "HashViewController.h"
#import "HashPerson.h"
#import "HashSubPerson.h"
@interface HashViewController ()

@end

@implementation HashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (0) {
        [self equalColor];
    }
    
    if (0) {
        [self setDictOperation];
    }
    
    if (0) {
        [self addSet];
    }
    
    if (1) {
        HashSubPerson *p = [[HashSubPerson alloc] init];
        NSLog(@"Person:%ld",(NSUInteger)p);
        NSLog(@"PersonSub:%ld",p.hash);
        //对象的内存地址和该hash值相同
//        2018-09-02 14:34:34.286721+0800 iOSTest[50113:29640686] Person:105553120595776
//        2018-09-02 14:34:34.288919+0800 iOSTest[50113:29640686] PersonSub:105553120595776
    }

    if (0) {
        [self equalString];
    }
    
    if (0) {
        [self equalPerson];
    }
}

- (void)equalColor
{
    UIColor *color1 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    NSLog(@"color1 == color2 = %@",color1 == color2 ? @"YES":@"NO");
    NSLog(@"[color1 isEqual:color2] = %@",[color1 isEqual:color2] ? @"YES":@"NO");
//    2018-09-02 11:56:41.300113+0800 iOSTest[43852:29167085] color1 == color2 = NO
//    2018-09-02 11:56:41.300322+0800 iOSTest[43852:29167085] [color1 isEqual:color2] = YES
}

- (void)setDictOperation
{
    HashPerson *person1 = [[HashPerson alloc] initWithName:@"ll" age:@"22" immutable:YES];
    HashPerson *person2 = [[HashPerson alloc] initWithName:@"ll" age:@"22" immutable:YES];
    
    NSMutableArray *array1 = @[].mutableCopy;
    [array1 addObject:person1];
    NSMutableArray *array2 = @[].mutableCopy;
    [array2 addObject:person2];
    NSLog(@"array end------------");
    
    NSMutableSet *set1 = [NSMutableSet set];
    [set1 addObject:person1];
    NSMutableSet *set2 = [NSMutableSet set];
    [set2 addObject:person2];
    NSLog(@"set end ------------");
    
    NSMutableDictionary *dictValue1 = [NSMutableDictionary dictionary];
    [dictValue1 setObject:person1 forKey:@"ll"];
    NSMutableDictionary *dictValue2 = [NSMutableDictionary dictionary];
    [dictValue2 setObject:person2 forKey:@"ll"];
    NSLog(@"dict value end------");
    
    NSMutableDictionary *dictKey1 = [NSMutableDictionary dictionary];
    [dictKey1 setObject:@"ll" forKey:person1];
    NSMutableDictionary *dictKey2 = [NSMutableDictionary dictionary];
    [dictKey2 setObject:@"ll" forKey:person2];
    NSLog(@"dict key end --------");
    
//    2018-09-02 13:42:47.996374+0800 iOSTest[47948:29477137] array end------------
//    2018-09-02 13:42:47.996580+0800 iOSTest[47948:29477137] hash = 105553118564704
//    2018-09-02 13:42:47.996718+0800 iOSTest[47948:29477137] hash = 105553118564768
//    2018-09-02 13:42:47.998172+0800 iOSTest[47948:29477137] set end ------------
//    2018-09-02 13:42:47.999108+0800 iOSTest[47948:29477137] dict value end------
//    2018-09-02 13:42:47.999322+0800 iOSTest[47948:29477137] hash = 105553118564704
//    2018-09-02 13:42:47.999628+0800 iOSTest[47948:29477137] hash = 105553118564768
//    2018-09-02 13:42:47.999892+0800 iOSTest[47948:29477137] dict key end --------
}

 - (void)addSet
{
    HashPerson *person1 = [[HashPerson alloc] initWithName:@"ll" age:@"22" immutable:YES];
    HashPerson *person2 = [[HashPerson alloc] initWithName:@"ll" age:@"22" immutable:YES];
    
    NSLog(@"[person1 isEqual:person2] = %@",[person1 isEqual:person2]?@"YES":@"NO");
    
    NSMutableSet *set = [NSMutableSet set];
    [set addObject:person1];
    [set addObject:person2];
    
    NSLog(@"set count = %ld",set.count);

    //打印了不同的set.count，因为重载了isEqual：方法却没有自定义hash的实现（要不是用的默认或者未实现）
//    2018-09-02 14:23:35.627236+0800 iOSTest[49357:29587596] [person1 isEqual:person2] = YES
//    2018-09-02 14:23:35.627383+0800 iOSTest[49357:29587596] hash = 105553118603072
//    2018-09-02 14:23:35.627604+0800 iOSTest[49357:29587596] hash = 105553118593152
//    2018-09-02 14:23:35.627706+0800 iOSTest[49357:29587596] set count = 2
//    2018-09-02 14:23:38.067058+0800 iOSTest[49357:29587596] [person1 isEqual:person2] = YES
//    2018-09-02 14:23:38.067200+0800 iOSTest[49357:29587596] hash = 105827998568768
//    2018-09-02 14:23:38.067350+0800 iOSTest[49357:29587596] hash = 105827998563776
//    2018-09-02 14:23:38.068323+0800 iOSTest[49357:29587596] set count = 1
    
    //打印了相同的set.count,因为重载了isEqual：又实现了自定义hash的实现（采用属性确定hash值）
//    2018-09-02 14:26:58.835114+0800 iOSTest[49756:29616388] [person1 isEqual:person2] = YES
//    2018-09-02 14:26:58.835257+0800 iOSTest[49756:29616388] has = 474044
//    2018-09-02 14:26:58.835542+0800 iOSTest[49756:29616388] has = 474044
//    2018-09-02 14:26:58.836162+0800 iOSTest[49756:29616388] set count = 1
//    2018-09-02 14:27:02.616187+0800 iOSTest[49756:29616388] [person1 isEqual:person2] = YES
//    2018-09-02 14:27:02.616330+0800 iOSTest[49756:29616388] has = 474044
//    2018-09-02 14:27:02.616443+0800 iOSTest[49756:29616388] has = 474044
//    2018-09-02 14:27:02.617145+0800 iOSTest[49756:29616388] set count = 1
}

- (void)equalString
{
    NSString *name1 = @"123";
    NSString *name2 = @"123";
    
    NSLog(@"name1:%p == name2:%p == %@",name1,name2,name1 == name2 ? @"YES":@"NO" );
    /*
     (lldb) po name1.hash
     487557729 --- 内存地址：name1:0x109fb1308 == name2:0x109fb1308 == YES
     (lldb) po name2.hash
     487557729 --- 内存地址：name1:0x109fb1308 == name2:0x109fb1308 == YES
     */
    NSLog(@"[name1 isEqual name2] == %@",[name1 isEqual:name2] ? @"YES":@"NO" );
}

- (void)equalPerson
{
    /*
     可变/不可变对象：决定该对象的属性或者里面的值是否能够修改
     深拷贝/浅拷贝：决定该对象的引用计数是否增加或者开辟内存空间
     */
    HashPerson *p1 = [[HashPerson alloc] initWithName:@"ll" age:@"22" immutable:YES];
    HashPerson *p2 = p1.copy;
    HashPerson *p3 = p1.mutableCopy;
    NSLog(@"p1 : %@",p1);
    NSLog(@"p2 : %@",p2);
    NSLog(@"p3 : %@",p3);
//    p2.name = @"xx";
//    p3.name = @"xx2";
    NSAssert(1, nil);
    
    NSMutableArray *arrayM = @[].mutableCopy;
    [arrayM addObject:p1];
    [arrayM addObject:p2];
    
    NSMutableArray *arrayM2 = arrayM.mutableCopy;
    NSArray *arrayM3 = arrayM.copy;

    [arrayM enumerateObjectsUsingBlock:^(HashPerson *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([p2 isEqual:p1]) {
            NSLog(@"p2== p1");
        }
        
        if ([p3 isEqual:p1]) {
            NSLog(@"p3== p1");
        }
        
        if ([p3 isEqual:p2]) {
            NSLog(@"p3== p2");
        }
    }];
    
    if ([arrayM2 isEqualToArray:arrayM]) {
        NSLog(@"arrayM == arrayM2");
    }
    
    if ([arrayM3 isEqualToArray:arrayM]) {
        NSLog(@"arrayM == arrayM3");
    }
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
