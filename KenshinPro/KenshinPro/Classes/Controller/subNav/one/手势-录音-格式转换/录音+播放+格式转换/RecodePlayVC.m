//
//  RecodePlayVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "RecodePlayVC.h"
#import "JJSJRecodeVoiceVC.h"

#import <AVFoundation/AVFoundation.h>//录音+播放录音
#import "VoiceConvert.h"//wav arm 格式互换

//也可以参考 Kenshin 项目中的 RecodeVoiceVC类

//本demo参考以下
//参考:https://www.jianshu.com/p/454081fd4446 录音、播放
//参考:https://www.jianshu.com/p/e872361daa68 wav 和 amr 格式互换  wav-->amr size几乎缩小10倍


//沙盒目录下文件名
NSString  *const PATH_WAV        = @"recode.wav";
NSString  *const PATH_WAV_TO_AMR = @"wavToAmr.amr";
NSString  *const PATH_AMR_TO_WAV = @"amrToWav.wav";

@interface RecodePlayVC ()

@property (weak, nonatomic) IBOutlet UILabel *labTips;

//录音
@property (nonatomic, strong) AVAudioRecorder    *audioRecorder;
@property (nonatomic, strong) NSURL              *recordUrl;

//播放
@property (nonatomic, strong) AVAudioPlayer      *audioPlayer;

//格式转换
@property (nonatomic, strong) NSString           *pathWav;//保存文件的路径
@property (nonatomic, strong) NSString           *pathAmr;

@end

@implementation RecodePlayVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"录音+播放";
    
    NSString *pathDoc = [Tools fxw_getPathDoc];
    NSString *pathWav = [pathDoc stringByAppendingPathComponent:PATH_AMR_TO_WAV];
//    /var/mobile/Containers/Data/Application/340ED92B-9DC5-475A-BE71-5F4353015A7C/Documents
//    /var/mobile/Containers/Data/Application/340ED92B-9DC5-475A-BE71-5F4353015A7C/Documents/amrToWav.wav
    
}

//录音设置
- (NSDictionary *)recodeCaf
{
    NSDictionary *result = nil;
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式 AVFormatIDKey==kAudioFormatLinearPCM
    // [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatAppleLossless] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];//一般的录音8000就可以了
    //录音通道数 1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数 8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    result = [NSDictionary dictionaryWithDictionary:recordSetting];
    return result;
    
}

//录音设置2
- (NSDictionary *)recodeWav
{
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,//录音格式
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                                   //[NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
                                   //[NSNumber numberWithInt: AVAudioQualityMedium],AVEncoderAudioQualityKey,//音频编码质量
                                   nil];
    return recordSetting;
}

#pragma mark 开始录音
- (IBAction)startRecode:(id)sender
{
    //AVAudioRecorder是录音必须要用的，其次就是要设置录音的路径，存放在本地，之后的播放或者说上传都通过此路劲进行进行操作
    NSLog(@"开始录音...");
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    //获取录音路径
    NSArray  *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir  = [dirPaths objectAtIndex:0];
    
    //注意这里的后缀名个是要和设置的录音参数一致 .caf 对应 [self recodeCaf]
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:PATH_WAV];
    _recordUrl = [NSURL fileURLWithPath:soundFilePath];
    _pathWav = soundFilePath;
    
    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:_recordUrl settings:[self recodeWav] error:&error];
    self.audioRecorder.meteringEnabled = YES;
    
    if ([self.audioRecorder prepareToRecord] == YES)
    {
        self.audioRecorder.meteringEnabled = YES;
        [self.audioRecorder record];
    }
    else
    {
        [self toastBottom:@"初始化录音失败"];
    }
    
}

#pragma mark 结束录音
- (IBAction)stopRecode:(id)sender
{
    if (_audioRecorder)
    {
        //if (_audioRecorder.isRecording){}
        [_audioRecorder stop];
    }
    else
    {
        [self toastBottom:@"请先录音"];
    }
    
}

#pragma mark 播放录音
- (IBAction)playRecode:(id)sender
{
    if (_recordUrl == nil)
    {
        [self toastBottom:@"请先录音"];
        return;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    if (_audioPlayer == nil)
    {
        NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_recordUrl error:&error];
        _audioPlayer.numberOfLoops = 0;
    }
    
    [_audioPlayer play];
    
}

//注意：由于音频格式转换使用到了一个第三方库 需要 BuildSetting 搜索 bitcode  设置为 NO 编译才会通过
//from:https://www.jianshu.com/p/e872361daa68
#pragma mark wav 转 amr
- (IBAction)clickBtnCafToAmr:(id)sender
{
    if (_pathWav == nil) {
        [self toastBottom:@"请先录音"];
        return;
    }
    
    //获取录音路径
    NSString *pathDoc = [Tools fxw_getPathDoc];
    NSString *pathAmr = [pathDoc stringByAppendingPathComponent:PATH_WAV_TO_AMR];
    
    int flag = [VoiceConvert ConvertWavToAmr:_pathWav amrSavePath:pathAmr];
    if (flag)
    {
        [self toastBottom:@"转换成功！"];
    }
    else
    {
        [self toastBottom:@"转换失败！"];
    }
}

#pragma mark amr 转 wav
- (IBAction)clickBtnAmrToCaf:(id)sender
{
    //1.现获取本地的amr
    NSString *pathDoc = [Tools fxw_getPathDoc];
    NSString *pathAmr = [pathDoc stringByAppendingPathComponent:PATH_WAV_TO_AMR];
    NSString *pathWav = [pathDoc stringByAppendingPathComponent:PATH_AMR_TO_WAV];
    
    //2.将amr转成wav
    int flag = [VoiceConvert ConvertAmrToWav:pathAmr wavSavePath:pathWav];
    if (flag)
    {
        [self toastBottom:@"转换成功！"];
    }
    else
    {
        [self toastBottom:@"转换失败！"];
    }
}

#pragma mark 播放 由amr转换后的caf
- (IBAction)clickBtnPlayAmarToCaf:(id)sender
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    if (_audioPlayer == nil)
    {
        NSError *error;
        
        //获取沙盒中由amr转换成的wav
        NSString *pathDoc = [Tools fxw_getPathDoc];
        NSString *pathWav = [pathDoc stringByAppendingPathComponent:PATH_AMR_TO_WAV];
        NSURL    *urlWav  = [NSURL fileURLWithPath:pathWav];
        
        _audioPlayer      = [[AVAudioPlayer alloc] initWithContentsOfURL:urlWav error:&error];
        _audioPlayer.numberOfLoops = 0;
    }
    
    [_audioPlayer play];
    
}

#pragma mark 封装后的操作
- (IBAction)clickBtnNextVC:(id)sender
{
    JJSJRecodeVoiceVC *vc = [[JJSJRecodeVoiceVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
