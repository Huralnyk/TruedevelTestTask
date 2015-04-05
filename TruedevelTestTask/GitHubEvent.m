//
//  GitHubEvent.m
//  TruedevelTestTask
//
//  Created by Alexey Huralnyk on 4/5/15.
//  Copyright (c) 2015 Alexey Huralnyk. All rights reserved.
//

#import "GitHubEvent.h"
#import "GitHubEventFetcher.h"

@interface GitHubEvent ()

@property (nonatomic, readwrite, strong) NSString *actorLogin;
@property (nonatomic, readwrite, strong) NSURL *avatarURL;
@property (nonatomic, readwrite, strong) NSString *type;
@property (nonatomic, readwrite, strong) NSString *dateCreated;
@property (nonatomic, readwrite, strong) NSString *repoName;
@property (nonatomic, readwrite, strong) NSURL *repoURL;

@end

@implementation GitHubEvent

- (instancetype)initWithDictionary:(NSDictionary *)eventDictionary // designated initializer
{
    self = [super init];
    
    if(self) {
        
        if(!eventDictionary) return nil;
        
        self.actorLogin = [eventDictionary valueForKeyPath:ACTOR_LOGIN];
        self.avatarURL = [NSURL URLWithString:[eventDictionary valueForKeyPath:AVATAR_URL]];
        self.type = [eventDictionary valueForKeyPath:EVENT_TYPE];
        self.dateCreated = [eventDictionary valueForKeyPath:DATE_CREATED];
        self.repoName = [eventDictionary valueForKeyPath:REPO_NAME];
        self.repoURL = [NSURL URLWithString:[eventDictionary valueForKeyPath:REPO_URL]];
        
    }
    
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Initialization failed" reason:@"Use designated initializer - [GitHubEvent initWithDictionary:]" userInfo:nil];
    return nil;
}

@end
