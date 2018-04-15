//
//  ServerReqeustManager.m
//  PerchApp
//
//  Created by Joel Green on 4/13/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "ServerReqeustManager.h"
#import "ConstantHeader.h"

@implementation ServerReqeustManager

- (id)init {
    if (self = [super init]) {
        [self configureNSURLSession];
    }
    return self;
}

- (void)configureNSURLSession
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
}

- (void)getTruckSchedule:(apiRequestComplete)completionBlock
{
    NSLog(@"requesting truck schedule");
//    NSString *urlString = @"http://flask-env.qfkjpmpp82.us-west-2.elasticbeanstalk.com/random_truck_schedule";
    NSString *urlString = @"http://flask-env.qfkjpmpp82.us-west-2.elasticbeanstalk.com/sample_truck_schedule";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10
                                    ];
    [request setHTTPMethod: @"GET"];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      if (error) {
                                          if (PERCH_DEBUG) {
                                              NSLog(@"Error occured requesting all customers with response: %@ andData: %@ error: %@, %@", response, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], error, [error userInfo]);
                                          }
                                      } else {
                                          if (PERCH_DEBUG) {
                                              NSLog(@"Success requesting requesting all customers with response: %@ andData: %@", response, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                          }
                                          completionBlock(data);
                                      }
                                  }];
    [task resume];
}

@end
