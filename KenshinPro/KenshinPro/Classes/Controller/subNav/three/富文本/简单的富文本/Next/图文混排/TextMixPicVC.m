//
//  TextMixPicVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "TextMixPicVC.h"
#import "TextConnectWebVC.h"

@interface TextMixPicVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextMixPicVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTextMixPicVCUI];
    
}

- (void)initTextMixPicVCUI
{
    self.navigationItem.title = @"图文混排";
    
    NSString *ImageText = @"如果，感到此时的自己很辛苦，那告诉自己：容易走的都是下坡路。坚持住，因为你正在走上坡路，走过去，你就一定会有进步。如果，你正在埋怨命运不眷顾，开导自己：命，是失败者的借口；运，是成功者的谦词。命运从来都是掌握在自己的手中，埋怨，只是一种懦弱的表现；努力，才是人生的态度。";
    
    //向内容的最后插入图片
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:ImageText];
    
    UIImage *image = [UIImage imageNamed:@"star_shi"];
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, 30, 30);
    NSAttributedString *attrStr1 = [NSAttributedString attributedStringWithAttachment:attachment];
    [attrStr appendAttributedString:attrStr1];
    self.textView.attributedText = attrStr;
    
    
    
}

//也可实现向指定的位置插入图片，为演示该功能，添加了一个按钮用来点击添加图片，添加的位置为 textView的光标所在位置。
- (IBAction)clickButtonAddImg:(id)sender
{
    //获取textView的富文本,并转换成可变类型
    NSMutableAttributedString *mutaAttrStr = [self.textView.attributedText mutableCopy];
    //获取光标的位置
    NSRange range = self.textView.selectedRange;
    //    NSLog(@"%lu %lu",(unsigned long)range.location,(unsigned long)range.length);
    //声明表情资源 NSTextAttachment类型
    UIImage *image = [UIImage imageNamed:@"star_shi"];
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, 30, 30);
    NSAttributedString *attrStr = [NSAttributedString     attributedStringWithAttachment:attachment];
    [mutaAttrStr insertAttributedString:attrStr atIndex:range.location];
    self.textView.attributedText = mutaAttrStr;
    
    
}

- (IBAction)clickTextConnectWeb:(id)sender
{
    TextConnectWebVC *vc = [[TextConnectWebVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
