//
//  TruckObject.m
//  PerchApp
//
//  Created by Joel Green on 4/13/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "TruckObject.h"

@interface TruckObject()

@property (nonatomic) CLLocationCoordinate2D currentLoc;

@end

@implementation TruckObject

+ (TruckObject *)objectFromJson:(NSDictionary *)json
{
    TruckObject *truck = [[TruckObject alloc] init];
    
    truck.title = [json objectForKey:@"title"];
    truck.address = [json objectForKey:@"address"];
    truck.remaining = [json objectForKey:@"remaining"];
    
    NSArray *stops = [json objectForKey:@"stops"];
    NSDictionary *firstStop = [stops firstObject];
    truck.currentLoc = CLLocationCoordinate2DMake([[firstStop objectForKey:@"lat"] floatValue], [[firstStop objectForKey:@"lon"] floatValue]);
    return truck;
}

- (CLLocationCoordinate2D)currentLocation
{
    return self.currentLoc;
}

@end
