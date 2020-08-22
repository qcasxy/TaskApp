//
//  StringUtils.m
//  RZXBozon
//
//  Created by per on 2018/12/18.
//  Copyright © 2018年 per. All rights reserved.
//

#import "StringUtils.h"

// 正则表达式 *******************************8
//验证手机号
static NSString * const REGX_PHONE = @"^(1[3-9][0-9]{9})";
//验证登录密码
static NSString * const REGX_LOGINPWD = @"(?=.*[0-9])(?=.*[a-zA-Z])(?!=.*[^a-zA-Z0-9]).{6,20}";
//身份证校验
//^(\\d{6})(19|20)?(\\d{2})([01]\\d)([0123]\\d)(\\d{3})(\\d|[Xx])?$
static NSString * const REGX_IDENTITYCARD = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$|^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|[Xx])$";
//姓名校验
static NSString * const REGX_USERNAME = @"^[\u4e00-\u9fa5·]+$";

@implementation StringUtils

+ (NSString *)checkPhone:(NSString *)phone {
    if ([StringUtils isNullOrEmpty:phone]) {
        return @"请输入手机号";
    }
    
    if (![StringUtils verifyString:phone regx:REGX_PHONE]) {
        return @"手机号码有误";
    }
    
    return nil;
}

+ (NSString *)checkSmsCode:(NSString *)smsCode {
    if ([StringUtils isNullOrEmpty:smsCode]) {
        return @"请填写手机动态码";
    }
    
    if (smsCode.length != 4) {
        return @"手机验证码是4位数字";
    }
    return nil;
}

+ (NSString *)checkBankSmsCode:(NSString *)smsCode {
    if ([StringUtils isNullOrEmpty:smsCode]) {
        return @"请填写短信验证码";
    }
    
    if (smsCode.length != 4 && smsCode.length != 6) {
        return @"验证码有误，请重新输入";
    }
    return nil;
}

+ (NSString *)checkPassword:(NSString *)password {
    if ([StringUtils isNullOrEmpty:password]) {
        return @"请输入密码";
    }
    
    if (password.length < 6 || password.length > 20) {
        return @"密码长度为6-12位";
    }
    
    return nil;
}

+ (NSString *)checkPassword:(NSString *)password andConfirmPwd:(NSString *)confirmPwd {
    
    if ([StringUtils isNullOrEmpty:confirmPwd]) {
        return @"确认密码不能为空";
    }
    
    if (![password isEqualToString:confirmPwd]) {
        return @"确认密码有误";
    }
    
    return nil;
}

+ (NSString *)checkIdNo:(NSString *)idNo {
    
    if ([StringUtils isNullOrEmpty:idNo]) {
        return @"请输入身份证号";
    }
    
    if (![StringUtils verifyString:idNo regx:REGX_IDENTITYCARD]) {
        return @"身份证号有误，请重新输入";
    }
    return nil;
}

+ (BOOL)isNullOrEmpty:(NSString *)str {
    
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (str == nil || str == NULL || ![str isKindOfClass:[NSString class]] || [str isEqualToString:@""]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)verifyString:(NSString *)string regx:(NSString *)regx {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regx];
    return [pred evaluateWithObject:string];
}

+ (BOOL)isIncludeNum:(NSString *)string{
    //是否包含数字
    NSRange characterRange = [string rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0987654321"]];
    if (characterRange.location == NSNotFound) {
        return NO;
    }
    else{
        return YES;
    }
}

+ (BOOL)isIncludeCharacter:(NSString *)string{
    
    //是否包含字母
    NSRange characterRange = [string rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"qwertyuioplkjhgfdsazxcvbnmMNBVCXZASDFGHJKLPOIUYTREWQ"]];
    if (characterRange.location == NSNotFound) {
        return NO;
    }
    else{
        return YES;
    }
}

+ (NSString *)JSONStringWithDictionary:(NSDictionary *)dictionary {
    NSString *jsonString = @"";
    NSError  *error;
    
    if (nil == dictionary || [dictionary isKindOfClass:[NSNull class]]) {
        return jsonString;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!jsonData) {
        return jsonString;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJSONString:(NSString *)JSONString {
    if ([self isNullOrEmpty:JSONString]) {
        return nil;
    }
    
    //编码
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    
    //序列化
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"dictionaryWithJSONString error: %@", error);
        return nil;
    }
    
    NSLog(@"dictionaryWithJSONString: %@", dictionary);
    return dictionary;
}


@end
