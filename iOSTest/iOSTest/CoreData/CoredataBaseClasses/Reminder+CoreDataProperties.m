//
//  Reminder+CoreDataProperties.m
//  
//
//  Created by lilong on 2018/7/4.
//
//

#import "Reminder+CoreDataProperties.h"

@implementation Reminder (CoreDataProperties)

+ (NSFetchRequest<Reminder *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Reminder"];
}

@dynamic time;
@dynamic student;
@dynamic teacher;

@end
