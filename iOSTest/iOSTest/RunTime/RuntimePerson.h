//
//  Person.h
//  iOSTest
//
//  Created by LL on 2018/8/26.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RuntimePerson : NSObject<NSCopying>
{
    NSString *privateName3;
}

@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSNumber *age;
@property (nonatomic , assign) CGFloat weight;

//默认关键字
@property CGFloat weight2; //(atomic,readwrite,assign)
@property NSNumber *age2; //(atomic,readwrite,strong)

//getter:不影响外界正常的setter和getter,但是在调用点语法(getter)或者valueForKey取值的时候，会执行getAge3方法，返回值作为该属性点的值,实际上_age3没被改变
@property (nonatomic , getter=getAge3 , strong) NSNumber *age3;
- (void)testAge3Value;

//readonly:外界不能调用setter方法，在调用点语法(getter)或者valueForKey取值的时候，会执行getAge3方法，返回值作为该属性点的值,实际上_age3没被改变
@property (nonatomic , readonly, getter=getAge3, strong) NSNumber *age4;

@end
