//
//  BIDHeaderCell.m
//  KenshinPro
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "BIDHeaderCell.h"

@implementation BIDHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.8 alpha:1];
        self.label.textColor = [UIColor blackColor];
    }
    return self;
}

+ (UIFont *)defaultFont{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

@end
