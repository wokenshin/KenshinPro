//
//  WGBDatePickerView.m
//  DatePick
//
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "WGBDatePickerView.h"

#define kZero 0
#define kFullWidth [UIScreen mainScreen].bounds.size.width
#define kFullHeight [UIScreen mainScreen].bounds.size.height

#define kDatePicY kFullHeight/3*2
#define kDatePicHeight kFullHeight/3

#define kDateTopBtnY kDatePicY - 30
#define kDateTopBtnHeight 30

#define kDateTopRightBtnWidth kDateTopLeftBtnWidth
#define kDateTopRightBtnX kFullWidth - 0 - kDateTopRightBtnWidth

#define kDateTopLeftbtnX  0
#define kDateTopLeftBtnWidth kFullWidth/6


@interface WGBDatePickerView ()

@property (nonatomic,strong)UIDatePicker        *dateP;
@property (nonatomic,strong)UIView              *groundV;
@property (nonatomic,strong)UIButton            *leftBtn;
@property (nonatomic,strong)UIButton            *rightBtn;
@property (nonatomic,strong)UIView              *topView;
@property (nonatomic,assign)UIDatePickerMode    type;
@property (nonatomic,strong) UILabel            *titleLabel;

@end


@implementation WGBDatePickerView

+ (instancetype)datePickerWithType:(UIDatePickerMode) type{
    WGBDatePickerView *datePicker =[[WGBDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds type:type];

    return datePicker;
}


- (instancetype)initWithFrame:(CGRect)frame type:(UIDatePickerMode)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self addSubview:self.groundV];
        [self addSubview:self.dateP];
        [self addSubview:self.topView];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (UIDatePicker *)dateP
{
    if (!_dateP)
    {
        self.dateP = [[UIDatePicker alloc]initWithFrame:CGRectMake(kZero, kDatePicY, kFullWidth, kDatePicHeight)];
        self.dateP.backgroundColor = [UIColor whiteColor];

        self.dateP.datePickerMode = self.type;
        self.dateP.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CHS_CN"];


        [self.dateP addTarget:self action:@selector(handleDateP:) forControlEvents:UIControlEventValueChanged];
    }
    return _dateP;
    
}

- (UIView *)groundV {
    if (!_groundV) {
        self.groundV = [[UIView alloc]initWithFrame:self.bounds];
        self.groundV.backgroundColor = [UIColor blackColor];
        self.groundV.alpha = 0.4;
    }
    return _groundV;
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn.frame = CGRectMake(kDateTopLeftbtnX, kDateTopBtnY, kDateTopLeftBtnWidth, kDateTopBtnHeight);
        [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.leftBtn.backgroundColor=[UIColor cyanColor];

        [self.leftBtn addTarget:self action:@selector(handleDateTopViewLeft) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}




- (UIButton *)rightBtn {
    if (!_rightBtn) {
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.frame = CGRectMake(kDateTopRightBtnX, kDateTopBtnY, kDateTopRightBtnWidth, kDateTopBtnHeight);
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.rightBtn.backgroundColor=[UIColor cyanColor];
        [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(handleDateTopViewRight) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}


- (UIView *)topView {
    if (!_topView) {
        self.topView = [[UIView alloc]initWithFrame:CGRectMake(kZero, kDateTopBtnY, kFullWidth, kDateTopBtnHeight)];
        self.topView.backgroundColor = [UIColor blackColor];

        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kFullWidth-2*(kDateTopLeftbtnX+kDateTopLeftBtnWidth) , kDateTopBtnHeight)];
        _titleLabel.text =@"选择时间";
        _titleLabel.textAlignment =NSTextAlignmentCenter ;
        _titleLabel.textColor =[UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.center = CGPointMake(_topView.frame.size.width/2, kDateTopBtnHeight/2);

        [self.topView addSubview: _titleLabel];
    }
    return _topView;
}




- (void)setOptionalMaxDate:(NSDate *)optionalMaxDate{
    _optionalMaxDate = optionalMaxDate;
    self.dateP.maximumDate = optionalMaxDate;
}

- (void)setOptionalMinDate:(NSDate *)optionalMinDate{
    _optionalMinDate = optionalMinDate;
    self.dateP.minimumDate = optionalMinDate;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

- (void)setNowTime:(NSString *)dateStr{

    [self.dateP setDate:[self dateFromString:dateStr] animated:YES];
}


- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}



- (void)end{
    [self removeFromSuperview];
}

- (void)handleDateP :(NSDate *)date {

    if (self.changeTimeBlock) {
        self.changeTimeBlock(self.dateP.date);
    }

    if ([self.delegate respondsToSelector:@selector(changeTime:)]) {
        [self.delegate changeTime:self.dateP.date];
    }

}

- (void)handleDateTopViewLeft {
    [self end];
}

- (void)handleDateTopViewRight {

    if (self.determineBlock) {
        self.determineBlock(self.dateP.date);
    }

    if ([self.delegate respondsToSelector:@selector(determine:)]) {
        [self.delegate determine:self.dateP.date];
    }
    [self end];
}




// NSDate --> NSString
- (NSString*)stringFromDate:(NSDate*)date{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (self.type) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSString *destDateString = [dateFormatter stringFromDate:date];

    return destDateString;

}

//NSDate <-- NSString
- (NSDate*)dateFromString:(NSString*)dateString{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (self.type) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSDate *destDate= [dateFormatter dateFromString:dateString];

    return destDate;
}

@end
