//
//  DataModel.m
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "DataModel.h"
#import "Musician.h"
#import "Song.h"
#import "APIClient.h"

@implementation DataModel

- (NSURLSessionDataTask *)loadMusicians:(void (^)(NSError *))block {
    NSString *api = @"/kanjian/musicians.json";
    return [[APIClient sharedClientForMusicianList] GET:api parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        NSArray *musiciansFromResponce = [JSON valueForKeyPath:@"musicians"];
        NSMutableArray *mutableMusicians = [NSMutableArray arrayWithCapacity:[musiciansFromResponce count]];
        for (NSDictionary *attrs in musiciansFromResponce) {
            Musician *musician = [[Musician alloc] init];
            musician.uid = [[attrs valueForKey:@"uid"] integerValue];
            musician.name = [attrs valueForKey:@"name"];
            musician.styles = [attrs valueForKey:@"styles"];
            musician.avatarUrl = [attrs valueForKey:@"avatarUrl"];
            [mutableMusicians addObject:musician];
        }
        self.musicians = mutableMusicians;
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
