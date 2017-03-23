

#import "FXWUD.h"

@implementation FXWUD


+ (void)saveString:(NSString *)strValue forKey:(NSString *)key;
{
    if (strValue != nil && key != nil)
    {
        if ([strValue isEqual:[NSNull null]])
        {
            NSLog(@"沙盒保存字符串失败, key == %@ value == null", key);
            return;
        }
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:strValue forKey:key];
        [userDefaults synchronize];
    }
    else
    {
        if (key)
        {
            NSLog(@"沙盒保存字符串失败, key == %@ value == nil", key);
        }
        else
        {
            NSLog(@"沙盒保存字符串失败, key == nil value == nil");
        }
    }
    
}

+ (NSString *)getStringForKey:(NSString *)key;
{
    if (key)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *strValue = [userDefaults objectForKey:key];
        if (strValue == nil || [strValue isEqual:[NSNull null]])
        {
            strValue = @"空";//测试过 如果获取沙盒中没有的key 返回的字符串是 nil
        }
        
        return strValue;
    }
    else
    {
        return @"key==nil";
    }
    
}


+ (void)saveDounle:(double)doubleValue forKey:(NSString *)key
{
    if (key)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setDouble:doubleValue forKey:key];
        [userDefaults synchronize];
    }
    else
    {
        NSLog(@"沙盒保存double失败， key == nil");
    }
    
}

+ (double)getDoubleForKey:(NSString *)key
{
    if (key)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        return [userDefaults doubleForKey:key];
    }
    else
    {
        NSLog(@"沙盒读取double失败， key == nil");
    }
    return 0;
    
}

+ (void)saveBOOL:(BOOL)isValue forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isValue forKey:key];
    [userDefaults synchronize];
    
}

+ (BOOL)getBOOLForKey:(NSString *)key
{
    if (key)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        return [userDefaults boolForKey:key];
    }
    else
    {
        NSLog(@"沙盒读取BOOL失败 key == nil");
        return NO;
    }
    
    
}

+ (void)saveInteger:(NSInteger )integerValue forKey:(NSString *)key
{
    if (key)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:integerValue forKey:key];
        [userDefaults synchronize];
    }
    else
    {
        NSLog(@"沙盒保存整数失败 key == nil");
    }
}

+ (NSInteger)getIntegerForkey:(NSString *)key
{
    if (key)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        return [userDefaults integerForKey:key];
    }
    else
    {
        NSLog(@"沙盒读取整数失败 key == nil");
        return 0;
    }
    
}


#pragma mark 读写 数组 [还没有实现]
+ (void)saveArray:(NSArray *)array forKey:(NSString *)key
{
    
    
}

+ (NSArray *)getArrayForKey:(NSString *)key
{
    return nil;
    
}

+ (void)saveDic:(NSDictionary *)dic forKey:(NSString *)key
{
    
    
}

+ (NSDictionary *)getDicForKey:(NSString *)key
{
    return nil;
    
}

#pragma mark - 清空数据
+ (void)clearAll
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"LOGIN_STATE"];
    [userDefaults removeObjectForKey:@"NICK_NAME"];
    [userDefaults synchronize];
    
}


+ (void)saveLoginState:(BOOL)isLoginState
{
    [FXWUD saveBOOL:isLoginState forKey:@"loginState"];
}

+ (BOOL)isLoginState
{
    return [FXWUD getBOOLForKey:@"loginState"];
}

+ (void)saveUserId:(NSInteger)userId
{
    [FXWUD saveInteger:userId forKey:@"userId"];
}

+ (NSInteger)userId
{
    return [FXWUD getIntegerForkey:@"userId"];
}

+ (void)saveUserToken:(NSString *)token
{
    [FXWUD saveString:token forKey:@"token"];
}

+ (NSString *)userToken
{
    return [FXWUD getStringForKey:@"token"];
}

+ (void)savePhone:(NSString *)phone
{
    [FXWUD saveString:phone forKey:@"phone"];
}


+ (NSString *)phone
{
    return [FXWUD getStringForKey:@"phone"];
}

+ (void)saveAddress:(NSString *)address
{
    [FXWUD saveString:address forKey:@"address"];
}

+ (NSString *)address
{
    return [FXWUD getStringForKey:@"address"];
}

+ (void)saveNickname:(NSString *)nickName
{
    [FXWUD saveString:nickName forKey:@"nickName"];
}

+ (NSString *)nickName
{
    return [FXWUD getStringForKey:@"nickName"];
}

+ (void)saveOpenId:(NSString *)openId
{
    [FXWUD saveString:openId forKey:@"openId"];
}

+ (NSString *)openId
{
    return [FXWUD getStringForKey:@"openId"];
}

+ (void)savePicture:(NSString *)picture
{
    [FXWUD saveString:picture forKey:@"picture"];
}

+ (NSString *)picture
{
    return [FXWUD getStringForKey:@"picture"];
}

+ (void)saverRemark:(NSString *)remark
{
    [FXWUD saveString:remark forKey:@"remark"];
}

+ (NSString *)remark
{
    return [FXWUD getStringForKey:@"remark"];
}

+ (void)saveCuCity:(NSString *)cuCity
{
    [FXWUD saveString:cuCity forKey:@"cuCity"];
    
}

+ (NSString *)cuCity
{
    return [FXWUD getStringForKey:@"cuCity"];
}

+ (void)saveUserRank:(NSInteger )userRank
{
    [FXWUD saveInteger:userRank forKey:@"userRank"];
}

+ (NSInteger)userRank
{
    return [FXWUD getIntegerForkey:@"userRank"];
}

+ (void)saveLat:(double)lat
{
    [FXWUD saveDounle:lat forKey:@"lat"];
}

+ (double)lat
{
    return [FXWUD getDoubleForKey:@"lat"];
}

+ (void)saveLon:(double)lon
{
    [FXWUD saveDounle:lon forKey:@"lon"];
}

+ (double)lon
{
    return [FXWUD getDoubleForKey:@"lon"];
}

+ (void)saveBalance:(double)balance
{
    [FXWUD saveDounle:balance forKey:@"balance"];
}

+ (double)balance
{
    return [FXWUD getDoubleForKey:@"balance"];
}

+ (void)saveLoginUserInfo:(NSDictionary *)userInfo
{
    
//    NSString *clientInfo    = [userInfo objectForKey:@"clientInfo"];
    NSString *address       = [userInfo objectForKey:@"address"];
    NSString *nickName      = [userInfo objectForKey:@"nickName"];
    NSString *openId        = [userInfo objectForKey:@"openId"];
    NSString *phoneNo       = [userInfo objectForKey:@"phoneNo"];
    NSString *picture       = [userInfo objectForKey:@"picture"];
    NSString *remark        = [userInfo objectForKey:@"remark"];
    NSString *token         = [userInfo objectForKey:@"token"];
    NSInteger userId        = [[userInfo objectForKey:@"userId"] integerValue];
    NSInteger userRank      = [[userInfo objectForKey:@"userRank"] integerValue];
    
    double    balance       = [[userInfo objectForKey:@"balance"] doubleValue];
    double    lat           = [[userInfo objectForKey:@"lat"] doubleValue];
    double    lon           = [[userInfo objectForKey:@"lon"] doubleValue];
    
    [FXWUD saveAddress:address];
    [FXWUD saveNickname:nickName];
    [FXWUD saveOpenId:openId];
    [FXWUD savePhone:phoneNo];
    [FXWUD savePicture:picture];
    [FXWUD saverRemark:remark];
    [FXWUD saveUserToken:token];
    [FXWUD saveUserId:userId];
    [FXWUD saveUserRank:userRank];
    [FXWUD saveBalance:balance];
    [FXWUD saveLat:lat];
    [FXWUD saveLon:lon];
    
}




@end
