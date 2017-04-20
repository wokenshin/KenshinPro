//
//  ImageUtil.m
//  server
//
//  Created by xiangwl on 16/3/28.
//  Copyright © 2016年 ddsl. All rights reserved.
//

#import "ImageUtil.h"

@implementation ImageUtil

+(NSString *)saveImage:(UIImage *)image imageName:(NSString *)imageName isThumb:(BOOL)isThumb  isScale:(BOOL)isScale{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success)
    {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    UIImage *saveImage = image;
    if (isThumb)
    {
        if (isScale) {
            saveImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(140, 140)];
        }
        else{
            saveImage = [self thumbnailWithImage:image size:CGSizeMake(140, 140)];
        }
        
    }
    [UIImageJPEGRepresentation(saveImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    
    return imageFilePath;
}

+(UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

+(UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGRect rect = CGRectMake(0, 0, asize.width, asize.height);
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(rect);
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

@end
