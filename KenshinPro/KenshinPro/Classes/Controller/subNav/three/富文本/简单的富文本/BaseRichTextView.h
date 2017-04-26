//
//  BaseRichTextView.h
//  KenshinPro
//
//  Created by kenshin on 17/4/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseRichTextView : UIView

@property (weak, nonatomic) IBOutlet UILabel *richLabOne;

@property (weak, nonatomic) IBOutlet UILabel *richLabTwo;


typedef void (^BaseRichTextViewBlock)();

- (void)clickButtonpPushNextVC:(BaseRichTextViewBlock)block;

@end
