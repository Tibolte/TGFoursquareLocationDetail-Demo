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
        return 130.0f;
    }
    else
        return 30.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
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

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail junkViewDidLoad:(UIImageView *)junkView
{
    junkView.image = [UIImage imageNamed:@"iceland"];
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
