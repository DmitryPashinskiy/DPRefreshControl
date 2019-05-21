//
//  DPRefreshVideoAnimation.m
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 2/12/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "DPRefreshVideoAnimation.h"
@import AVFoundation;

static const CGFloat kDPVideoLayerDefaultHeight = 150.0f;
static const CGFloat kDPVideoPreferredTimeScale = 60000;


@interface DPRefreshVideoAnimation ()
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (weak, nonatomic) UIView * viewForAnimation;
@property (strong, nonatomic) NSURL *videoURL;

@end



@implementation DPRefreshVideoAnimation

+ (instancetype)animation {
    DPRefreshVideoAnimation *animation = [DPRefreshVideoAnimation new];
    animation.videoHeight = kDPVideoLayerDefaultHeight;
    
    return animation;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - Public Methods

- (void)setupVideo:(NSURL*)videoURL {
    _videoURL = videoURL;
    _player = [AVPlayer playerWithURL:videoURL];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[_player currentItem]];
}



#pragma mark - Selectors

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}




#pragma mark - Preparing Animation lifecycle

- (UIView*)sceneForAnimation {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    width = MIN(width, [self videoSizeAtURL:_videoURL].width);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, _videoHeight)];
    [view.layer addSublayer:self.playerLayer];
    [self.playerLayer setFrame:view.frame];
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    view.backgroundColor = [UIColor blackColor];
    
    _viewForAnimation = view;
    
    return view;
}



#pragma mark - Animations lifecycle
- (void)setStretchPercent:(CGFloat)percent {
    CGFloat seconds = percent * _playSecondsBeforeRefresh;
    CMTime time = CMTimeMakeWithSeconds(seconds, kDPVideoPreferredTimeScale);
    [self.player seekToTime:time];
}

- (void)setUpAnimations {
    [self.player play];
}

- (void)removeAnimations {
    [self.player pause];
}



#pragma mark - Private Methods

- (CGSize)videoSizeAtURL:(NSURL*)videoURL {
    if (!videoURL){
        return CGSizeZero;
    }
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    AVAssetTrack *track = [tracks objectAtIndex:0];
    
    return track.naturalSize;
}

@end
