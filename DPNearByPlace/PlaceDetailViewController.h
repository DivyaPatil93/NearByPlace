//
//  PlaceDetailViewController.h
//  DPNearByPlace
//
//  Created by Student P_08 on 04/11/16.
//  Copyright © 2016 Divya Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomTableViewCell.h"

@interface PlaceDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,NSXMLParserDelegate>

{
    double detailsLatitude;
    double detailsLongitude;
    
    
    NSString *photoRef;
    double widthPhoto;
    
    
    NSXMLParser *parser;
    
    NSMutableArray *placeDetailsList;
    
    NSMutableDictionary *placeDetailsDictionary;
    
    NSString *detailDataString;
    
    
}

@property NSString *selectedPlaceID;
@property NSString *selectedPlaceLat;
@property NSString *selectedPlaceLong;
@property NSString *selectedPhotoReference;
@property NSString *selectedPhotoWidth;

@end
