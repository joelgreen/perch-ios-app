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

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSMutableArray *truckPins;
@property (strong, nonatomic) NSArray *truckObjects;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTruckObjects];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];

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
    annotation.subtitle = truck.title;
    
    [self.truckPins addObject:annotation];
    [self.mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)truckAdvertClicked:(MKAnnotationView *)annotationView
{
    
}

#pragma mark - Map View Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKAnnotationView *pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"truck"];

    pin.image = [UIImage imageNamed:@"truck-icon"];
    
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"Tapped callout accessory %@", view);
}


#pragma mark - Lazy Instantiation

- (NSMutableArray *)truckPins
{
    if (!_truckPins) {
        _truckPins = [[NSMutableArray alloc] init];
    }
    return _truckPins;
}


@end
