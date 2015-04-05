//
//  GitHubEvent.h
//  TruedevelTestTask
//
//  Created by Alexey Huralnyk on 4/5/15.
//  Copyright (c) 2015 Alexey Huralnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubEvent : NSObject

@property (nonatomic, readonly, strong) NSString *actorLogin;
@property (nonatomic, readonly, strong) NSURL *avatarURL;
@property (nonatomic, readonly, strong) NSString *type;
@property (nonatomic, readonly, strong) NSString *dateCreated;
@property (nonatomic, readonly, strong) NSString *repoName;
@property (nonatomic, readonly, strong) NSURL *repoURL;

- (instancetype)initWithDictionary:(NSDictionary *)eventDictionary; // designated initializer

@end
