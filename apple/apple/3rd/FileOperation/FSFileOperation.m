//
//  FSFileOperation.m
//  apple
//
//  Created by sangfor on 17/4/11.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import "FSFileOperation.h"

const int kDecimalPlaces = 2 ;//保留小数点位数

@implementation FSFileOperation

+ (NSString *)getDocumentDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}


+ (NSArray *)getfilesArrayWithDirectoryPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if(!exist || !isDirectory)
    {
        return nil;
    }
    
    NSError *error = nil;
    
    NSMutableArray *fileList = [[NSMutableArray alloc] init];
    fileList = [NSMutableArray arrayWithArray:[fileManager contentsOfDirectoryAtPath:path error:&error]];
    
    BOOL isDir = NO;
    NSMutableArray *filesArray = [[NSMutableArray alloc] init];
    for (NSString *directory in fileList) {
        NSString *thePath = [path stringByAppendingPathComponent:directory];
        [fileManager fileExistsAtPath:thePath isDirectory:(&isDir)];
        if(!isDir)
        {
            [filesArray addObject:thePath];
        }
        isDir = NO;
    }
    return filesArray;
}


+ (NSDictionary *)getFileArrributesAtPath:(NSString *)filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:filePath])
    {
        return [manager attributesOfItemAtPath:filePath error:nil];
    }
    return nil;
}


+ (long long)getImageFileSize:(UIImage *)image
{
    NSData *jpgData = UIImageJPEGRepresentation(image, 1.0f);
    return jpgData.length;
}


+ (NSString *)getImageFileSizeString:(UIImage *)image
{
    NSData *jpgData = UIImageJPEGRepresentation(image, 1.0f);
    return [FSFileOperation getFileSizeStringWithSize:jpgData.length];
}


+ (NSString *)getAttachmentSizeStringWithSize:(long long)size
{
    return [self getAttachmentSizeStringWithSize:size numberOfDecimalPoint:2];
}


+ (NSString *)getAttachmentSizeStringWithSize:(long long)size numberOfDecimalPoint:(NSInteger)decimalPoints
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"#"];
    
    if(size > 0 && size < 1024)
    {
        return @"1K";
    }else if (size < 1024 * 1024)
    {
        NSString *sizeString = [formatter stringFromNumber:@(size/1024.0)];
        return [NSString stringWithFormat:@"%@K",sizeString];
    }else
    {
        [formatter setPositiveFormat:@"#.#"];
        if(size < 1024 * 1024 * 1024)
        {
            NSString *sizeString = [formatter stringFromNumber:@(size / 1024.0 / 1024.0)];
            
            return [NSString stringWithFormat:@"%@M",sizeString];
        }else
        {
            NSString *sizeString = [formatter stringFromNumber:@(size / 1024.0 / 1024.0 / 1024.0)];
            
            return [NSString stringWithFormat:@"%@G",sizeString];
        }
    }
}


+ (NSString *)getFileSizeStringWithSize:(long long)size
{
    if(size > 0 && size < 1024)
    {
        return @"1K";
    }
    else if (size < 1024 * 1024)
    {
        NSString *sizeString = [NSString stringWithFormat:@"%f",ceil(size / 1024.0 * 100) / 100.0];
        return [NSString stringWithFormat:@"%@K",[self getStringWithTwoDecimal:sizeString]];
    }else
    {
        NSString *sizeString = [NSString stringWithFormat:@"%f",ceil(size / 1024.0 / 1024.0 * 100) / 100.0];
        return [NSString stringWithFormat:@"%@M",[self getStringWithTwoDecimal:sizeString]];
    }
}


+ (NSString *)getStringWithTwoDecimal:(NSString *)string
{
    NSArray *array = [string componentsSeparatedByString:@"."];
    if([array count] == 0 || [array count] == 1)
    {
        return string;
    }
    if([array[1] length] <= kDecimalPlaces)
    {
        return string;
    }
    return [NSString stringWithFormat:@"%@.%@",array[0],[array[1] substringToIndex:kDecimalPlaces]];
}


+ (BOOL)plistFileExist:(NSString *)path
{
    if(path)
    {
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:[fileURL path]])
        {
            return YES;
        }
    }
    return NO;
}


+ (id)objectForKey:(id)key andPath:(NSString *)path
{
    if(path && key)
    {
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:[fileURL path]])
        {
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:fileURL];
            
            if(!dic)
            {
                NSLog(@"Error: ******** Read File Failed: %@",path);
            }
            
            return dic[key];
        }else
        {
            NSLog(@"Warn: ********Path not exist: %@",path);
        }
    }else
    {
        
    }
    return nil;
}


+ (BOOL)saveObject:(id)obj forKey:(NSString *)key andPath:(NSString *)path
{
    if(path == nil || key == nil)
    {
        return NO;
    }
    
    NSURL *directoryURL = [NSURL fileURLWithPath:[path stringByDeletingLastPathComponent]];
    
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:[directoryURL path]])
    {
        BOOL sucess = [fileManager createDirectoryAtPath:<#(nonnull NSString *)#> withIntermediateDirectories:<#(BOOL)#> attributes:<#(nullable NSDictionary<NSString *,id> *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]
    }
    
    
    
    
    
    
    
    
}


@end
