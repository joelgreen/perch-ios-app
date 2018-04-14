//
//  ServerReqeustManager.h
//  PerchApp
//
//  Created by Joel Green on 4/13/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerReqeustManager : NSObject

typedef void (^apiRequestComplete)(NSData *);

@property (nonatomic, strong) NSURLSession *session;

- (void)getTruckSchedule:(apiRequestComplete)completionBlock;

@end
