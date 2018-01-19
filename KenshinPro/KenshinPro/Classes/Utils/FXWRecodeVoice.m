//
//  FXWRecodeVoice.m
//  PublicService
//
//  Created by kenshin van on 2018/1/17.
//  Copyright © 2018年 jjsj. All rights reserved.
//

#import "FXWRecodeVoice.h"
#import <AVFoundation/AVFoundation.h>//录音+播放录音
#import "VoiceConvert.h"//wav arm 格式互换


/**
 优化：
 1.可以在工具类中限制 录音时间最长为60s
 2.在录音方法中要避免连续点击
 3.应该将文件统一保存在 指定目录下的一个子文件夹下，方便后期删除所有文件等操作
 */
@interface FXWRecodeVoice()

//录音
@property (nonatomic, strong) AVAudioRecorder    *audioRecorder;
@property (nonatomic, strong) NSURL              *recordUrl;

//播放
@property (nonatomic, strong) AVAudioPlayer      *audioPlayer;

//格式转换
@property (nonatomic, strong) NSString           *pathWav;//保存文件的路径
@property (nonatomic, strong) NSString           *pathAmr;

@end;



@implementation FXWRecodeVoice

#pragma mark - publick

#pragma mark 开始录音
- (BOOL)startRecodeVoice
{
    //避免连续点击
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    //获取录音保存路径
    NSArray  *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir  = [dirPaths objectAtIndex:0];
    
    //获取当前时间戳+.wav 作为录音文件名
    NSDate *date       = [NSDate dateWithTimeIntervalSinceNow:0];
    NSInteger time     = (NSInteger)[date timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%zd.wav", time];
    
    //注意这里的后缀名格式要和设置的录音参数一致 .caf 对应 [self recodeCaf]
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:fileName];
    _recordUrl = [NSURL fileURLWithPath:soundFilePath];
    _pathWav   = soundFilePath;
    
    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:_recordUrl settings:[self recodeWav] error:&error];
    self.audioRecorder.meteringEnabled = YES;
    
    if ([self.audioRecorder prepareToRecord] == YES)
    {
        self.audioRecorder.meteringEnabled = YES;
        [self.audioRecorder record];
        [self logTools:@"开始录音..."];
        return YES;
    }
    else
    {
        [self logTools:@"初始化录音失败"];
        return NO;
    }
}

#pragma mark 完成录音
- (NSString *)finishRecodeVoice
{
    if (_audioRecorder)
    {
        [_audioRecorder stop];
        NSString *tips = [NSString stringWithFormat:@"录音完成 path:%@", _pathWav];
        [self logTools:tips];
        return _pathWav;
    }
    [self logTools:@"请先录音"];
    return nil;
    
}

//获取音频时长
- (NSInteger)durationWithPath:(NSString *)savePath
{
    if ([self strIsKong:savePath]) {
        [self logTools:@"获取时长失败 路径为空"];
        return 0;
    }
    
    AVURLAsset* audioAsset     = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:savePath] options:nil];
    CMTime audioDuration       = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    NSInteger second           = (NSInteger)audioDurationSeconds;
    return second;
    
}

//根据录音找到文件 播放录音，如果找不到就返回NO 此时需要下载网络文件后进行播放
- (BOOL)playRecodeVoiceWithPath:(NSString *)path
{
    //参数校验
    if ([self strIsKong:path])
    {
        [self logTools:@"播放录音失败，播放路径为空"];
        return NO;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    if (_audioPlayer == nil)
    {
        NSError *error;
        NSURL *pathUrl = [NSURL URLWithString:path];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:pathUrl error:&error];
        if (_audioPlayer == nil)//如果路径下没有可播放的文件会返回nil
        {
            NSString *log = [NSString stringWithFormat:@"播放失败，找不到改文件 path：%@", path];
            [self logTools:log];
            return NO;
        }
        _audioPlayer.numberOfLoops = 0;
    }
    
    [_audioPlayer play];
    return YES;
}

#pragma mark 取消录音
- (BOOL)cancelRecodeVoice
{
    //先停止录音，然后删除录音
    if ([self strIsKong:_pathWav]) {
        [self logTools:@"删除录音文件失败-路径为空"];
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL flag = [fileManager removeItemAtPath:_pathWav error:nil];
    if(flag)
    {
        [self logTools:@"删除录音文件成功"];
    }
    else
    {
        [self logTools:@"删除录音文件失败"];
    }
    return flag;
    
}

#pragma mark 格式转换 wav-->amr
- (NSString *)wavToAmrWithPathWav:(NSString *)pathWav
{
    if ([self strIsKong:pathWav])
    {
        [self logTools:@"wav-->amr 转换失败-路径为空"];
        return nil;
    }
    
    //将xxx.wav的路径改为 xxx.amr赋值给pathAmr
    NSString *pathAmr = [pathWav stringByReplacingOccurrencesOfString:@".wav" withString:@".amr"];
    
    int flag = [VoiceConvert ConvertWavToAmr:pathWav amrSavePath:pathAmr];
    if (flag)
    {
        NSString *log = [NSString stringWithFormat:@"pathAmr:%@", pathAmr];
        [self logTools:@"wav-->amr 转换成功"];
        [self logTools:log];
        return pathAmr;
    }
    else
    {
        [self logTools:@"wav-->amr 转换失败"];
        return nil;
    }
}

#pragma mark 格式转换 amr-->wav
- (NSString *)amrToWavWithPathAmr:(NSString *)pathAmr
{
    if ([self strIsKong:pathAmr]) {
        [self logTools:@"amr-->wav 转换失败-路径为空"];
        return nil;
    }
    
    //将xxx.amr的路径改为 xxx.wav赋值给pathWav
    NSString *pathWav = [pathAmr stringByReplacingOccurrencesOfString:@".amr" withString:@".wav"];
    int flag = [VoiceConvert ConvertAmrToWav:pathAmr wavSavePath:pathWav];
    if (flag)
    {
        NSString *log = [NSString stringWithFormat:@"pathWav:%@", pathWav];
        [self logTools:@"amr-->wav 转换成功"];
        [self logTools:log];
        return pathWav;
    }
    else
    {
        [self logTools:@"amr-->wav 转换失败"];
        return nil;
    }
    
}



#pragma mark - private
//输出本类的日志
- (void)logTools:(NSString *)content
{
    if ([self strIsKong:content]) {
        return;
    }
    if (_isPrintLog)//如果需要打印日志 初始化实例时 可以设置改变量
    {
        NSLog(@"FXWRecodeVoice类 %@", content);
    }
    
}

//判断字符串是否为空 nil  null  @""
- (BOOL)strIsKong:(NSString *)str
{
    if ([str isEqual:[NSNull null]] || str == nil || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

#pragma mark 设置录音格式
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
@end
