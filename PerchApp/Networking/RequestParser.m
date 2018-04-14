//
//  RequestParser.m
//  PerchApp
//
//  Created by Joel Green on 4/13/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "RequestParser.h"

@implementation RequestParser

+ (NSArray *)getTruckObjectsFromResponseData:(NSData *)responseData
{
    NSMutableArray *truckObjects = [[NSMutableArray alloc] init];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    
    NSArray *trucks = [dict objectForKey:@"trucks"];
    
    for (NSDictionary *truckJson in trucks) {
        TruckObject *truck = [TruckObject objectFromJson:truckJson];
        [truckObjects addObject:truck];
    }
    return truckObjects;
}





@end
