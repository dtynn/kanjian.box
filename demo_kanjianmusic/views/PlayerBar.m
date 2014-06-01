//
//  PlayerBar.m
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "PlayerBar.h"
#import "ViewUtils.h"

@implementation PlayerBar

- (id)init {
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGRect frame = CGRectMake(0, size.height-44, size.width, 44);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ViewUtils colorWithHex:@"#3CB3E0"];
        
        UIButton *toggleArea = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, 44)];
        self.toggleArea = toggleArea;
        [self.toggleArea addTarget:self.delegate action:@selector(toggled) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:toggleArea];
        
        CGRect songTitleLabelFrame = CGRectMake(10, 0, 300, 24);
        UILabel *songTitleLabel =[[UILabel alloc] initWithFrame:songTitleLabelFrame];
        songTitleLabel.text = @"-";
        songTitleLabel.font = [UIFont systemFontOfSize:16];
        songTitleLabel.textColor = [UIColor whiteColor];
        songTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.songTitleLabel = songTitleLabel;
        [self.toggleArea addSubview:self.songTitleLabel];
        
        CGRect songStateLabelFrame = CGRectMake(10, 24, 300, 20);
        UILabel *songStateLabel = [[UILabel alloc] initWithFrame:songStateLabelFrame];
        songStateLabel.text = @"-/-";
        songStateLabel.font = [UIFont systemFontOfSize:12.0];
        songStateLabel.textColor = [UIColor whiteColor];
        songStateLabel.textAlignment = NSTextAlignmentCenter;
        self.songStateLabel = songStateLabel;
        [self.toggleArea addSubview:self.songStateLabel];
        
//        CGRect sliderFrame = CGRectMake(170, 5, 140, 34);
//        UISlider *slider = [[UISlider alloc] initWithFrame:sliderFrame];
//        slider.minimumValue = 0;
//        slider.maximumValue = 0;
//        
//        self.slider = slider;
//        [self.slider addTarget:self.delegate action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
//        [self addSubview:slider];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
