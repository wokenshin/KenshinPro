//
//  RegexUtil.h
//  server
//
//  Created by xiangwl on 15/12/14.
//  Copyright (c) 2015年 ddsl. All rights reserved.
//

#import <Foundation/Foundation.h>//正则表达式 内容合法性验证

@interface RegexUtil : NSObject

+ (BOOL)isValidTelePhone:(NSString *)telephone;
+ (BOOL)isValidMobileNumber:(NSString*)mobileNum;
+ (BOOL)isValidEmail:(NSString *)email;
+ (BOOL)isValidZipCode:(NSString *)zipCode;
+ (BOOL)isValidPassword:(NSString *)password;
+ (BOOL)validateIDCardNumber:(NSString *)value;
+ (BOOL)isValidateNickname:(NSString *)nickname;//验证昵称合法性

+ (BOOL)isHasSpaceStr:(NSString *)str;//是否包含空格
+ (BOOL)isFirstCharacterAreSpaceStr:(NSString *)str;//首个字符为空格
@end
