//
//  RequestParser.h
//  PerchApp
//
//  Created by Joel Green on 4/13/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TruckObject.h"

@interface RequestParser : NSObject

+ (NSArray<TruckObject *> *)getTruckObjectsFromResponseData:(NSData *)responseData;

@end
