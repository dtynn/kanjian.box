//
//  Musician.h
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Musician : NSObject

@property (assign, nonatomic) NSInteger uid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *styles;
@property (copy, nonatomic) NSString *avatarUrl;
@property (strong, nonatomic) NSMutableArray *songs;

- (NSURLSessionDataTask *)loadSongs:(void (^)(NSError *))block;

@end
