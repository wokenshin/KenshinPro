//
//  BlueVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "BlueVC.h"

@interface BlueVC ()

@end

@implementation BlueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)clickBtnBlue:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Blue view button pressed"
                                                    message:@"You pressed the button on the blue view"
                                                   delegate:nil
                                          cancelButtonTitle:@"Yep, I did."
                                          otherButtonTitles:nil];
    [alert show];
}


@end
