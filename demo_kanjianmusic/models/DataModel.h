//
//  DataModel.h
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Musician;
@class Song;

@interface DataModel : NSObject

@property (strong, nonatomic) NSMutableArray *musicians;
@property (strong, nonatomic) Musician *chosenMusician;
@property (strong, nonatomic) Song *chosenSong;

- (NSURLSessionDataTask *)loadMusicians:(void (^)(NSError *))block;

@end
