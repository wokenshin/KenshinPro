//
//  TextConnectWeb.m
//  KenshinPro
//
//  Created by kenshin on 17/4/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "TextConnectWebVC.h"
#import "BaseWebVC.h"


/**
 之所以把 NSLinkAttributeName 属性单独列出来，是因为在 UILabel 和 UITextField 中是无法使用该属性的。
 更准确点说是在UILabel 和 UITextField 中无法实现点击链接启动浏览器打开一个URL地址，
 因为在此过程中用到了一个代理函数。只能用在 UITextView 中。
 
 NSLinkAttributeName 的对象是 NSURL 类型 或 NSString，但是优先使用 NSURL。
 
 需要实现UITextView的代理方法 
 - (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange，
 在该方法中，返回 YES，则会打开URL地址，返回 NO则不会。
 */
@interface TextConnectWebVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextConnectWebVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTextConnectWebUI];
    
}

- (void)initTextConnectWebUI
{
    self.navigationItem.title = @"文本链接";
    _textView.delegate = self;//实现textView的代理，否则调不到回调方法。
    _textView.editable = NO;//设置textView的 editable 属性为 NO，在可编辑的状态下是不可点击的。
                            //在模拟器环境下一直无法点击，在真机上是正常的，不知道是不是模拟器不支持
    [self wayOne];
}

- (void)wayOne
{
    /*
     设置方式一
     将全部文字设置为链接（可点击）
     */
    NSDictionary *dictAttr = @{NSLinkAttributeName:[NSURL URLWithString:@"http://blog.csdn.net/wokenshin"]};
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"kenshin'block" attributes:dictAttr];
    _textView.attributedText = attrStr;
    
}

#pragma mark 必须实现的代理
 - (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    //可以在这里根据点击的网页在做一些额外的逻辑
    return YES;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
