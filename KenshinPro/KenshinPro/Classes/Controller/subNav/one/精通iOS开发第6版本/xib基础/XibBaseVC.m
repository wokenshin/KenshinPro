//
//  XibBaseVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/18.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "XibBaseVC.h"

@interface XibBaseVC ()
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation XibBaseVC

//from《精通iOS开发第6版》p45
- (IBAction)action:(UIButton *)sender {
    
//    if (sender.tag == 1) {
//        _lab.text = @"click left button";
//    }
//    if (sender.tag == 2) {
//        _lab.text = @"click right button";
//    }
    
    //获取当前按钮在 正常状态下的 文本
    NSString *title = [sender titleForState:UIControlStateNormal];
    NSString *plainText = [NSString stringWithFormat:@"%@ button pressed", title];
    
    //_lab.text = plainText;
    
    //使用样式文本
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    
    //字体加粗
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:_lab.font.pointSize]
                                 };
    
    //设置范围 这里的范围就是 title 即 将 title范围内的文本加粗
    NSRange nameRange = [plainText rangeOfString:title];
    //设置属性
    [styledText setAttributes:attributes range:nameRange];
    _lab.attributedText = styledText;
    
}


@end
