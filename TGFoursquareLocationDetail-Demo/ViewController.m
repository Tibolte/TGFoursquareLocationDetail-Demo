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
    self.locationDetail.defaultJunkViewHeight = 220.0; // larger than normal
    self.locationDetail.parallaxScrollFactor = 0.3; // little slower than normal.
    
    [self.view addSubview:self.locationDetail];
    
    //self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:79/255.0 green:195/255.0 blue:212/255.0 alpha:1.0]];

}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusable"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reusable"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    
    return cell;
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

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail junkViewDidLoad:(UIImageView *)junkView
{
    junkView.image = [UIImage imageNamed:@"iceland"];
}

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail tableViewDidLoad:(UITableView *)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
