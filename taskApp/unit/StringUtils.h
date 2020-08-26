//
//  StringUtils.h
//  RZXBozon
//
//  Created by per on 2018/12/18.
//  Copyright © 2018年 per. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

/**
 *  手机号验证
 *  如果手机号不正常，则返回错误描述, 反之返回nil
 */
+ (NSString *)checkPhone:(NSString *)phone;

/**
 *  短信验证码
 *  正确返回nil, 异常返回错误描述
 */
+ (NSString *)checkSmsCode:(NSString *)smsCode;

/**
 *  密码规则验证
 *
 *   正确返回nil，异常返回错误描述
 */
+ (NSString *)checkPassword:(NSString *)password andMinLength:(int)minLength andMaxLength:(int)maxLength;

/**
 *  密码验证
 *
 *  @param confirmPwd   确认密码
 *
 *  @return 正确返回nil，异常返回错误描述
 */
+ (NSString *)checkPassword:(NSString *)password andConfirmPwd:(NSString *)confirmPwd;

/**
 *  身份证号码验证
 *
 *  @param idNo 身份证号码
 *
 *  @return 正确返回nil，异常返回错误描述
 */
+ (NSString *)checkIdNo:(NSString *)idNo;

/**
 *  检验字符串是否为空
 */
+ (BOOL)isNullOrEmpty:(NSString *)str;

/**
 *  校验字符串根据正则表达式
 *
 *  @param string 需要校验的字符串
 *  @param regx   正则表达式
 *
 */
+ (BOOL)verifyString:(NSString *)string regx:(NSString *)regx;

/**
 *  是否包含数字
 *
 *  @param string 要验证的字符串
 *
 */
+ (BOOL)isIncludeNum:(NSString *)string;

/**
 *  是否包含字母
 *
 *  @param string 要验证的字符串
 *
 */
+ (BOOL)isIncludeCharacter:(NSString *)string;

/**
 *  json字符串转换成字典
 *  字典转成JSON字符串
 *
 *
 */
+ (NSString *)JSONStringWithDictionary:(NSDictionary *)dictionary;

/**
 *  JSON字符串转换成字典
 *
 *
 */
+ (NSDictionary *)dictionaryWithJSONString:(NSString *)JSONString;

@end
