//
//  PlayerController.m
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "PlayerController.h"
#import "DataModel.h"
#import "PlayerBar.h"
#import "Song.h"
#import "STKAudioPlayer.h"
#import "MusicianListViewController.h"
#import "QueueId.h"

@interface PlayerController ()

@end

@implementation PlayerController {
    DataModel *_dataModel;
    PlayerBar *_playerBar;
    STKAudioPlayer *_audioPlayer;
}

- (id)initWithDataModel:(DataModel *)dataModel andPlayerBar:(PlayerBar *)playerBar {
    self = [super init];
    if (self) {
        _dataModel = dataModel;
        playerBar.delegate = self;
        _playerBar = playerBar;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTimer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    MusicianListViewController *viewController = [[MusicianListViewController alloc] initWithDataModel:_dataModel andPlayerBar:_playerBar];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navController.delegate = viewController;
    
    [self presentViewController:navController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma MusicianDetailViewDelegate

- (void)didSelectASongToPlay {
    Song *chosenSong = _dataModel.chosenSong;
    if (chosenSong != nil) {
        //start to play
        NSURL *urlToPlay = [NSURL URLWithString:chosenSong.mp3Url];
        STKDataSource *dataSrc = [STKAudioPlayer dataSourceFromURL:urlToPlay];
        [self.audioPlayer setDataSource:dataSrc withQueueItemId:[[QueueId alloc] initWithUrl:urlToPlay andCount:0]];
        
        //playerBar
        _playerBar.songTitleLabel.text = chosenSong.title;
    }
}

#pragma AudioPlayer

- (void)setupTimer {
    NSTimer *timer =[NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

//- (void)tick {
//    //slider
//    if (!self.audioPlayer) {
//        _playerBar.slider.value = 0;
//        return;
//    }
//    if (self.audioPlayer.duration != 0) {
//        [self configureSliderWithMin:0 andMax:self.audioPlayer.duration andValue:self.audioPlayer.progress];
//        if (self.audioPlayer.state == STKAudioPlayerStatePlaying) {
//            [self updatePlayingTime];
//        }
//    } else {
//        [self configureSliderWithMin:0 andMax:0 andValue:0];
//    }
//}

- (void)tick {
    //slider
    if (self.audioPlayer.duration != 0) {
        if (self.audioPlayer.state == STKAudioPlayerStatePlaying) {
            [self updatePlayingTime];
        }
    }
}

- (void)updatePlayingTime {
    NSString *total = [self formatTimeFromSeconds:self.audioPlayer.duration];
    NSString *progress = [self formatTimeFromSeconds:self.audioPlayer.progress];
    _playerBar.songStateLabel.text = [NSString stringWithFormat:@"%@/%@", progress, total];
}

//- (void)configureSliderWithMin:(double)min andMax:(double)max andValue:(double)value {
//    _playerBar.slider.minimumValue = min;
//    _playerBar.slider.maximumValue = max;
//    _playerBar.slider.value = value;
//}

- (void)updatePlayerState {
    if (!self.audioPlayer || _dataModel.chosenSong == nil) {
        return;
    }
    if (self.audioPlayer.state == STKAudioPlayerStateStopped) {
        _playerBar.songTitleLabel.text = @"-";
        _playerBar.songStateLabel.text = @"-/-";
        _dataModel.chosenSong = nil;
    } else if (self.audioPlayer.state == STKAudioPlayerStateBuffering) {
        _playerBar.songStateLabel.text = @"buffering";
    } else if (self.audioPlayer.state == STKAudioPlayerStatePaused) {
        _playerBar.songStateLabel.text = @"paused";
    }
}

-(NSString*) formatTimeFromSeconds:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60);
    
    return [NSString stringWithFormat:@"%02d:%02d",  minutes, seconds];
}

#pragma PlayerBarDelegate

- (void)sliderChanged {
//    if (!self.audioPlayer) {
//        return;
//    }
//    [self.audioPlayer seekToTime:_playerBar.slider.value];
}

- (void)toggled {
    if (self.audioPlayer.state == STKAudioPlayerStatePlaying) {
        [self.audioPlayer pause];
    } else if (self.audioPlayer.state == STKAudioPlayerStatePaused) {
        [self.audioPlayer resume];
    }
}

#pragma STKAudioPlayerDelegate

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode {
    
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState {
    [self updatePlayerState];
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didStartPlayingQueueItemId:(NSObject *)queueItemId {
    
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishPlayingQueueItemId:(NSObject *)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration {
    
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject *)queueItemId {
    
}

@end
