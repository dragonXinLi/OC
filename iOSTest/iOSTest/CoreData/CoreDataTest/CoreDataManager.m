//
//  CoreDataManager.m
//  iOSTest
//
//  Created by lilong on 2018/7/4.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import "CoreDataManager.h"
#import "Teacher+CoreDataProperties.h"
#import "Reminder+CoreDataProperties.h"
#import "Student+CoreDataProperties.h"
static CoreDataManager *shareManager = nil;


@implementation CoreDataManager

@synthesize managedObjectContext =_managedObjectContext;

@synthesize managedObjectModel = _managedObjectModel;

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

////实例化对象
-(instancetype)initWithTest:(NSString *)test
{
    self=[super init];
    if (self) {

    }
    return self;
}

//创建数据库管理者单例
+(instancetype)shareManager
{
    //这里用到了双重锁定检查
    if(shareManager==nil){
        @synchronized(self){
            if(shareManager==nil){
                shareManager =[[[self class]alloc]initWithTest:nil];
            }
        }
    }
    return shareManager;
}

-(id)copyWithZone:(NSZone *)zone
{
    
    return shareManager;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    if(shareManager==nil){
        shareManager =[super allocWithZone:zone];
    }
    return shareManager;
}

//托管对象
-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel!=nil) {
        return _managedObjectModel;
    }
    
    NSURL* modelURL=[[NSBundle mainBundle] URLForResource:@"iOSTest" withExtension:@"momd"];
    _managedObjectModel=[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

//托管对象上下文
-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext!=nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator* coordinator=[self persistentStoreCoordinator];
    if (coordinator!=nil) {
        _managedObjectContext=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];//NSMainQueueConcurrencyType NSPrivateQueueConcurrencyType
        
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

//持久化存储协调器
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator!=nil) {
        return _persistentStoreCoordinator;
    }
    NSString* docs=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSURL* storeURL=[NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"iOSTest.sqlite"]];
    NSLog(@"path is %@",storeURL);
    NSError* error=nil;
    _persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    return _persistentStoreCoordinator;
}

//插入数据 moudle:(NSString *)entity
-(void)insertData:(NSNumber *)tempAge
{
    //读取类
    Teacher *car=[NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    
    //因为coredata自动生成的mo文件属性是@dynamic,所以系统不会生成setter,getter方法
    [car setValue:@"hh" forKey:@"name"];
    [car setValue:tempAge forKey:@"age"];
    [car setValue:[NSSet setWithArray:@[[self insertDateWithReminder:[NSDate date]]]]  forKey:@"reminders"];
    [car setValue:[NSSet setWithArray:@[[self insertDateWithStudent:@(tempAge.integerValue + 100)]]]  forKey:@"students"];

    //保存
    NSError *error = NULL;
    NSManagedObjectContext *moc = self.managedObjectContext;
    if (moc && [moc hasChanges] ) {
        if (![moc save:&error]) {
            NSLog(@"Error %@, %@", error, [error localizedDescription]);
            abort();
        }
    }

}

//删除数据
-(void)deleteData
{
    //创建读取类
    NSEntityDescription *entity =[NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    
    //创建连接
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    //启动查询
    NSError *error;
    NSArray *deleteArr=[self.managedObjectContext executeFetchRequest:request error:&error];
    if(deleteArr.count){
        for (Teacher *car in deleteArr) {
            [self.managedObjectContext deleteObject:car];
        }
        NSError *error;
        [self.managedObjectContext save:&error];
    }else{
        NSLog(@"未查询到可以删除的数据");
    }
    
}

//删除数据
-(void)deleteData:(NSNumber *)tempAge
{
    //创建读取类
    NSEntityDescription *entity =[NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    
    //创建连接
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    //创建检索条件
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"age=%@",tempAge];
    [request setPredicate:predicate];
    
    //启动查询
    NSError *error;
    NSArray *deleteArr=[self.managedObjectContext executeFetchRequest:request error:&error];
    if(deleteArr.count){
        for (Teacher *car in deleteArr) {
            [self.managedObjectContext deleteObject:car];
        }
        NSError *error;
        [self.managedObjectContext save:&error];
    }else{
        NSLog(@"未查询到可以删除的数据");
    }
}


//查询数据
-(void)queryData
{
    //创建读取类
    NSEntityDescription *entity =[NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    
    //创建连接
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    //启动查询
    NSError *error;
    NSArray *carArr=[self.managedObjectContext executeFetchRequest:request error:&error];
    for(Teacher *car in carArr){
        NSLog(@"car---->%@",car.age);
    }
    
}

-(void)queryData:(NSNumber *)tempAge
{
    //创建读取类
    NSEntityDescription *entity =[NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    
    //创建连接
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    //创建检索条件
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"age=%@",tempAge];
    [request setPredicate:predicate];
    
    //启动查询
    NSError *error;
    NSArray *carArr=[self.managedObjectContext executeFetchRequest:request error:&error];
    for(Teacher *car in carArr){
        NSLog(@"car---->%@",car.age);
    }
    
}

//更新数据
-(void)updateData:(NSNumber *)tempAge
{
    //创建读取类
    NSEntityDescription *entity =[NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    
    //创建连接
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    //创建检索条件
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"age=%@",tempAge];
    [request setPredicate:predicate];
    
    //启动查询
    NSError *error;
    NSArray *deleteArr=[self.managedObjectContext executeFetchRequest:request error:&error];
    if(deleteArr.count){
        for (Teacher *car in deleteArr) {
            car.age=@(50000000);
        }
        NSError *error;
        [self.managedObjectContext save:&error];
    }else{
        NSLog(@"未查询到可以删除的数据");
    }
    
}


//插入数据
-(Reminder *)insertDateWithReminder:(NSDate*)date
{
    //读取类
    Reminder *car=[NSEntityDescription insertNewObjectForEntityForName:@"Reminder" inManagedObjectContext:self.managedObjectContext];
    
    //因为coredata自动生成的mo文件属性是@dynamic,所以系统不会生成setter,getter方法
    [car setValue:date forKey:@"time"];
    
    //保存
    NSError *error = NULL;
    NSManagedObjectContext *moc = self.managedObjectContext;
    if (moc && [moc hasChanges] ) {
        if (![moc save:&error]) {
            NSLog(@"Error %@, %@", error, [error localizedDescription]);
            abort();
        }
    }
    return car;
}

//插入数据
-(Student *)insertDateWithStudent:(NSNumber *)tempAge
{
    //读取类
    Student *car=[NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    
    //因为coredata自动生成的mo文件属性是@dynamic,所以系统不会生成setter,getter方法
    [car setValue:tempAge forKey:@"age"];
    
    //保存
    NSError *error = NULL;
    NSManagedObjectContext *moc = self.managedObjectContext;
    if (moc && [moc hasChanges] ) {
        if (![moc save:&error]) {
            NSLog(@"Error %@, %@", error, [error localizedDescription]);
            abort();
        }
    }
    return car;
}

@end
