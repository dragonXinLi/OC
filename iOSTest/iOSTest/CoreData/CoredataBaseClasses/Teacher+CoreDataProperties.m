//
//  Teacher+CoreDataProperties.m
//  
//
//  Created by lilong on 2018/7/5.
//
//

#import "Teacher+CoreDataProperties.h"

@implementation Teacher (CoreDataProperties)

+ (NSFetchRequest<Teacher *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Teacher"];
}

@dynamic name;
@dynamic testt;
@dynamic age;
@dynamic reminders;
@dynamic students;

@end
