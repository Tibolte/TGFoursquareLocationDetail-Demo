//
//  ViewController.m
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 15/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.locationDetail = [[TGFoursquareLocationDetail alloc] initWithFrame:self.view.bounds];
    self.locationDetail.tableViewDataSource = self;
    self.locationDetail.tableViewDelegate = self;
    
    self.locationDetail.delegate = self;
    self.locationDetail.parallaxScrollFactor = 0.3; // little slower than normal.
    
    [self.view addSubview:self.locationDetail];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.view bringSubviewToFront:_headerView];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(10, 22, 44, 44);
    [buttonBack setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    
    UIButton *buttonPost = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonPost.frame = CGRectMake(self.view.bounds.size.width - 44, 18, 44, 44);
    [buttonPost setImage:[UIImage imageNamed:@"btn_post"] forState:UIControlStateNormal];
    [buttonPost addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonPost];
    
    self.locationDetail.headerView = _headerView;

}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 138.0f;
    }
    else if(indexPath.row == 1){
        return 171.0f;
    }
    else if(indexPath.row == 2){
        return 138.0f;
    }
    else
        return 100.0f; //cell for comments, in reality the height has to be adjustable
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0){
        DetailLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailLocationCell"];
        
        if(cell == nil){
            cell = [DetailLocationCell detailLocationCell];
        }
        return cell;
    }
    else if(indexPath.row == 1){
        AddressLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressLocationDetail"];

        if(cell == nil){
            cell = [AddressLocationCell addressLocationDetailCell];
            _map = [[MKMapView alloc] initWithFrame:CGRectMake(219, 0, 101, 171)];
            _map.userInteractionEnabled = FALSE;
            _map.delegate = self;
            MKCoordinateRegion myRegion;
            
            myRegion.center.latitude = 64.135338;
            myRegion.center.longitude = -21.895210;
            
            // this sets the zoom level, a smaller value like 0.02
            // zooms in, a larger value like 80.0 zooms out
            myRegion.span.latitudeDelta = 0.2;
            myRegion.span.longitudeDelta = 0.2;
            
            // move the map to our location
            [_map setRegion:myRegion animated:YES];
            
            //annotation
            TGAnnotation *annot = [[TGAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(64.135338, -21.895210)];
            [_map addAnnotation:annot];
            
            [cell.contentView addSubview:_map];
        }

        return cell;
    }
    else if(indexPath.row == 2){
        UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
        
        if(cell == nil){
            cell = [UserCell userCell];
        }
        return cell;
    }
    else if(indexPath.row == 3){
        TipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipCell"];
        
        if(cell == nil){
            cell = [TipCell tipCell];
            cell.titleLbl.text = @"Eymundsson says:";
            cell.contentLbl.text = @"The city of Reykjavik, Iceland, has been designated as UNESCO City of Literature. How great is that!";
        }
        return cell;
    }
    else if(indexPath.row == 4){
        TipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipCell"];
        
        if(cell == nil){
            cell = [TipCell tipCell];
            cell.titleLbl.text = @"Brian B. says:";
            cell.contentLbl.text = @"Awesome City and Country, great people...";
        }
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusable"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reusable"];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - LocationDetailViewDelegate

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail imagePagerDidLoad:(KIImagePager *)imagePager
{
    imagePager.dataSource = self;
    imagePager.delegate = self;
    imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    imagePager.slideshowTimeInterval = 0.0f;
    imagePager.slideshowShouldCallScrollToDelegate = YES;
    
    self.locationDetail.nbImages = [self.locationDetail.imagePager.dataSource.arrayWithImages count];
    self.locationDetail.currentImage = 0;
}

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail tableViewDidLoad:(UITableView *)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail headerViewDidLoad:(UIView *)headerView
{
    [headerView setAlpha:0.0];
    [headerView setHidden:YES];
}

#pragma mark - MKMap View methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if (annotation == mapView.userLocation)
        return nil;
    
    static NSString *MyPinAnnotationIdentifier = @"Pin";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *) [self.map dequeueReusableAnnotationViewWithIdentifier:MyPinAnnotationIdentifier];
    if (!pinView){
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:MyPinAnnotationIdentifier];
        
        annotationView.image = [UIImage imageNamed:@"pin_map_blue"];
        
        return annotationView;
        
    }else{
        
        pinView.image = [UIImage imageNamed:@"pin_map_blue"];
        
        return pinView;
    }
    
    return nil;
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages
{
    return @[
             @"https://irs2.4sqi.net/img/general/500x500/2514_BvEN_Q6lG50xZQ9TIG0XY8eYXzF3USSMdtTmxHCmqnE.jpg",
             @"https://irs3.4sqi.net/img/general/500x500/6555164_Rkk21OJj4X54X8bkutzxbeCwLHTA8Hrre6_wUVc1DMg.jpg",
             @"https://irs2.4sqi.net/img/general/500x500/3648632_NVZOdXiRTkVtzHoGNh5c5SqsF2NxYDB_FMfXRCbYu6I.jpg",
             @"https://irs1.4sqi.net/img/general/500x500/23351702_KoUKj6hZLOTHIsawxi2L64O5CpJwCadeIv2daMBDE8Q.jpg"
             ];
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFill;
}

- (NSString *) captionForImageAtIndex:(NSUInteger)index
{
    return @[
             @"First screenshot",
             @"Another screenshot",
             @"Last one! ;-)"
             ][index];
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

#pragma mark - Button actions

- (void)back
{
    NSLog(@"Here you should go back to previous view controller");
}

- (void)post
{
    NSLog(@"Post action");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
