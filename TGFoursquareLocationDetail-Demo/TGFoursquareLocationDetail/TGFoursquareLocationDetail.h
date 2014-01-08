//
//  TGFoursquareLocationDetail.h
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 15/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIImagePager.h"

@protocol TGFoursquareLocationDetailDelegate;

@interface TGFoursquareLocationDetail : UIView <UIScrollViewDelegate>

@property (nonatomic) CGFloat defaultimagePagerHeight;

/**
 How fast is the table view scrolling with the image picker
*/
@property (nonatomic) CGFloat parallaxScrollFactor;

@property (nonatomic) CGFloat headerFade;

@property (nonatomic, strong) KIImagePager *imagePager;

@property (nonatomic) int nbImages;

@property (nonatomic) int currentImage;

@property (nonatomic) CGRect defaultimagePagerFrame;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIColor *backgroundViewColor;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, weak) id<UITableViewDataSource> tableViewDataSource;

@property (nonatomic, weak) id<UITableViewDelegate> tableViewDelegate;

@property (nonatomic, weak) id<TGFoursquareLocationDetailDelegate> delegate;

@end

@protocol TGFoursquareLocationDetailDelegate <NSObject>

@optional

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail
       imagePagerDidLoad:(KIImagePager *)imagePager;

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail
      tableViewDidLoad:(UITableView *)tableView;

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail
      headerViewDidLoad:(UIView *)headerView;
@end
