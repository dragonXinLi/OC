//
//  Student+CoreDataProperties.h
//  
//
//  Created by lilong on 2018/7/4.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *age;

@property (nullable, nonatomic, retain) NSSet<Reminder *> *reminders;
@property (nullable, nonatomic, retain) Teacher *teacher;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addRemindersObject:(Reminder *)value;
- (void)removeRemindersObject:(Reminder *)value;
- (void)addReminders:(NSSet<Reminder *> *)values;
- (void)removeReminders:(NSSet<Reminder *> *)values;

@end

NS_ASSUME_NONNULL_END
