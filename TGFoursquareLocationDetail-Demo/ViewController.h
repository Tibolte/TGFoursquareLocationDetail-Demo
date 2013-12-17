//
//  ViewController.h
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 15/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGFoursquareLocationDetail.h"
#import "DetailLocationCell.h"

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,TGFoursquareLocationDetailDelegate>

@property (nonatomic, strong) TGFoursquareLocationDetail *locationDetail;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@end
