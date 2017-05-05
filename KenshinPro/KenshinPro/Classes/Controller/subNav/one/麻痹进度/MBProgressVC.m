//
//  MBProgressVC.m
//  GYBase
//
//  Created by doit on 16/5/13.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "MBProgressVC.h"
#import "MBProgressHUD.h"


@interface MBProgressVC ()

@end

@implementation MBProgressVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMBProgressVCUI];
    
}


- (void)initMBProgressVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"麻痹进度";
    
    CGFloat yBase = statusHeight + navBarHeight;
    CGFloat margin_10 = 10;
    
    WS(ws);
    
    //小菊花
    FXW_Button *proBtn = [[FXW_Button alloc] initWithFrame:CGRectMake(margin_10, yBase + margin_10, 100, 44)];
    proBtn.backgroundColor = RGB2Color(95, 165, 193);
    [proBtn setTitle:@"小菊花" forState:UIControlStateNormal];
    [proBtn clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws showMomentProgress];
    }];
    
    //标签句话
    FXW_Button *proBtn2 = [[FXW_Button alloc] initWithFrame:CGRectMake(margin_10*2 + 100, yBase + margin_10, 100, 44)];
    proBtn2.backgroundColor = RGB2Color(95, 165, 193);
    [proBtn2 setTitle:@"标签菊花" forState:UIControlStateNormal];
    [proBtn2 clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws labelJuHua];
    }];
    
    //下载菊花 圈中圈进度
    FXW_Button *proBtn3 = [[FXW_Button alloc] initWithFrame:CGRectMake(margin_10*3 + 200, yBase + margin_10, 100, 44)];
    proBtn3.backgroundColor = RGB2Color(95, 165, 193);
    [proBtn3 setTitle:@"圈中圈" forState:UIControlStateNormal];
    [proBtn3 clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws downloadJuHua];
    }];
    
    //下载菊花2 圈进度
    FXW_Button *proBtn4 = [[FXW_Button alloc] initWithFrame:CGRectMake(margin_10 , yBase + margin_10*2 + 44, 100, 44)];
    proBtn4.backgroundColor = RGB2Color(95, 165, 193);
    [proBtn4 setTitle:@"圈进度" forState:UIControlStateNormal];
    [proBtn4 clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws downloadJuHua2];
    }];
    
    //下载菊花3 横条进度
    FXW_Button *proBtn5 = [[FXW_Button alloc] initWithFrame:CGRectMake(margin_10*2 + 100 , yBase + margin_10*2 + 44, 100, 44)];
    proBtn5.backgroundColor = RGB2Color(95, 165, 193);
    [proBtn5 setTitle:@"横条" forState:UIControlStateNormal];
    [proBtn5 clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws downloadJuHua3];
    }];
    
    //吐司
    FXW_Button *proBtn6 = [[FXW_Button alloc] initWithFrame:CGRectMake(margin_10*3 + 200 , yBase + margin_10*2 + 44, 100, 44)];
    proBtn6.backgroundColor = RGB2Color(95, 165, 193);
    [proBtn6 setTitle:@"吐司" forState:UIControlStateNormal];
    [proBtn6 clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws toast];
    }];
    
    //自定义
    FXW_Button *proBtn7 = [[FXW_Button alloc] initWithFrame:CGRectMake(margin_10, yBase + margin_10*3 + 44*2, 100, 44)];
    proBtn7.backgroundColor = RGB2Color(95, 165, 193);
    [proBtn7 setTitle:@"自定义" forState:UIControlStateNormal];
    [proBtn7 clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws customAlert];
    }];
    
    //吐司
    
    [self.view addSubview:proBtn];
    [self.view addSubview:proBtn2];
    [self.view addSubview:proBtn3];
    [self.view addSubview:proBtn4];
    [self.view addSubview:proBtn5];
    [self.view addSubview:proBtn6];
    [self.view addSubview:proBtn7];
    
}

//显示三秒的小菊花
- (void)showMomentProgress
{
    //look 小菊花！
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        // Do something useful in the background
        [self doSomeWork];
        
        // IMPORTANT - Dispatch back to the main thread. Always access UI
        // classes (including MBProgressHUD) on the main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
}

#pragma mark - Tasks
- (void)doSomeWork
{
    // Simulate by just waiting.
    sleep(3.);
    
}

//标签菊花
- (void)labelJuHua
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the label text.
    hud.labelText = @"Loading...";
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
    
}

//下载菊花 圈中圈进度
- (void)downloadJuHua
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the determinate mode to show task progress.
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.
        [self doSomeWorkWithProgress];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
    
}

//下载菊花2 通过 mode 设置
- (void)downloadJuHua2
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.
        [self doSomeWorkWithProgress];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
    
}

//下载菊花3 通过 mode 设置
- (void)downloadJuHua3
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the bar determinate mode to show task progress.
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.labelText = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.
        [self doSomeWorkWithProgress];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
    
}

//吐司
- (void)toast
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Message here!";
    // Move to bottm center.
    //hud.offset = CGPointMake(0.f, MBProgressMaxOffset);//MBProgressMaxOffset
    hud.center = CGPointMake(screenWidth/2, screenHeight/2);
    [hud hide:YES afterDelay:3.F];
    
}

//自定义
- (void)customAlert//会根据图片大小自动调整view的大小
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.labelText = NSLocalizedString(@"Done", @"HUD done title");
    
    [hud hide:YES afterDelay:3.F];
    
}

- (void)doSomeWorkWithProgress {
//    self.canceled = NO;
    // This just increases the progress indicator in a loop.
    float progress = 0.0f;
    while (progress < 1.0f)
    {
//        if (self.canceled) break;
        progress += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            [MBProgressHUD HUDForView:self.navigationController.view].progress = progress;
        });
        usleep(50000);
        
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
