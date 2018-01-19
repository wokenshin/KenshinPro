//
//  JJSJRecodeVoiceVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/1/17.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "JJSJRecodeVoiceVC.h"
#import "FXWRecodeVoice.h"

@interface JJSJRecodeVoiceVC ()

@property (nonatomic, strong) FXWRecodeVoice            *recodeVoiceTools;
@property (nonatomic, strong) NSString                  *pathWav;
@end

@implementation JJSJRecodeVoiceVC

- (void)viewDidLoad
{
    self.navigationItem.title = @"封装实例";
    [super viewDidLoad];
    _recodeVoiceTools = [[FXWRecodeVoice alloc] init];
    _recodeVoiceTools.isPrintLog = YES;
    
}

#pragma mark 开始录音
- (IBAction)clickStartRecodeVoice:(id)sender
{
    if (![_recodeVoiceTools startRecodeVoice]) {
        [self toastBottom:@"录音失败"];
    }
    
}

#pragma mark 结束录音
- (IBAction)clickBtnStopRecodeVoice:(id)sender
{
    _pathWav = [_recodeVoiceTools finishRecodeVoice];
    
}

#pragma mark 取消录音
- (IBAction)clickBtnDeletRecodeVoice:(id)sender
{
    BOOL flag = [_recodeVoiceTools cancelRecodeVoice];
    if (flag)
    {
        [self toastBottom:@"删除成功"];
    }
    else
    {
        [self toastBottom:@"删除失败"];
    }
}

#pragma mark 播放录音 wav
- (IBAction)clickBtnPlayVoice:(id)sender
{
    [_recodeVoiceTools playRecodeVoiceWithPath:_pathWav];
}

#pragma mark wav->amr
- (IBAction)clickBtnWavToAmr:(id)sender
{
    NSString *pathAmr = [_recodeVoiceTools wavToAmrWithPathWav:_pathWav];
    if (pathAmr)
    {
        [self toastBottom:@"转换成功"];
    }
    else
    {
        [self toastBottom:@"转换失败"];
    }
}

#pragma mark amr->wav
- (IBAction)clickBtnAmrToWav:(id)sender
{
    //注意 这里的pathAmr的路径下未必有文件 只有在前面的方法中已经将.wav-->.amr 后才会有数据
    NSString *pathArm = [_pathWav stringByReplacingOccurrencesOfString:@".wav" withString:@".amr"];
    NSString *pathWav = [_recodeVoiceTools amrToWavWithPathAmr:pathArm];
    if (pathWav)
    {
        [self toastBottom:@"转换成功"];
    }
    else
    {
        [self toastBottom:@"转换失败"];
    }
}

#pragma mark 播放amr转换后的wav
- (IBAction)clickBtnPlayAmrToWav:(id)sender
{
    //注意 这里的pathAmr的路径下未必有文件 只有在前面的方法中已经将.wav-->.amr 后才会有数据
    NSString *pathArm = [_pathWav stringByReplacingOccurrencesOfString:@".wav" withString:@".amr"];
    [_recodeVoiceTools playRecodeVoiceWithPath:pathArm];
}

#pragma mark 获取时长
- (IBAction)clickBtnVoiceDuration:(id)sender
{
    //先获取.amr的，如果路径为空，就获取.wav的 如果路径还为空 返回获取失败
    
    //注意 这里的pathAmr的路径下未必有文件 只有在前面的方法中已经将.wav-->.amr 后才会有数据
    NSString *pathArm = [_pathWav stringByReplacingOccurrencesOfString:@".wav" withString:@".amr"];
    NSInteger time = [_recodeVoiceTools durationWithPath:pathArm];
    if (time == 0)
    {
        time = [_recodeVoiceTools durationWithPath:_pathWav];
    }
    if (time == 0)
    {
        [self toastBottom:@"获取时间失败"];
    }
    else
    {
        NSString *log = [NSString stringWithFormat:@"%zd", time];
        [self toastBottom:log];
    }
}


- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
