//
//  APIManager.m
//  PerchApp
//
//  Created by Joel Green on 4/13/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager


+ (id)sharedInstance
{
    static APIManager *cpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cpManager = [[self alloc] init];
    });
    return cpManager;
}

#pragma mark - Lazy Initalization

- (ServerReqeustManager *)serverRequestHandler
{
    if (!_requestManager) {
        _requestManager = [[ServerReqeustManager alloc] init];
    }
    return _requestManager;
}

@end
