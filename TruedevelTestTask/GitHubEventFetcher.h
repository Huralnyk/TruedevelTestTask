//
//  GitHubEventFetcher.h
//  TruedevelTestTask
//
//  Created by Alexey Huralnyk on 4/5/15.
//  Copyright (c) 2015 Alexey Huralnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

// keys (paths) to values in a event dictionary

#define ACTOR_LOGIN @"actor.login"
#define AVATAR_URL @"actor.avatar_url"
#define EVENT_TYPE @"type"
#define DATE_CREATED @"created_at"
#define REPO_NAME @"repo.name"
#define REPO_URL @"repo.url"

// key to repo page url in a repo dictionary

#define REPO_PAGE_URL @"html_url"

// url to event api

#define URL_EVENTS_API @"https://api.github.com/events"

@interface GitHubEventFetcher : NSObject

+ (void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void(^)(NSData *))completionHandler;

+ (NSURL *)URLforEventsAPI;

@end
