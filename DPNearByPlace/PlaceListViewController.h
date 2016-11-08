//
//  PlaceListViewController.h
//  DPNearByPlace
//
//  Created by Student P_08 on 04/11/16.
//  Copyright © 2016 Divya Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PlaceListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,NSXMLParserDelegate>
{
    CLLocationManager *locationManager;
    NSString *curretLatitude;
    NSString *currentLongitude;
    
    NSMutableArray *placeList;
    NSMutableDictionary *placeDictionary;
    NSMutableDictionary *latlongDictionary;
    
    NSXMLParser *parser;
    
    NSString *dataString;
}

@property NSString *selectedPlaceType;

@property (strong, nonatomic) IBOutlet UITableView *placeListTableview;
@end
