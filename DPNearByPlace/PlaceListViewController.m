//
//  PlaceListViewController.m
//  DPNearByPlace
//
//  Created by Student P_08 on 04/11/16.
//  Copyright © 2016 Divya Patil. All rights reserved.
//

#import "PlaceListViewController.h"
#import "CustomTableViewCell.h"
#import "ViewController.h"
#import "PlaceDetailViewController.h"

@implementation PlaceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // [self startLocating];
    
    
    placeList = [[NSMutableArray alloc]init];
    
    
    if ([self.selectedPlaceType isEqualToString:@"atm"]) {
        
        self.title = self.selectedPlaceType.uppercaseString;
    }
    else{
        NSString *place = self.selectedPlaceType.capitalizedString;
        
        NSString* placeType = [place stringByReplacingOccurrencesOfString:@"_" withString:@" "];
        
        
        self.title =placeType;
    }
    

    [self getPlaceListWithAPIKey:kGooglePlaceAPIKey placeType:self.selectedPlaceType radius:1000 lattitude:curretLatitude.floatValue longitude:currentLongitude.floatValue];

    
    
 //   [self setUp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//-(void)setUp {
    
 //   self.listIndicator.hidesWhenStopped = YES;
    
//}

-(void)startLocating {
    
    locationManager = [[CLLocationManager alloc]init];
    
    locationManager.delegate = self;
    
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    
    
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = [locations lastObject];
    
    curretLatitude= [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    
    currentLongitude= [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    
    
    if (currentLocation != nil) {
        [locationManager stopUpdatingLocation];
        
    }
    
    
    [self getPlaceListWithAPIKey:kGooglePlaceAPIKey placeType:self.selectedPlaceType radius:1000 lattitude:curretLatitude.floatValue longitude:currentLongitude.floatValue];
    
}


-(void)getPlaceListWithAPIKey:(NSString *)key
                    placeType:(NSString *)type
                       radius:(int)radius
                    lattitude:(double)latitude
                    longitude:(double)longitude
{
    
   // [self.listIndicator startAnimating];
    
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/xml?&key=%@&location=%f,%f&radius=%d&types=%@",key,latitude,longitude,radius,type];
    
    
    NSLog(@"%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [mySession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            //alert
        }
        else {
            
            if (response) {
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                
                if (httpResponse.statusCode == 200) {
                    
                    if (data) {
                        
                        //xml parsing
                        
                        parser = [[NSXMLParser alloc]initWithData:data];
                        parser.delegate = self;
                        [parser parse];
                        
                    }
                    else {
                        //alert
                        
                      //  [self.listIndicator stopAnimating];
                        
                    }
                }
                else {
                    //alert
                  //  [self.listIndicator stopAnimating];
                    
                }
                
            }
            else {
                //alert
                
               // [self.listIndicator stopAnimating];
                
            }
        }
        
        
    }];
    
    
    [task resume];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return placeList.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomList_Cell"];
    
    
    
    //[self.listIndicator stopAnimating];
    
    NSMutableDictionary *tempDictionary = [placeList objectAtIndex:indexPath.row];
    
    NSLog(@"%@",tempDictionary);
    
    NSString *placeName = [tempDictionary valueForKey:@"name"];
    NSString *address = [tempDictionary valueForKey:@"vicinity"];
    NSString *placeID = [tempDictionary valueForKey:@"place_id"];
    
    
    
    cell.labelName.text = placeName;
    
    cell.labelName.textColor = [UIColor blueColor];
    
    cell.labelName.font = [UIFont boldSystemFontOfSize:16];
    
    
    cell.labelAddress.text = address;
    
    cell.labelAddress.textColor = [UIColor darkGrayColor];
    
    cell.labelAddress.font = [UIFont systemFontOfSize:15];
    
    
    cell.labelPlaceID.text = placeID;
    
    //  cell.placeIdLabel.textColor = [UIColor blackColor];
    
    
    cell.backgroundColor = [UIColor lightTextColor];
    
    
    return cell;
    
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    
    if ([elementName isEqualToString:@"result"]) {
        placeDictionary = [[NSMutableDictionary alloc]init];
    }
    else if ([elementName isEqualToString:@"name"]) {
        dataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"vicinity"]) {
        dataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"place_id"]) {
        dataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"lat"]) {
        dataString = [[NSMutableString alloc]init];
    }
    
    else if ([elementName isEqualToString:@"lng"]) {
        dataString = [[NSMutableString alloc]init];
    }
    
    else if ([elementName isEqualToString:@"photo_reference"]) {
        dataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"width"]) {
        dataString = [[NSMutableString alloc]init];
    }
    
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    dataString = string;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"result"]) {
        
        [placeList addObject:placeDictionary];
        
    }
    else if ([elementName isEqualToString:@"name"]) {
        
        [placeDictionary setValue:dataString forKey:@"name"];
        
    }
    else if ([elementName isEqualToString:@"vicinity"]) {
        
        [placeDictionary setValue:dataString forKey:@"vicinity"];
        
    }
    else if ([elementName isEqualToString:@"place_id"]) {
        
        [placeDictionary setValue:dataString forKey:@"place_id"];
        
    }
    else if ([elementName isEqualToString:@"lat"]) {
        
        [placeDictionary setValue:dataString forKey:@"lat"];
        
    }
    else if ([elementName isEqualToString:@"lng"]) {
        
        [placeDictionary setValue:dataString forKey:@"lng"];
        
    }
    else if ([elementName isEqualToString:@"photo_reference"]) {
        
        [placeDictionary setValue:dataString forKey:@"photo_reference"];
        
    }
    
    else if ([elementName isEqualToString:@"width"]) {
        
        [placeDictionary setValue:dataString forKey:@"width"];
        
    }
    
    else if([elementName isEqualToString:@"PlaceSearchResponse"]){
        
        
        [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
        
    }
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"PARSE ERROR : %@",parseError.localizedDescription);
}

-(void)updateTableView {
    
    [self.placeListTableview reloadData];
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlaceListViewController *placeDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceDetailsViewController"];
    
    NSDictionary *placeDic = [placeList objectAtIndex:indexPath.row];
    
    NSString *place_id = [placeDic valueForKey:@"place_id"];
    
    NSString *latitude = [placeDic valueForKey:@"lat"];
    NSString *longitude = [placeDic valueForKey:@"lng"];
    NSString *photoReference = [placeDic valueForKey:@"photo_reference"];
  NSString *width = [placeDic valueForKey:@"width"];
    

  //  PlaceDetailViewController.selectedPlaceID = place_id;
//    PlaceDetailViewController.selectedPlaceLat = latitude;
//    PlaceDetailViewController.selectedPlaceLng = longitude;
//    PlaceDetailViewController.selectedPhotoReference = photoReference;
//    PlaceDetailViewController.selectedPhotoWidth = width;
        
    
    
    [self.navigationController pushViewController:placeDetailViewController animated:YES];
    
}


@end
