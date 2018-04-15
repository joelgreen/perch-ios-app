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
#import "PerchApp-Swift.h"
#import "UIImage+UIImage_Extensions.h"
#import "TruckObject.h"
#import "RequestParser.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate, FSPagerViewDelegate, FSPagerViewDataSource>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSMutableArray *truckPins;
@property (strong, nonatomic) NSArray *truckObjects;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIView *truckPagesContainer;
@property (weak, nonatomic) FSPagerView *pagerView;

@end

@implementation ViewController

#define ARC4RANDOM_MAX 0x100000000

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTruckObjects];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];

    
    FSPagerView *pagerView = [[FSPagerView alloc] initWithFrame:CGRectMake(0, 0, self.truckPagesContainer.frame.size.width, self.truckPagesContainer.frame.size.height)];
    pagerView.dataSource = self;
    pagerView.delegate = self;
    
    [pagerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.truckPagesContainer addSubview:pagerView];
    self.pagerView = pagerView;
    
    pagerView.transformer = [[FSPagerViewTransformer alloc] initWithType:FSPagerViewTransformerTypeLinear];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.2 * 0.535, 1.2);
    self.pagerView.itemSize = CGSizeApplyAffineTransform(self.pagerView.frame.size, transform);

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)loadTruckObjects
{
    [[[APIManager sharedInstance] requestManager] getTruckSchedule:^(NSData *data) {
        self.truckObjects = [RequestParser getTruckObjectsFromResponseData:data];
        [self updateMapWithTruckObejcts];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pagerView reloadData];
        });
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



#pragma mark - FSPagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(FSPagerView *)pagerView
{
    return self.truckObjects.count;
}

- (FSPagerViewCell *)pagerView:(FSPagerView *)pagerView cellForItemAtIndex:(NSInteger)index
{
    FSPagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell" atIndex:index];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.clipsToBounds = YES;
    return cell;
}

#pragma mark - FSPagerView Delegate

- (void)pagerView:(FSPagerView *)pagerView didSelectItemAtIndex:(NSInteger)index
{
    [pagerView deselectItemAtIndex:index animated:YES];
    [pagerView scrollToItemAtIndex:index animated:YES];
    //    self.pageControl.currentPage = index;
}

- (void)pagerViewDidScroll:(FSPagerView *)pagerView
{
    MKMapCamera *camera = [[MKMapCamera alloc] init];
    camera.centerCoordinate = [[self.truckObjects objectAtIndex:pagerView.currentIndex] currentLocation];
    camera.altitude = 15000;
    [self.mapView setCamera:camera animated:YES];
}

#pragma mark - Map View Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKAnnotationView *pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"truck"];

    
    pin.image = [UIImage imageNamed:@"truck-icon"];
    
    double degrees = ((double)arc4random() / ARC4RANDOM_MAX) * (360 - 0) + 0;
    
    pin.image = [pin.image imageRotatedByDegrees:degrees];
    
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
