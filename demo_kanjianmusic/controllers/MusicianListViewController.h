//
//  MusicianListViewController.h
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel;
@class PlayerBar;

@interface MusicianListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

- (id)initWithDataModel:(DataModel *)dataModel andPlayerBar:(PlayerBar *)playerBar;

@end
