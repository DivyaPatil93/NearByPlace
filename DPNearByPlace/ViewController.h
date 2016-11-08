//
//  ViewController.h
//  DPNearByPlace
//
//  Created by Student P_08 on 04/11/16.
//  Copyright © 2016 Divya Patil. All rights reserved.
//

#define kGooglePlaceAPIKey @"AIzaSyCyX_dY-mPY6fbW6IIr_QD9jgakBonAtl0"
#define kLatitude
#define kLongitude

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *placeTypes;
}
@property (strong, nonatomic) IBOutlet UITableView *tableViewPlaceType;


@end

