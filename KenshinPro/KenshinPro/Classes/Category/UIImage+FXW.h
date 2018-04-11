//
//  UIImage+FXW.h
//  KenshinPro
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FXW)

/**
 根据字符串生成二维码图片
 
 @param code 二维码code
 @param size 生成图片大小
 @return 生成后的图频
 */
+ (UIImage *)jy_QRCodeFromString:(NSString *)code size:(CGFloat)size;

/**
 对CIQRCodeGenerator 生成的CIImage对象进行不插值放大或缩小处理
 
 @param iamge 原CIImage对象
 @param size 处理后的图片大小
 @return 生成后的图片
 */
+ (UIImage *) createfNonInterpolatedImageFromCIImage:(CIImage *)iamge withSize:(CGFloat)size;

@end
