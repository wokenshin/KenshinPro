//
//  FXW_DebugView.m
//  KenshinPro
//
//  Created by kenshin on 2017/10/20.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_DebugView.h"

@interface FXW_DebugView()

@property (nonatomic, strong) NSMutableArray    *mArrMsg;
@property (nonatomic, strong) NSMutableString   *mContent;
@property (nonatomic, assign) BOOL              zoomBigger;

@end

@implementation FXW_DebugView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSString *nibName = NSStringFromClass([self class]);
        self = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil].firstObject;
        self.frame = frame;
        
    }
    return self;
    
}

- (NSMutableArray *)mArrMsg
{
    if (_mArrMsg == nil)
    {
        _mArrMsg = [[NSMutableArray alloc] init];
    }
    return _mArrMsg;
}

- (NSMutableString *)mContent
{
    if (_mContent == nil)
    {
        _mContent = [[NSMutableString alloc] init];
    }
    return _mContent;
}


#pragma mark 接口 暂时信息
- (void)fxw_show
{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}

- (void)fxw_setMessage:(NSString *)message
{
    NSString *msg = [NSString stringWithFormat:@"%@/n", message];
    [self.mArrMsg addObject:msg];
    [self setMessage];
    
}

#pragma mark 接口 删除自身
- (void)fxw_removeSelf
{
    [self removeFromSuperview];
    
}

#pragma mark 点击 清空按钮
- (IBAction)clickLeftBtn:(id)sender
{
    [self.mArrMsg removeAllObjects];
    self.mContent = nil;
    
    [self setMessage];
    
}

#pragma mark 点击 放大 or 缩小【最好是做一个动画效果】
- (IBAction)clickChangeZoom:(UIButton *)sender
{
    WS(ws);
    if (!_zoomBigger)
    {
        _zoomBigger = YES;
        [sender setTitle:@"放大" forState:UIControlStateNormal];
        ws.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, screenWidth, sender.frame.size.height);
    }
    else
    {
        _zoomBigger = NO;
        [sender setTitle:@"缩小" forState:UIControlStateNormal];
        ws.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, screenWidth, 300);//这里的高度暂时这样吧
        
    }
    
}


#pragma mark 点击 关闭按钮
- (IBAction)clickRightBtn:(id)sender
{
    [self fxw_removeSelf];
    
}

#pragma mark 滑动Slider 设置透明度
- (IBAction)dragSliderSetAlpah:(UISlider *)sender
{
    self.txtView.alpha = sender.value;
    
}

- (void)setMessage
{
    for (NSString *msg in _mArrMsg)
    {
        [self.mContent appendString:msg];
    }
    self.txtView.text = self.mContent;
    
    //自动滚动到最后一行
    [_txtView scrollRangeToVisible:NSMakeRange(_txtView.text.length, 1)];
    _txtView.layoutManager.allowsNonContiguousLayout = NO;
    
}
@end
