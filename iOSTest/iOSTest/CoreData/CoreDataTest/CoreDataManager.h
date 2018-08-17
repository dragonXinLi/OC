//
//  CoreDataManager.h
//  iOSTest
//
//  Created by lilong on 2018/7/4.
//  Copyright © 2018年 lilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class  Reminder;
@interface CoreDataManager : NSObject<NSCopying>

@property(strong , nonatomic , readonly) NSManagedObjectModel *managedObjectModel; //mom:管理数据模型
@property(strong , nonatomic , readonly) NSManagedObjectContext *managedObjectContext; //moc:管理数据内容
@property(strong , nonatomic , readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator; //psc:持久化数据助理

+ (instancetype)shareManager;

// *****禁用*****
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

-(instancetype)initWithTest:(NSString *)test NS_DESIGNATED_INITIALIZER;
-(instancetype)initWithTest2:(NSString *)test;

//- (void)insertData:(NSString *)tempName;
-(void)insertData:(NSNumber *)tempAge;

- (void)deleteData;

- (void)deleteData:(NSNumber *)tempAge;

- (void)queryData;

- (void)queryData:(NSNumber *)tempAge;

- (void)updateData:(NSNumber *)tempAge;


-(Reminder *)insertDate:(NSDate*)date;
@end
