//
//  FileUtils.m
//  RZXBozon
//
//  Created by per on 2018/12/18.
//  Copyright © 2018年 per. All rights reserved.
//

#import "FileUtils.h"

@implementation FileUtils

+ (NSString *)getDocumentsDirectory {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return documentsPath;
}

+ (NSString *)getCacheDirectory {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //    NSLog(@"getCacheDirectory: %@", cachePath);
    return cachePath;
}

+ (BOOL)cacheFileExists:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachePath = [[self getCacheDirectory] stringByAppendingPathComponent:fileName];
    return [fileManager fileExistsAtPath:cachePath];
}

+ (BOOL)removeFileAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    return [fileManager removeItemAtPath:filePath error:&error];
}


// 显示缓存大小
+ (float)fileSizeWithCachePath
{
    //    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:[self getCacheDirectory]];
    
}

// 计算单个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]){
        return [[fileManager attributesOfItemAtPath:filePath error :nil] fileSize];
    }
    return 0 ;
}

// 遍历文件夹获得文件夹大小，返回多少 M
+ (float)folderSizeAtPath:(NSString *)folderPath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) return 0 ;
    NSEnumerator    *childFilesEnumerator   = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString        *fileName;
    long long       folderSize              = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0 * 1024.0);
}

+(void)clearCacheAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            if (![fileName containsString:@"SDWebImageCache"] && ([[fileName pathExtension] isEqualToString:@"png"] || [[fileName pathExtension] isEqualToString:@"jpg"])) {
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
            // [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

@end
