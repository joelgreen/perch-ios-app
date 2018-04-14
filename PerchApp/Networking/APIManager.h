//
//  APIManager.h
//  PerchApp
//
//  Created by Joel Green on 4/13/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerReqeustManager.h"

@interface APIManager : NSObject

@property (strong, nonatomic) ServerReqeustManager *requestManager;

+ (id)sharedInstance;

@end
