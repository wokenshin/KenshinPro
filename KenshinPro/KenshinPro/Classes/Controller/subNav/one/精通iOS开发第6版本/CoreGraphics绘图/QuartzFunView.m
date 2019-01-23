//
//  QuartzFunView.m
//  KenshinPro
//
//  Created by apple on 2019/1/22.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "QuartzFunView.h"
#import "UIColor+BIDRandom.h"

@implementation QuartzFunView

//nib文件和分镜中的对象是作为归档对象存储的 所以不会调用此方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self hehe];
    }
    return self;
}

//同上
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self hehe];
    }
    return self;
}

//nib 和 分镜 初始化 会调用此方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self hehe];
    }
    return self;
}

- (void)hehe{
    _currentColor = [UIColor redColor];
    _useRandomColor = NO;
    _drawImage = [UIImage imageNamed:@"iphone"];
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, self.currentColor.CGColor);
    
    CGContextSetFillColorWithColor(context, self.currentColor.CGColor);
    
//    CGRect currentRect = CGRectMake(self.firstTouchLocation.x,
//                                    self.firstTouchLocation.y,
//                                    self.lastTouchLocation.x - self.firstTouchLocation.x,
//                                    self.lastTouchLocation.y - self.firstTouchLocation.y);
    
    
    switch (self.shapeType) {
        case kLineShape:
        {
            CGContextMoveToPoint(context, self.firstTouchLocation.x, self.firstTouchLocation.y);
            CGContextAddLineToPoint(context, self.lastTouchLocation.x, self.lastTouchLocation.y);
            CGContextStrokePath(context);
        }
            break;
            
        case kRectShape:
        {
            CGContextAddRect(context, self.currentRect);
            CGContextDrawPath(context, kCGPathFillStroke);
        }
            break;
            
        case kEllipseShape:
        {
            CGContextAddEllipseInRect(context, self.currentRect);
            CGContextDrawPath(context, kCGPathFillStroke);
        }
            break;
            
        case kImageShape:
        {
            CGFloat horizontalOffset = self.drawImage.size.width/2;
            CGFloat verticalOffset   = self.drawImage.size.height/2;
            CGPoint drawPoint        = CGPointMake(self.lastTouchLocation.x - horizontalOffset,
                                                   self.lastTouchLocation.y - verticalOffset);
            [self.drawImage drawAtPoint:drawPoint];
        }
            break;
            
        default:
            break;
    }
}

- (CGRect)currentRect{
    return CGRectMake(self.firstTouchLocation.x,
                      self.firstTouchLocation.y,
                      self.lastTouchLocation.x - self.firstTouchLocation.x,
                      self.lastTouchLocation.y - self.firstTouchLocation.y);
}

#pragma mark - Touch Handling
//手指第一次触摸到屏幕时 被调用
- (void)touchesBegan:(NSSet *)touches withEvent:(nullable UIEvent *)event{
    if(self.useRandomColor){
        self.currentColor = [UIColor randomColor];
    }
    UITouch *touch = [touches anyObject];
    self.firstTouchLocation = [touch locationInView:self];
    self.lastTouchLocation  = [touch locationInView:self];
    [self setNeedsDisplay];//需要重新绘制
}

//手指在屏幕上滑动时 被持续调用
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.lastTouchLocation = [touch locationInView:self];
    
    //[self setNeedsDisplay];
    //优化如下 [self setNeedsDisplayInRect:self.redrawRect];
    if (self.shapeType == kImageShape) {
        CGFloat h = self.drawImage.size.width/2;
        CGFloat v = self.drawImage.size.height/2;
        self.redrawRect = CGRectUnion(self.redrawRect, CGRectMake(self.lastTouchLocation.x - h,
                                                                  self.lastTouchLocation.y - v,
                                                                  self.drawImage.size.width,
                                                                  self.drawImage.size.height));
    }
    self.redrawRect = CGRectUnion(_redrawRect, self.currentRect);
    [self setNeedsDisplayInRect:self.redrawRect];
}

//手指离开屏幕时 被调用
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.lastTouchLocation = [touch locationInView:self];
    
    //[self setNeedsDisplay];
    //优化如下 [self setNeedsDisplayInRect:self.redrawRect];
    if (self.shapeType == kImageShape) {
        CGFloat h = self.drawImage.size.width/2;
        CGFloat v = self.drawImage.size.height/2;
        self.redrawRect = CGRectUnion(self.redrawRect, CGRectMake(self.lastTouchLocation.x - h,
                                                                  self.lastTouchLocation.y - v,
                                                                  self.drawImage.size.width,
                                                                  self.drawImage.size.height));
    } else {
        self.redrawRect = CGRectUnion(self.redrawRect, self.currentRect);
    }
    self.redrawRect = CGRectInset(self.redrawRect, -2.0, -2.0);
    [self setNeedsDisplayInRect:self.redrawRect];
}




@end

