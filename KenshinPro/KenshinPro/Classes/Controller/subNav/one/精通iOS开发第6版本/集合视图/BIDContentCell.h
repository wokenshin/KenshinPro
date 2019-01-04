//
//  BIDContentCell.h
//  KenshinPro
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BIDContentCell : UICollectionViewCell

@property (nonatomic, strong) UILabel   *label;
@property (nonatomic, strong) NSString  *text;

+(CGSize)sizeForContentString:(NSString *)s;

@end

NS_ASSUME_NONNULL_END
