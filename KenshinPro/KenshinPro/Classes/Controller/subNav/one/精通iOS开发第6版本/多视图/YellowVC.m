//
//  YellowVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "YellowVC.h"

@interface YellowVC ()

@end

@implementation YellowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)clickBtnYellow:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yellow view button pressed"
                                                    message:@"You pressed the button on the yellow view"
                                                   delegate:nil
                                          cancelButtonTitle:@"Yep, I did."
                                          otherButtonTitles:nil];
    [alert show];
    
}


@end
