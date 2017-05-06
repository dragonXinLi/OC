//
//  FSFileOperation.h
//  apple
//
//  Created by sangfor on 17/4/11.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSFileOperation : NSObject

+ (NSString *)getDocumentDirectory;

+ (NSArray *)getfilesArrayWithDirectoryPath:(NSString *)path;

+ (NSDictionary *)getFileArrributesAtPath:(NSString *)filePath;

+ (NSString *)getAttachmentSizeStringWithSize:(long long)size;
+ (NSString *)getAttachmentSizeStringWithSize:(long long)size numberOfDecimalPoint:(NSInteger)decimalPoints;
+ (NSString *)getFileSizeStringWithSize:(long long)size;
+ (NSString *)getStringWithTwoDecimal:(NSString *)string;
+ (long long)getImageFileSize:(UIImage *)image;
+ (NSString *)getImageFileSizeString:(UIImage *)image;

+ (BOOL)plistFileExist:(NSString *)path;
+ (id)objectForKey:(id)key andPath:(NSString *)path;
+ (BOOL)saveObject:(id)obj forKey:(NSString *)key andPath:(NSString *)path;

@end
