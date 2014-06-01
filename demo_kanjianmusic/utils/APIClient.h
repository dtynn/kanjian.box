//
//  APIClient.h
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface APIClient : AFHTTPSessionManager

+ (instancetype) sharedClient;
+ (instancetype) sharedClientForMusicianList;

@end
