//
//  FileUtils.h
//  RZXBozon
//
//  Created by per on 2018/12/18.
//  Copyright © 2018年 per. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

/**
 *  获取Documents目录路径
 *  需要持久化的数据请保存在该目录下面
 *
 *  @return 返回
 */
+ (NSString *)getDocumentsDirectory;

/**
 *  获取Cache目录路径
 *  只是临时缓存不需要持久化存储的数据请保存在该目录下面
 *
 *  @return 返回
 */
+ (NSString *)getCacheDirectory;

/**
 *  检验缓存文件是否存在
 *
 *  @param fileName 文件名
 *
 *  @return 返回
 */
+ (BOOL)cacheFileExists:(NSString *)fileName;

/**
 *  移除指定文件
 *
 *  @param filePath 文件路径
 *
 *  @return 返回
 */
+ (BOOL)removeFileAtPath:(NSString *)filePath;

/**
 显示缓存大小
 
 @return 缓存大小 M单位
 */
+ (float)fileSizeWithCachePath;

/**
 清除指定文件夹
 
 @param path 文件夹路径
 */
+(void)clearCacheAtPath:(NSString *)path;

@end
