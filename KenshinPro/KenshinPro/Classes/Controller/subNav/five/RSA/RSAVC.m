//
//  RSAVC.m
//  KenshinPro
//
//  Created by apple on 2018/9/7.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "RSAVC.h"
#import "RSA.h"

#define UpPrivateKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALzCVdak/9JhjRmOzPleJPlU8g+e8pvWL1cIFgO+YF/QNzzxMVRkdHEG9WLuQKn69boluQd1HtE3g1bvmYt+As8ZOfSK/uMVAd4zZdYVwW/1Rrw31Z/OwXcgxDbcTEkvF1o0yroNXyNNdPqpkHUs5CbSh6f54v++DVGA7de4ESvlAgMBAAECgYBsl4SYiq4eEz8AkBW99Hpi8oqbj/7UxmDPufgoSTLajEfrCHsvqOcQS0eKlbSf1Z/eamtLLgb/p+cocYktJd5o1sUCn7y9HS2XIpWonkXZ9ZoeInyCZh/JF4jpaITRLQyttyTDYAO/jtYF3O//MJE14YNk1KcNV++Ar0ilk/YPVQJBAO4upD9Crgr8gDV4VwrDGJn+HEpF+a3Hl3dDYREcjNqU+Lt2+RZS1VqsgtA4xpKyedgOkOiPv1A8Ra8BlibqjIsCQQDK4TTta72vyPm+lgb6OCDrNXqdAg9JYa7jVTlS9ni8yiwNWA4X163FOcKGUr6yhsAPV+RTjEl1qrFKpS4miAdPAkACCuBZsoavjW7EBp4od3fUijtP372+YcHIwgkpDmee0Dw5z1FfgaJWvrf4dSQuyd0Fn0pa1DC9zWaDk63n84b1AkEAo1LPf/6HUvcxDpvKfC8pWRDRZ4pb8hBAcWSPZFlk816yPf/QQKNxkd+g2O/N8vyFqxRvjE7YaHCEj3oQgBZsAwJBANRQyx2JEA96Px7Y8OxbrNblEqjFiN52X+qrKAVhJWWoTaH5hiqAVbPon7G34h0Vec5ic+Sox78B7KUGKqGOWJA="
#define UpPublicKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC8wlXWpP/SYY0Zjsz5XiT5VPIPnvKb1i9XCBYDvmBf0Dc88TFUZHRxBvVi7kCp+vW6JbkHdR7RN4NW75mLfgLPGTn0iv7jFQHeM2XWFcFv9Ua8N9WfzsF3IMQ23ExJLxdaNMq6DV8jTXT6qZB1LOQm0oen+eL/vg1RgO3XuBEr5QIDAQAB"

#define DownPrivateKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAIR7EXPBVoHxXqufEpeRvpvS4zZfLSUzsygJ1v5yWfvTaCyYMLE9OpEMg4xw4YlO0knvLPZ0M6L6MzPOL9nolvpXXrUpV3XmnSnMvknO7rwXLHhOyi7kQsdEC8QmUFJ/ktRHA9k+twxdS5YrZVrBMGfiImD8fCXLvUoW2k/VSs3pAgMBAAECgYAvrJn7LfgTiuimmff201vkd1+MkXONj61JG0FjD4OSO+GhKqNbJM2OpRIx1+1RnCvQr2FezzJF1APZALn3kNvDdiQ8Q16eWcsS2eRQJ0zs/3zCNKY8CQoRyauE9KkgBHz2mOQ9utSXihyxAG3Gig2SqpD5TX/gu/eC3sY7OoK6gQJBAMObKBcKGP0lCsU84Z8/wt2TxzeGY7PIHKeUzFc2tBdfPtePUIREIXCbH3cYATh15EDJHfOTeiqVQIC88PzF5q8CQQCtYnCBgtY4kEx6k1xACnRmpYaGU5dEjzdsNjONTBunc+XIyAA6bHdFC4YE5s38hstFQqRPfuuWePvMNAN7zDrnAkEAkMDaiypC0ds+vDXQthvmZjk9PT7ru5jEc9Ou4H+wCHfItpbtO+R7Zqy1PVn7VUAROUxcKOwjhS3MfTjVkgoWKwJAXA8RZ2J9tajAQrDtYT9r0HiAtd+6SHe2WKlqs9I+OKnrzrCKlnqy1SEqNn4JztQPJ6Ybse3Uzp9MKn9PfjLQ7wJBAK9bCpYYl0szV9ABb7p8y7DJpGzXW4SdBbtckQ20YXnvgF5yS0UpX1wK5ybSPt/BwdJDRXYZsuu8kQlKteFipQU="
#define DownPublicKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCEexFzwVaB8V6rnxKXkb6b0uM2Xy0lM7MoCdb+cln702gsmDCxPTqRDIOMcOGJTtJJ7yz2dDOi+jMzzi/Z6Jb6V161KVd15p0pzL5Jzu68Fyx4Tsou5ELHRAvEJlBSf5LURwPZPrcMXUuWK2VawTBn4iJg/Hwly71KFtpP1UrN6QIDAQAB"

@interface RSAVC ()

@end

@implementation RSAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RSA";
    
}

//解密【用私钥 解密 base64编码后的数据】
- (IBAction)onClickBtnDecrypt:(id)sender {
    
    //base64编码后的加密数据
    NSString *base64Str = @"SkaFTY9KLskRp4V7WCQWi+ineM6j8d6HPP49Sg7W+4/4RB+6Z2D9uRfFAB9iiACMbUi+DZ8M0O4B1iaHRobHnCt9p//Ptuz9TwSU6NSPuT+FvzX390WysSgBgKon6uixqSU65pfiCK57vNCjl5DqH6eiW44ME3lNfxNYubnXYzA=";
    //结果:注意，这里是用公钥进行解密的，方法一定要用对
    NSString *resultStr = [RSA decryptString:base64Str privateKey:UpPrivateKey];
    NSLog(@"结果 = %@",resultStr);
    
}

//加解密【公钥加密 私钥解密】
- (IBAction)onClickJiaJieMi:(id)sender {
    
    //测试要加密的数据
    NSString *sourceStr = @"kenshin";
    //公钥加密
    NSString *encryptStr = [RSA encryptString:sourceStr publicKey:UpPublicKey];
    //私钥解密
    NSString *decrypeStr = [RSA decryptString:encryptStr privateKey:UpPrivateKey];
    
    NSLog(@"加密后的数据 %@ ", encryptStr);
    NSLog(@"解密后的数据 %@ ", decrypeStr);
    
    
    //测试要加密的数据
    NSString *sourceStr2 = @"kenshin";
    //公钥加密
    NSString *encryptStr2 = [RSA encryptString:sourceStr2 publicKey:DownPublicKey];
    //私钥解密
    NSString *decrypeStr2 = [RSA decryptString:encryptStr2 privateKey:DownPrivateKey];
    
    NSLog(@"加密后的数据 %@ ", encryptStr2);
    NSLog(@"解密后的数据 %@ ", decrypeStr2);
}



@end
