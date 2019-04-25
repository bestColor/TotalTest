//
//  ifly-demo.m
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

#import "ifly-demo.h"
#import <iflyMSC/IFlyMSC.h>
#import "ISRDataHelper.h"
#import "SPActivityIndicatorView.h"
#import "PCMFilePlayer.h"

@interface ifly_demo ()<IFlySpeechRecognizerDelegate>

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;       // 不带界面的识别对象

@property (strong, nonatomic) UITextView *resultTextView;                       // 语音识别的结束展示

@property (strong, nonatomic) UIButton *recordButton;                           // 录音按钮
@property (strong, nonatomic) SPActivityIndicatorView *indiView;                // 录音动画展示

@end

@implementation ifly_demo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"讯飞长时间语音识别+pcm文件存储和播放";
    self.view.backgroundColor = [UIColor whiteColor];

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width - 20, 200)];
    textView.userInteractionEnabled = NO;
    [textView.layer setCornerRadius:5];
    [textView.layer setBorderColor:[UIColor grayColor].CGColor];
    [textView.layer setBorderWidth:1.0f];
    [textView.layer setMasksToBounds:YES];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:textView];
    
    self.resultTextView = textView;
    
    _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _recordButton.frame = CGRectMake((textView.frame.size.width - 150)/2.0, textView.frame.size.height+textView.frame.origin.y+10, 150, 44);
    [_recordButton setTitle:@" 点击 录音" forState:UIControlStateNormal];
    [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_recordButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [_recordButton setTitle:@" 结束 录音" forState:UIControlStateSelected];
    [_recordButton addTarget:self action:@selector(recordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _recordButton.selected = NO;
    [self.view addSubview:_recordButton];
    
    SPActivityIndicatorView *activityIndicatorView = [[SPActivityIndicatorView alloc] initWithType:SPActivityIndicatorAnimationTypeLineScalePulseOut tintColor:[UIColor grayColor]];
    activityIndicatorView.frame = CGRectMake(_recordButton.frame.origin.x+_recordButton.frame.size.width, _recordButton.frame.origin.y, 100, _recordButton.frame.size.height);
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView stopAnimating];
    self.indiView=  activityIndicatorView;
    
    
    UIButton *lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lastButton.frame = CGRectMake((textView.frame.size.width - 250)/2.0, _recordButton.frame.size.height+_recordButton.frame.origin.y+50, 250, 44);
    [lastButton setTitle:@"播放最后一次的录音" forState:UIControlStateNormal];
    [lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lastButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [lastButton addTarget:self action:@selector(lastButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lastButton];
    
    UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allButton.frame = CGRectMake((textView.frame.size.width - 200)/2.0, lastButton.frame.origin.y+50+lastButton.frame.size.height, 200, 44);
    [allButton setTitle:@"播放所有的录音" forState:UIControlStateNormal];
    [allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [allButton addTarget:self action:@selector(allButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allButton];
}

/// 播放按钮点击
- (void)recordButtonClick:(UIButton *)sender
{
    if (sender.selected) {
        [self stopAudio];
        [self.indiView stopAnimating];
    } else {
        [self startAudio];
        [self.indiView startAnimating];
    }
    sender.selected = !sender.selected;
}


/// 开始语音识别
- (void)startAudio
{
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                [self.iFlySpeechRecognizer startListening];
            } else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法录音" message:@"请在iPhone的“设置-隐私-麦克风”选项中，允许访问你的手机麦克风" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击取消");
                }]];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                        }];
                    }
                }]];
                
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }
        });
    }];
}


/// 停止语音识别
- (void)stopAudio
{
    if ([self.iFlySpeechRecognizer isListening]) {
        [self.iFlySpeechRecognizer stopListening];
    }
}

#pragma mark - IFlySpeechRecognizerDelegate协议实现
/* 懒加载，讯飞语音识别类 */
-(IFlySpeechRecognizer *)iFlySpeechRecognizer
{
    if (!_iFlySpeechRecognizer) {
        //创建语音识别对象
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        //设置识别参数
        //设置为听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        //asr_audio_path 是录音文件名，设置 value 为 nil 或者为空取消保存，默认保存目录在 Library/cache 下。
        [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        //设置最长录音时间:60秒
        [_iFlySpeechRecognizer setParameter:@"-1" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置语音后端点:后端点静音检测时间，即用户停止说话多长时间内即认为不再输入， 自动停止录音
        [_iFlySpeechRecognizer setParameter:@"10000" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置语音前端点:静音超时时间，即用户多长时间不说话则当做超时处理
        [_iFlySpeechRecognizer setParameter:@"5000" forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"2000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        //设置语言
        [_iFlySpeechRecognizer setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        //        [_iFlySpeechRecognizer setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
        //设置代理
        _iFlySpeechRecognizer.delegate = self;
    }
    return _iFlySpeechRecognizer;
}

//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    NSString *resultStringFromJson = [ISRDataHelper stringFromJson:resultString];
    
    [self updateSpeechRecognitionWithResultString:resultStringFromJson];
}

/// 实时显示语音识别的结果
- (void)updateSpeechRecognitionWithResultString:(NSString *)resultString
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.resultTextView.text = [NSString stringWithFormat:@"%@%@",self.resultTextView.text, resultString];
    });
}

//开始录音回调
-(void)onBeginOfSpeech
{
    NSLog(@"讯飞- 开始语音识别");
}

//音量回调函数
-(void)onVolumeChanged:(int)volume
{
    
}

//会话取消回调
-(void)onCancel
{
    NSLog(@"讯飞- 取消本次语音识别");
}

//停止录音回调
-(void)onEndOfSpeech
{
    NSLog(@"讯飞- 结束语音识别");
    
}

//会话结束，会话是否结束，以此为准
- (void) onCompleted:(IFlySpeechError *) errorCode
{
    NSLog(@"讯飞- error = %@-%d-%d", errorCode.errorDesc, errorCode.errorCode, errorCode.errorType);
    if (errorCode.errorType != 0) {
        // 结束语音识别
        if (errorCode.errorType == 1) {
            /// 无网络连接错误
        } else if (errorCode.errorType == 2) {
            /// 网络连接超时错误
        }
        
        [self.indiView stopAnimating];
        self.recordButton.selected = NO;
    } else {
        /// 正常结束语音识别
        /// 这里来处理UI，如果要长时间录音，就放开下面这个方法
        [self.iFlySpeechRecognizer startListening];
        
    }


    /// 如果是保存录音pcm文件，如果长时间录音，就会拼接pcm的二进制，重新保存为新的二进制文件
    NSString * kPROJECT_ALL_AUDIO_PATH = [NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableData *newData = [[NSMutableData alloc] init];
    
    NSString *newVideoPath = [NSString stringWithFormat:@"%@/iat.pcm",kPROJECT_ALL_AUDIO_PATH];
    NSString *totalVideoPath = [NSString stringWithFormat:@"%@/end.pcm",kPROJECT_ALL_AUDIO_PATH];
    
    if ([fileManager fileExistsAtPath:totalVideoPath]) {
        NSURL *oldUrl = [NSURL fileURLWithPath:totalVideoPath];
        newData = [[NSMutableData alloc] initWithContentsOfURL:oldUrl];
    }
    
    if ([fileManager fileExistsAtPath:newVideoPath]) {
        NSURL *newUrl = [NSURL fileURLWithPath:newVideoPath];
        [newData appendData:[[NSData alloc] initWithContentsOfURL:newUrl]];
    }
    
    if (newData.length) {
        [newData writeToFile:totalVideoPath atomically:YES];
    }
}

#pragma mark - 播放pcm相关
- (void)lastButtonClick
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * kPROJECT_ALL_AUDIO_PATH = [NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()];

    NSString *newVideoPath = [NSString stringWithFormat:@"%@/iat.pcm",kPROJECT_ALL_AUDIO_PATH];
    if ([fileManager fileExistsAtPath:newVideoPath]) {
        [[PCMFilePlayer sharePlayer] player:newVideoPath];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"没有录音文件" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    
}

- (void)allButtonClick
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * kPROJECT_ALL_AUDIO_PATH = [NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()];

    NSString *totalVideoPath = [NSString stringWithFormat:@"%@/end.pcm",kPROJECT_ALL_AUDIO_PATH];
    if ([fileManager fileExistsAtPath:totalVideoPath]) {
        [[PCMFilePlayer sharePlayer] player:totalVideoPath];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"没有录音文件" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];

        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
