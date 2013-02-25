//
//  ViewController.m
//  ReverseGeocoing
//
//  Created by Daniela on 2/24/13.
//  Copyright (c) 2013 Pyrogusto. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ViewController

- (void) viewDidAppear:(BOOL)animated{
    self.mapView.showsUserLocation = YES;
}

- (CLGeocoder*)geocoder{
    if(!_geocoder){
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}


- (IBAction)reversegeocode:(id)sender {
    [self.geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            return;
        }
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSString *newCityString = @"";
        if([placemark locality]){
            newCityString = [NSString stringWithFormat:@"%@%@",newCityString,[placemark locality]];
        }
        if([placemark administrativeArea]){
            if(newCityString && [newCityString length]>0){
                newCityString = [NSString stringWithFormat:@"%@, %@",newCityString,[placemark administrativeArea]];
            }else{
                newCityString = [NSString stringWithFormat:@"%@%@",newCityString,[placemark administrativeArea]];
            }
        }
        // display string on UI.
        if(placemark.name){
            self.placeLabel.text = placemark.name;
            self.cityLabel.text = newCityString;
        }
     
        
    }];
}


@end
