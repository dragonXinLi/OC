//
//  NSObject+RuntimeLog.m
//  iOSTest
//
//  Created by lilong on 2018/8/27.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "NSObject+RuntimeLog.h"

@implementation NSObject (RuntimeLog)

//自定打印属性字符串
+ (void)resolveDict:(NSDictionary *)dict
{
    //拼接字符串代码
    NSMutableString *strM = [NSMutableString string];
    //遍历字典，把字典中的所有key取出来，生成对应的属性代码
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //属性类型
        NSString *type;
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            type = @"NSString";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")])
        {
            type = @"NSArray";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")])
        {
            type = @"int";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")])
        {
            type = @"NSDictionary";
        }
        
        //属性字符串
        NSString *str;
        //iOS8才能用
//        [type containsString:str]
        if ([type rangeOfString:@"NS"].location != NSNotFound) {
            str = [NSString stringWithFormat:@"@property (nonatomic , strong) %@ *%@;",type,key];
        }else
        {
            str = [NSString stringWithFormat:@"@property (nonatomic , assign) %@ %@;",type , key];
        }
        
        //每生成属性字符串，就自动换行
        [strM appendFormat:@"\n%@\n",str];
    }];
    
    NSLog(@"%@",strM);
    
}

@end
