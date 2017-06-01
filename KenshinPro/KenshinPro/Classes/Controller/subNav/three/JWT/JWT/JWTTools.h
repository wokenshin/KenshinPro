//
//  JWTTools.h
//  SmartDevice
//
//  Created by kenshin on 17/5/22.
//  Copyright © 2017年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 使用到了三方库 在JWT文件夹下 
 
 官网:       https://jwt.io/
 GitHub:    https://github.com/yourkarma/JWT
 
 
 */
@interface JWTTools : NSObject


/**
 JST验证

 @param jsonWebToken 一个由两个小数点间隔的字符串 形如 xxx.xxx.xxx
 @param sercetKey 用于验证 防止信息被篡改
 @return 验证通过 返回解析后的数据 否则返回 nil
 */
+ (NSDictionary *)verifyJWT:(NSString *)jsonWebToken secretKey:(NSString *)sercetKey;






@end
