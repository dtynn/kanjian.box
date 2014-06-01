//
//  PlayerController.h
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicianDetailViewController.h"
#import "STKAudioPlayer.h"
#import "PLayerBar.h"

@class STKAudioPlayer;
@class DataModel;
@class PlayerBar;

@interface PlayerController : UIViewController<MusiciaDetailViewDelegate, STKAudioPlayerDelegate, PlayerBarDelegate>

@property (strong, nonatomic) STKAudioPlayer *audioPlayer;

- (id)initWithDataModel:(DataModel *)dataModel andPlayerBar:(PlayerBar *)playerBar;

@end
