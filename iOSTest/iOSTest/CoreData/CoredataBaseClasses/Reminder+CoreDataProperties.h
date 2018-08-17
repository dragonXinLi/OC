//
//  Reminder+CoreDataProperties.h
//  
//
//  Created by lilong on 2018/7/4.
//
//

#import "Reminder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Reminder (CoreDataProperties)

+ (NSFetchRequest<Reminder *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *time;
@property (nullable, nonatomic, retain) Student *student;
@property (nullable, nonatomic, retain) Teacher *teacher;

@end

NS_ASSUME_NONNULL_END
