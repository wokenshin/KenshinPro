//
//  BaseRichTextVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaseRichTextVC.h"
#import "BaseRichTextView.h"
#import "TextMixPicVC.h"

/**
 学习参考：http://www.jianshu.com/p/bbfe7bd282f1
 */
@interface BaseRichTextVC ()

@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) BaseRichTextView              *vcView;

@end

@implementation BaseRichTextVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseRichTextVCUI];
    
}

- (void)initBaseRichTextVCUI
{
    self.navigationItem.title = @"富文本-基础";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initLabWayOne];
    [self initLabWayTwo];
    
    self.tableView.tableHeaderView = self.vcView;
    [self.view addSubview:self.tableView];
    
    WS(ws);
    [self.vcView clickButtonpPushNextVC:^{
        TextMixPicVC *vc = [[TextMixPicVC alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
    }];
    
}

//方式一
- (void)initLabWayOne
{
    /*
     使用方式一
     
     初始化一个NSMutableAttributedString，然后向里面添加文字样式，将其赋给控件的attributedText属性。
     （这种方式只是简单的用几个属性表示了用法，在下面的一种使用方式中，会详细总结所有属性）
     */
    
    NSString *str = @"人生若只如初见，何事悲风秋画扇。\n等闲变却故人心，却道故人心易变。\n骊山语罢清宵半，泪雨霖铃终不怨。\n何如薄幸锦衣郎，比翼连枝当日愿。";
    //创建NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    //设置指定范围内的字体大小
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:30.0f]
                    range:NSMakeRange(0, 3)];
    
    //设置指定范围内的字体颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:NSMakeRange(17, 7)];
    
    //设置指定范围内的背景颜色
    [attrStr addAttribute:NSBackgroundColorAttributeName
                    value:[UIColor orangeColor]
                    range:NSMakeRange(17, 7)];
    
    //设置指定范围内的下划线
    [attrStr addAttribute:NSUnderlineStyleAttributeName
                    value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                    range:NSMakeRange(8, 7)];
    
    
    self.vcView.richLabOne.backgroundColor = [UIColor greenColor];
    
    //自动换行
    self.vcView.richLabOne.numberOfLines = 0;
    
    //设置label的富文本
    self.vcView.richLabOne.attributedText = attrStr;
    
    //label高度自适应
    [self.vcView.richLabOne sizeToFit];
    
}

//方式二
- (void)initLabWayTwo
{
    /*
     使用方式二
     
     创建属性字典，并将各种属性初始化。赋值，
     并利用方法appendAttributedString:添加入NSMutableAttributedString，
     将其赋给控件的attributedText属性。
     */
    
    //初始化NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
    
    //设置字体格式和大小
    NSString *str0 = @"设置字体格式和大小";
    NSDictionary *dictAttr0 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    NSAttributedString *attr0 = [[NSAttributedString alloc]initWithString:str0 attributes:dictAttr0];
    [attributedString appendAttributedString:attr0];
    
    //设置字体颜色
    NSString *str1 = @"\n设置字体颜色\n";
    NSDictionary *dictAttr1 = @{NSForegroundColorAttributeName:[UIColor purpleColor]};
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:str1 attributes:dictAttr1];
    [attributedString appendAttributedString:attr1];
    
    //设置字体背景颜色
    NSString *str2 = @"设置字体背景颜色\n";
    NSDictionary *dictAttr2 = @{NSBackgroundColorAttributeName:[UIColor cyanColor]};
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:str2 attributes:dictAttr2];
    [attributedString appendAttributedString:attr2];
    
    /*
     注：NSLigatureAttributeName设置连体属性，取值为NSNumber对象（整数），1表示使用默认的连体字符，0表示不使用，2表示使用所有连体符号（iOS不支持2）。而且并非所有的字符之间都有组合符合。如 fly ，f和l会连起来。
     */
    //设置连体属性
    NSString *str3 = @"fly";
    NSDictionary *dictAttr3 = @{NSFontAttributeName:[UIFont fontWithName:@"futura" size:14],NSLigatureAttributeName:[NSNumber numberWithInteger:1]};
    NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:str3 attributes:dictAttr3];
    [attributedString appendAttributedString:attr3];
    
    /*!
     注：NSKernAttributeName用来设置字符之间的间距，取值为NSNumber对象（整数），负值间距变窄，正值间距变宽
     */
    
    NSString *str4 = @"\n设置字符间距";
    NSDictionary *dictAttr4 = @{NSKernAttributeName:@(4)};
    NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:str4 attributes:dictAttr4];
    [attributedString appendAttributedString:attr4];
    
    /*!
     注：NSStrikethroughStyleAttributeName设置删除线，取值为NSNumber对象，枚举NSUnderlineStyle中的值。NSStrikethroughColorAttributeName设置删除线的颜色。并可以将Style和Pattern相互 取与 获取不同的效果
     */
    
    NSString *str51 = @"\n设置删除线为细单实线,颜色为红色";
    NSDictionary *dictAttr51 = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr51 = [[NSAttributedString alloc]initWithString:str51 attributes:dictAttr51];
    [attributedString appendAttributedString:attr51];
    
    
    NSString *str52 = @"\n设置删除线为粗单实线,颜色为红色";
    NSDictionary *dictAttr52 = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),NSStrikethroughColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr52 = [[NSAttributedString alloc]initWithString:str52 attributes:dictAttr52];
    [attributedString appendAttributedString:attr52];
    
    NSString *str53 = @"\n设置删除线为细单实线,颜色为红色";
    NSDictionary *dictAttr53 = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble),NSStrikethroughColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr53 = [[NSAttributedString alloc]initWithString:str53 attributes:dictAttr53];
    [attributedString appendAttributedString:attr53];
    
    
    NSString *str54 = @"\n设置删除线为细单虚线,颜色为红色";
    NSDictionary *dictAttr54 = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternDot),NSStrikethroughColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr54 = [[NSAttributedString alloc]initWithString:str54 attributes:dictAttr54];
    [attributedString appendAttributedString:attr54];
    
    /*!
     NSStrokeWidthAttributeName 设置笔画的宽度，取值为NSNumber对象（整数），负值填充效果，正值是中空效果。NSStrokeColorAttributeName  设置填充部分颜色，取值为UIColor对象。
     设置中间部分颜色可以使用 NSForegroundColorAttributeName 属性来进行
     */
    //设置笔画宽度和填充部分颜色
    NSString *str6 = @"设置笔画宽度和填充颜色\n";
    NSDictionary *dictAttr6 = @{NSStrokeWidthAttributeName:@(2),NSStrokeColorAttributeName:[UIColor blueColor]};
    NSAttributedString *attr6 = [[NSAttributedString alloc]initWithString:str6 attributes:dictAttr6];
    [attributedString appendAttributedString:attr6];
    
    //设置阴影属性，取值为NSShadow对象
    NSString *str7 = @"设置阴影属性\n";
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor redColor];
    shadow.shadowBlurRadius = 1.0f;
    shadow.shadowOffset = CGSizeMake(1, 1);
    NSDictionary *dictAttr7 = @{NSShadowAttributeName:shadow};
    NSAttributedString *attr7 = [[NSAttributedString alloc]initWithString:str7 attributes:dictAttr7];
    [attributedString appendAttributedString:attr7];
    
    //设置文本特殊效果，取值为NSString类型，目前只有一个可用效果  NSTextEffectLetterpressStyle（凸版印刷效果）
    NSString *str8 = @"设置特殊效果\n";
    NSDictionary *dictAttr8 = @{NSTextEffectAttributeName:NSTextEffectLetterpressStyle};
    NSAttributedString *attr8 = [[NSAttributedString alloc]initWithString:str8 attributes:dictAttr8];
    [attributedString appendAttributedString:attr8];
    
    //设置文本附件，取值为NSTextAttachment对象，常用于文字的图文混排
    NSString *str9 = @"文字的图文混排\n";
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
    textAttachment.image = [UIImage imageNamed:@"star_shi.png"];
    textAttachment.bounds = CGRectMake(0, 0, 30, 30);
    NSDictionary *dictAttr9 = @{NSAttachmentAttributeName:textAttachment};
    NSAttributedString *attr9 = [[NSAttributedString alloc]initWithString:str9 attributes:dictAttr9];
    [attributedString appendAttributedString:attr9];
    
    /*!
     添加下划线 NSUnderlineStyleAttributeName。设置下划线的颜色 NSUnderlineColorAttributeName，对象为 UIColor。使用方式同删除线一样。
     */
    //添加下划线
    NSString *str10 = @"添加下划线\n";
    NSDictionary *dictAttr10 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:[UIColor redColor]};
    NSAttributedString *attr10 = [[NSAttributedString alloc]initWithString:str10 attributes:dictAttr10];
    [attributedString appendAttributedString:attr10];
    
    /*!
     NSBaselineOffsetAttributeName 设置基线偏移值。取值为NSNumber （float），正值上偏，负值下偏
     */
    //设置基线偏移值 NSBaselineOffsetAttributeName
    NSString *str11 = @"添加基线偏移值\n";
    NSDictionary *dictAttr11 = @{NSBaselineOffsetAttributeName:@(-10)};
    NSAttributedString *attr11 = [[NSAttributedString alloc]initWithString:str11 attributes:dictAttr11];
    [attributedString appendAttributedString:attr11];
    
    /*!
     NSObliquenessAttributeName 设置字体倾斜度，取值为 NSNumber（float），正值右倾，负值左倾
     */
    //设置字体倾斜度 NSObliquenessAttributeName
    NSString *str12 = @"设置字体倾斜度\n";
    NSDictionary *dictAttr12 = @{NSObliquenessAttributeName:@(0.5)};
    NSAttributedString *attr12 = [[NSAttributedString alloc]initWithString:str12 attributes:dictAttr12];
    [attributedString appendAttributedString:attr12];
    
    /*!
     NSExpansionAttributeName 设置字体的横向拉伸，取值为NSNumber （float），正值拉伸 ，负值压缩
     */
    //设置字体的横向拉伸 NSExpansionAttributeName
    NSString *str13 = @"设置字体横向拉伸\n";
    NSDictionary *dictAttr13 = @{NSExpansionAttributeName:@(0.5)};
    NSAttributedString *attr13 = [[NSAttributedString alloc]initWithString:str13 attributes:dictAttr13];
    [attributedString appendAttributedString:attr13];
    
    /*!
     NSWritingDirectionAttributeName 设置文字的书写方向，取值为以下组合
     @[@(NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding)]
     @[@(NSWritingDirectionLeftToRight | NSWritingDirectionOverride)]
     @[@(NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding)]
     @[@(NSWritingDirectionRightToLeft | NSWritingDirectionOverride)]
     
     ???NSWritingDirectionEmbedding和NSWritingDirectionOverride有什么不同
     */
    //设置文字的书写方向 NSWritingDirectionAttributeName
    NSString *str14 = @"设置文字书写方向\n";
    NSDictionary *dictAttr14 = @{NSWritingDirectionAttributeName:@[@(NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding)]};
    NSAttributedString *attr14 = [[NSAttributedString alloc]initWithString:str14 attributes:dictAttr14];
    [attributedString appendAttributedString:attr14];
    
    /*!
     NSVerticalGlyphFormAttributeName 设置文字排版方向，取值为NSNumber对象（整数），0表示横排文本，1表示竖排文本  在iOS中只支持0
     */
    //设置文字排版方向 NSVerticalGlyphFormAttributeName
    NSString *str15 = @"设置文字排版方向\n";
    NSDictionary *dictAttr15 = @{NSVerticalGlyphFormAttributeName:@(0)};
    NSAttributedString *attr15 = [[NSAttributedString alloc]initWithString:str15 attributes:dictAttr15];
    [attributedString appendAttributedString:attr15];
    
    //段落样式
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    //行间距
    paragraph.lineSpacing = 10;
    //段落间距
    paragraph.paragraphSpacing = 20;
    //对齐方式
    paragraph.alignment = NSTextAlignmentLeft;
    //指定段落开始的缩进像素
    paragraph.firstLineHeadIndent = 30;
    //调整全部文字的缩进像素
    paragraph.headIndent = 10;
    
    //添加段落设置
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attributedString.length)];
    
    
    self.vcView.richLabTwo.backgroundColor = [UIColor lightGrayColor];
    
    //自动换行
    self.vcView.richLabTwo.numberOfLines = 0;
    
    //设置label的富文本
    self.vcView.richLabTwo.attributedText = attributedString;
    
    //label高度自适应
    [self.vcView.richLabTwo sizeToFit];
    
    
}

- (BaseRichTextView *)vcView
{
    if (_vcView == nil)
    {
        _vcView = [[BaseRichTextView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight*2)];
    }
    return _vcView;
    
}

- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    }
    return _tableView;
    
}
- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
