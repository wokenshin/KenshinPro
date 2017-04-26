

#import <Foundation/Foundation.h>

/*
 功能描述       沙盒的 读写
 
 可以保存 字符串，double， BOOL NSInteger 数组 字典等
 
 */
@interface FXWUD : NSObject


#pragma mark 向沙盒读写字NSString
+ (void)saveString:(NSString *)strValue forKey:(NSString *)key;
+ (NSString *)getStringForKey:(NSString *)key;

#pragma mark 向沙盒读写BOOL
+ (void)saveBOOL:(BOOL)isValue forKey:(NSString *)key;
+ (BOOL)getBOOLForKey:(NSString *)key;

#pragma mark 向沙盒读写double
+ (void)saveDounle:(double)doubleValue forKey:(NSString *)key;
+ (double)getDoubleForKey:(NSString *)key;

#pragma mark 读写 NSInteger
+ (void)saveInteger:(NSInteger )integerValue forKey:(NSString *)key;
+ (NSInteger)getIntegerForkey:(NSString *)key;

#pragma mark 读写 数组 [还没有实现]
+ (void)saveArray:(NSArray *)array forKey:(NSString *)key;
+ (NSArray *)getArrayForKey:(NSString *)key;

#pragma mark 读写 字典 [还没有实现]
+ (void)saveDic:(NSDictionary *)dic forKey:(NSString *)key;
+ (NSDictionary *)getDicForKey:(NSString *)key;

+ (void)clearAll;


#pragma mark 龙达快的 信息

/**
 * 保存登录信息
 */
+ (void)saveLoginUserInfo:(NSDictionary *)userInfo;

+ (void)saveLoginState:(BOOL)isLogined;
+ (BOOL)isLoginState;

+ (void)saveUserToken:(NSString *)token;
+ (NSString *)userToken;

+ (void)saveUserId:(NSInteger)userId;
+ (NSInteger)userId;

+ (void)savePhone:(NSString *)phone;
+ (NSString *)phone;

+ (void)saveAddress:(NSString *)address;
+ (NSString *)address;

+ (void)saveNickname:(NSString *)nickName;
+ (NSString *)nickName;

+ (void)saveOpenId:(NSString *)openId;
+ (NSString *)openId;

+ (void)savePicture:(NSString *)picture;
+ (NSString *)picture;

+ (void)saverRemark:(NSString *)remark;
+ (NSString *)remark;

+ (void)saveUserRank:(NSInteger)userRank;
+ (NSInteger)userRank;

+ (void)saveLat:(double)lat;
+ (double)lat;

+ (void)saveLon:(double)lon;
+ (double)lon;

+ (void)saveBalance:(double)balance;
+ (double)balance;

+ (void)saveCuCity:(NSString *)cuCity;
+ (NSString *)cuCity;



@end
