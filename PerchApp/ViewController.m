//
//  ViewController.m
//  PerchApp
//
//  Created by Joel Green on 4/13/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "APIManager.h"

#import "TruckObject.h"
#import "RequestParser.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSMutableArray *truckPins;
@property (strong, nonatomic) NSArray *truckObjects;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTruckObjects];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadTruckObjects
{
    [[[APIManager sharedInstance] requestManager] getTruckSchedule:^(NSData *data) {
        self.truckObjects = [RequestParser getTruckObjectsFromResponseData:data];
        [self updateMapWithTruckObejcts];
    }];
}

- (void)updateMapWithTruckObejcts
{
    for (TruckObject *truck in self.truckObjects) {
        [self addPinForTruck:truck];
    }
    if ([self.truckObjects count]) {
        // Zoom in near a truck
        MKMapCamera *camera = [[MKMapCamera alloc] init];
        camera.centerCoordinate = [[self.truckObjects firstObject] currentLocation];
        camera.altitude = 15000;
        [self.mapView setCamera:camera animated:YES];
    }
}

- (void)addPinForTruck:(TruckObject *)truck
{
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = [truck currentLocation];
    
    annotation.title = truck.title;
    
    [self.truckPins addObject:annotation];
    [self.mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)truckPins
{
    if (!_truckPins) {
        _truckPins = [[NSMutableArray alloc] init];
    }
    return _truckPins;
}


@end
