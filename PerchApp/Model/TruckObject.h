//
//  TruckObject.h
//  PerchApp
//
//  Created by Joel Green on 4/13/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface TruckObject : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *remaining;

+ (TruckObject *)objectFromJson:(NSDictionary *)json;

- (CLLocationCoordinate2D)currentLocation;

@end
