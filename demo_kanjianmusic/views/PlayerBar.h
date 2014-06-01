//
//  PlayerBar.h
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayerBarDelegate <NSObject>

- (void)sliderChanged;
- (void)toggled;

@end

@interface PlayerBar : UIView

@property (strong, nonatomic) UIButton *toggleArea;
@property (strong, nonatomic) UILabel *songTitleLabel;
@property (strong, nonatomic) UILabel *songStateLabel;
//@property (strong, nonatomic) UISlider *slider;
@property (strong, nonatomic) id<PlayerBarDelegate> delegate;

@end
