//
//  FXWRecodeVoice.h
//  PublicService
//
//  Created by kenshin van on 2018/1/17.
//  Copyright © 2018年 jjsj. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 录音工具类
 
 1.开始录音 录音格式为 .wav
 2.完成录音 录音成功过后 返回录音文件路径
 3.获取音频时长 秒
 4.取消录音 [2.1. 完成录音并删除录音文件]
 5.播放录音 .wav  [iOS不支持播放.amr格式]
 6.格式转换 .wav --> .amr     .amr-->.wav 转换后的文件保存在原路径下，只是后缀名和格式被替换
 
 */
@interface FXWRecodeVoice : NSObject

/**
 是否打印相关日志 默认为不打印
 */
@property (nonatomic, assign) BOOL isPrintLog;


/**
 开始录音
 */
- (BOOL)startRecodeVoice;

/**
 完成录音
 */
- (NSString *)finishRecodeVoice;

/**
 获取音频时长

 @param savePath 音频路径
 @return 时长 秒
 */
- (NSInteger)durationWithPath:(NSString *)savePath;

/**
 取消录音
 */
- (BOOL)cancelRecodeVoice;

/**
 播放录音 .wav

 @param path 录音路径
 @return     是否可以播放
 */
- (BOOL)playRecodeVoiceWithPath:(NSString *)path;

/**
 音频格式转换 wav-->amr

 @param pathWav 需要被转换格式的 .wav文件路径
 @return 转换成功后返回地址 否则返回 nil
 */
- (NSString *)wavToAmrWithPathWav:(NSString *)pathWav;

/**
 音频格式转换 amr-->wav

 @param pathAmr 需要被转换格式的 .amr文件路径
 @return 转换成功后返回地址 否则返回 nil
 */
- (NSString *)amrToWavWithPathAmr:(NSString *)pathAmr;


@end
