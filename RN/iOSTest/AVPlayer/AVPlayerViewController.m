//
//  AVPlayerViewController.m
//  RN
//
//  Created by sangfor on 2017/12/18.
//  Copyright © 2017年 LL. All rights reserved.
//

#import "AVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerViewController ()

/** 播放器 */
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSString *status_playType; // 正在播放, 等待播放
@property (nonatomic, strong) UILabel *currentTimeLable; // 显示 当前播放时长

@end

@implementation AVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentTimeLable = [[UILabel alloc ] initWithFrame:CGRectMake(0, 240, self.view.frame.size.width, 400)];
    self.currentTimeLable.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.currentTimeLable];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        //        NSLog(@"%d", status);
        if (AVPlayerItemStatusReadyToPlay == status) {
            
            
        } else {
            
            
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"已缓存时长 : %f",timeInterval);
        
        self.currentTimeLable.text = [NSString stringWithFormat:@"当前播放时长： %f \\n 已缓存： %f", self.getCurrentPlayingTime, timeInterval];
        
        if (timeInterval > self.getCurrentPlayingTime+5){ // 缓存 大于 播放 当前时长+5
            
            if ([self.status_playType  isEqual: @"等待播放"]) { // 接着之前 播放时长 继续播放
                [self.player play];
                self.status_playType = @"正在播放";
            }
        }else{
            self.status_playType = @"等待播放"; // 出现问题，等待播放
            NSLog(@"等待播放，网络出现问题");
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.player play];
    self.status_playType = @"正在播放";
    
    [[self.player.currentItem valueForKey:@"_playerItem"] addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
}

#pragma mark - 懒加载代码
- (AVPlayer *)player
{
    if (_player == nil) {
        // 1.创建URL
        NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4"];
        // NSURL *url = [[NSBundle mainBundle] URLForResource:@"01-知识回顾.mp4" withExtension:nil];
        
        // 2.创建AVPlayer对象
        AVPlayerItem *_playerItem = [[AVPlayerItem alloc] initWithURL:url];
        _player = [[AVPlayer alloc] initWithPlayerItem:_playerItem];
        
        // 3.创建播放layer
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        layer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
        [self.view.layer addSublayer:layer];
    }
    return _player;
}

/**
 *  返回 当前 视频 播放时长
 */
- (double)getCurrentPlayingTime{
    return self.player.currentTime.value/self.player.currentTime.timescale;
}

/**
 *  返回 当前 视频 缓存时长
 */
- (NSTimeInterval)availableDuration{
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    
    return result;
}


-(void)dealloc
{
//    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
//    [[self.player.currentItem valueForKey:@"_playerItem"] removeObserver:self forKeyPath:@"status"];
}

@end
