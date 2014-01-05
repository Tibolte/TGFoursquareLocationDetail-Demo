//
//  TGFoursquareLocationDetail.h
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 15/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TGFoursquareLocationDetailDelegate;

@interface TGFoursquareLocationDetail : UIView <UIScrollViewDelegate>

@property (nonatomic) CGFloat defaultJunkViewHeight;

/**
 How fast is the table view scrolling with the image picker
*/
@property (nonatomic) CGFloat parallaxScrollFactor;

@property (nonatomic) CGFloat headerFade;

@property (nonatomic, strong) UIImageView *junkView;

@property (nonatomic) CGRect defaultJunkViewFrame;

@property (nonatomic, strong) UIScrollView *imagesScrollView;

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
       imagesScrollViewDidLoad:(UIScrollView *)imagesScrollView;

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail
        junkViewDidLoad:(UIImageView *)junkView;

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail
      tableViewDidLoad:(UITableView *)tableView;

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail
      headerViewDidLoad:(UIView *)headerView;
@end
