//
//  googleMapViewController.h
//  Waterfal
//
//  Created by MAC on 14/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
@import GooglePlaces;
@import CoreLocation;
NS_ASSUME_NONNULL_BEGIN

@interface googleMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet GMSMapView *googleMap;

@end

NS_ASSUME_NONNULL_END
