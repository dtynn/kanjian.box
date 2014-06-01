//
//  Musician.m
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "Musician.h"
#import "APIClient.h"
#import "Song.h"

@implementation Musician

- (NSURLSessionDataTask *)loadSongs:(void (^)(NSError *))block {
    NSString *api = [NSString stringWithFormat:@"/api/wanglin/fm/%d", self.uid];
    return [[APIClient sharedClient] GET:api parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        NSArray *songsFromResponce = [JSON valueForKeyPath:@"songs"];
        NSMutableArray *mutableSongs = [NSMutableArray arrayWithCapacity:[songsFromResponce count]];
        for (NSDictionary *attrs in songsFromResponce) {
            Song *song = [[Song alloc] init];
            song.title = [attrs valueForKey:@"title"];
            song.mp3Url = [attrs valueForKey:@"url"];
            [mutableSongs addObject:song];
        }
        self.songs = mutableSongs;
        if (block) {
            block(nil);
        }
    } failure:^(NSURLSessionDataTask * __unused task, NSError *error){
        if (block) {
            block(error);
        }
    }];
}

@end
