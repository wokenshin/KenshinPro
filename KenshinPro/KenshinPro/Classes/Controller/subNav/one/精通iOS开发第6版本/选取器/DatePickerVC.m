//
//  DatePickerVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "DatePickerVC.h"
#import "MainTabBarVC.h"

@interface DatePickerVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDate;

@end

@implementation DatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日期选取器";
    
    [self logoutUI];
    NSDate *now = [NSDate date];
    _pickerDate.date = now;
    
}

- (void)logoutUI{
    [self setNavLeftBtnWithName:@"推出" andClickResultblock:^{
        
        MainTabBarVC *vc = [[MainTabBarVC alloc] init];
        
        [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
            [UIView setAnimationsEnabled:oldState];
            
        } completion:^(BOOL finished) {}];
        
    }];
}

- (IBAction)clickBtn:(id)sender {
    NSDate *selected = [_pickerDate date];
    NSString *msg = [NSString stringWithFormat:@"The date and time you selected is: %@", selected];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Date and time selected"
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"That's so true!"
                                          otherButtonTitles:nil];
    [alert show];
}


@end
