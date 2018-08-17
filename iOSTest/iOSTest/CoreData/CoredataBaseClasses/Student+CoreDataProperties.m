//
//  Student+CoreDataProperties.m
//  
//
//  Created by lilong on 2018/7/4.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic reminders;
@dynamic teacher;

@end
