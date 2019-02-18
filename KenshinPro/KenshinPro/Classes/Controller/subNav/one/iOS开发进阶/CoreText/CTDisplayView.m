//
//  CTDisplayView.m
//  KenshinPro
//
//  Created by apple on 2019/2/13.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreText/CoreText.h"

@implementation CTDisplayView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    //步骤1[得到当前绘制画布的上下文，用于后续将内容绘制在画布上]
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //步骤2[将绘制引擎的坐标系上下翻转，因为此坐标系和UIKit的坐标系远点正好相反，一个是左下角，一个是左上角]
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //步骤3
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    //步骤4
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World！"
                                     "创建绘制的区域，CoreText本身支持各种文字排版的区域，"
                                     "我们这里简单的将UIView的整个界面作为排版的区域。"
                                     "为了加深理解，建议读者将该步骤的代码替换成如下代码，"
                                     "测试设置不同的绘制区域带来的界面变化。"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    
    //步骤5
    CTFrameDraw(frame, context);
    
    //步骤6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

@end
