//
//  NoDataView.m
//  Mother-Service-Station
//
//  Created by kenshin on 16/7/19.
//  Copyright © 2016年 ddsl. All rights reserved.
//

#import "NoDataView.h"
#import "Tools.h"

@implementation NoDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
    
}

+ (UIView *)tipsNoDataViewWithImgName:(NSString *)imgName andContent:(NSString *)content
{
    CGFloat hTips = screenHeight - 64 - 60;
    CGFloat sizeImg = 120;
    CGFloat xTipsImg = screenWidth/2 - sizeImg/2;
    CGFloat yTipsImg = hTips/2 - sizeImg/2 - 50;
    UIView *tipsNoData = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, hTips)];
    
    UIImageView *noDataImgV = [[UIImageView alloc] initWithFrame:CGRectMake(xTipsImg, yTipsImg, sizeImg, sizeImg)];
    noDataImgV.image = [UIImage imageNamed:imgName];
    
    CGFloat yLab = CGRectGetMaxY(noDataImgV.frame);
    UILabel *labNoData = [[UILabel alloc] initWithFrame:CGRectMake(0, yLab, screenWidth, 30)];
    labNoData.text = content;
    labNoData.textAlignment = NSTextAlignmentCenter;
    labNoData.textColor = colorTextGray;
    labNoData.font = Font7;
    
    [tipsNoData addSubview:noDataImgV];
    [tipsNoData addSubview:labNoData];
    
    return tipsNoData;
}

+ (UIView *)tipsNoDataViewWithImgName:(NSString *)imgName andContent:(NSString *)content andHeight:(CGFloat)height
{
    CGFloat hTips = height;
    CGFloat sizeImg = 120;
    CGFloat xTipsImg = screenWidth/2 - sizeImg/2;
    CGFloat yTipsImg = hTips/2 - sizeImg/2 - 50;
    UIView *tipsNoData = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, hTips)];
    
    UIImageView *noDataImgV = [[UIImageView alloc] initWithFrame:CGRectMake(xTipsImg, yTipsImg, sizeImg, sizeImg)];
    noDataImgV.image = [UIImage imageNamed:imgName];
    
    CGFloat yLab = CGRectGetMaxY(noDataImgV.frame);
    UILabel *labNoData = [[UILabel alloc] initWithFrame:CGRectMake(0, yLab, screenWidth, 30)];
    labNoData.text = content;
    labNoData.textAlignment = NSTextAlignmentCenter;
    labNoData.textColor = colorTextGray;
    labNoData.font = Font7;
    
    [tipsNoData addSubview:noDataImgV];
    [tipsNoData addSubview:labNoData];
    
    return tipsNoData;
}

+ (UIView *)tipsNoDataViewWithImgName:(NSString *)imgName andHeight:(CGFloat)height
{
    CGFloat sizeImg = 100;
    CGFloat xTipsImg = screenWidth/2 - sizeImg/2;
    CGFloat yTipsImg = height/2 - sizeImg/2 - 50;
    UIView *tipsNoData = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, height)];
    
    UIImageView *noDataImgV = [[UIImageView alloc] initWithFrame:CGRectMake(xTipsImg, yTipsImg, sizeImg, sizeImg)];
    noDataImgV.image = [UIImage imageNamed:imgName];
    
    
    
    [tipsNoData addSubview:noDataImgV];
    
    return tipsNoData;
}

@end
