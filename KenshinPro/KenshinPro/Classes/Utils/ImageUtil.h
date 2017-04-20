//
//  ImageUtil.h
//  server
//
//  Created by xiangwl on 16/3/28.
//  Copyright © 2016年 ddsl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface ImageUtil : NSObject

/**
 * 保存图片
 * @param image 原始图片
 * @param imageName 保存的图片名称（含扩展名如：xx.jpg）
 * @param isThumb 是否压缩
 */
+(NSString *)saveImage:(UIImage *)image imageName:(NSString *)imageName isThumb:(BOOL)isThumb isScale:(BOOL)isScale;

/** 原始图片等比例压缩
 @param image 图片
 @param size 新尺寸
 */
+(UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

/**原始图片压缩
 @param image 图片
 @param size 新尺寸
 */
+(UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

@end
