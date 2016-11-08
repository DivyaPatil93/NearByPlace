//
//  ViewController.m
//  DPNearByPlace
//
//  Created by Student P_08 on 04/11/16.
//  Copyright © 2016 Divya Patil. All rights reserved.
//

#import "ViewController.h"
#import "PlaceListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = [NSString stringWithFormat:@"SEARCH PLACES"];
        placeTypes = @[@"airport",@"beauty_salon",@"cafe",@"furniture_store",@"gas_station",@"hospital",@"hair_care",@"jewelry_store",@"library",@"movie_theater",@"night_club",@"park",@"restaurant",@"shopping_mall",@"travel_agency",@"university",@"zoo"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return placeTypes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = [placeTypes objectAtIndex:indexPath.row];
   // cell.textLabel.textColor = [UIColor blackColor];

    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    
    //cell.backgroundColor = [UIColor lightTextColor];

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *place = [placeTypes objectAtIndex:indexPath.row];
    
    NSString* placeType = [place stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    
    PlaceListViewController *placeListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceListViewController"];
    
    
    placeListViewController.selectedPlaceType = placeType.lowercaseString;
    
    
    [self.navigationController pushViewController:placeListViewController animated:YES];
    
}

@end
