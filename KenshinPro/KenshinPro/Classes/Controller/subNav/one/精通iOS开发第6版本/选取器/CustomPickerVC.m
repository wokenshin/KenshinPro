//
//  CustomPickerVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "CustomPickerVC.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CustomPickerVC ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray   *arrImage;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel      *labResult;
@property (weak, nonatomic) IBOutlet UIButton     *btn;//当启动游戏时禁用按钮，游戏结束时取消禁用

@end

@implementation CustomPickerVC{
    SystemSoundID winSoundID;//这是什么鬼？
    SystemSoundID crunchSoundID;
}

//节约时间只找到一个音效
NSString * const soundTypePaly   = @"pickerPlay";
NSString * const soundTypeWining = @"pickerPlay";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"page 163";
    [self loadData];
    //获取当前设备可用字体并输出
//    for (NSString *family in [UIFont familyNames]) {
//        NSLog(@"%@", family);
//        for (NSString *font in [UIFont fontNamesForFamilyName:family]) {
//            NSLog(@"\t%@", font);
//        }
//
//    }
    
}

- (void)loadData{
    _arrImage = @[[UIImage imageNamed:@"btn_lock_changeLock"],
                  [UIImage imageNamed:@"btn_lock_del"],
                  [UIImage imageNamed:@"btn_lock_off"],
                  [UIImage imageNamed:@"btn_lock_on"],
                  [UIImage imageNamed:@"btn_lock_phoneKey"],
                  [UIImage imageNamed:@"btn_lock_pwd"]];
    
    srandom(time(NULL));//什么意思?
}

- (IBAction)clickBtn:(UIButton *)button {
    
    BOOL isWin    = NO;
    long numInRow = 1;
    long lastVal  = -1;
    
    for (int i = 0; i < 5 ; i++) {
        long newValue = random() % [_arrImage count];
        
        if (newValue == lastVal) {
            numInRow++;
        } else {
            numInRow = 1;
        }
        lastVal = newValue;
        [_pickerView selectRow:newValue inComponent:i animated:YES];
        [_pickerView reloadComponent:i];
        if (numInRow >= 3) {
            isWin = YES;
        }
    }
    if (crunchSoundID == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:soundTypePaly ofType:@"wav"];
        NSURL *soundURL = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &crunchSoundID);
    }
    AudioServicesPlaySystemSound(crunchSoundID);
    
    if (isWin) {
        [self performSelector:@selector(playWinSound) withObject:nil afterDelay:0.5];
    } else {
        [self performSelector:@selector(showButton) withObject:nil afterDelay:0.5];
    }
    
    _btn.hidden     = YES;
    _labResult.text = @"";
    
}

- (void)showButton{
    _btn.hidden = NO;
}

- (void)playWinSound{
    if (winSoundID == 0) {
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:soundTypeWining withExtension:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &winSoundID);
    }
    AudioServicesPlaySystemSound(winSoundID);
    _labResult.text = @"WINING!";
    
    //延迟执行
    [self performSelector:@selector(showButton) withObject:nil afterDelay:1.5];
    
}

#pragma mark -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;//轮子个数
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_arrImage count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view{
    UIImage *image = _arrImage[row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    return imageView;
}


@end
