//
//  TGFoursquareLocationDetail.m
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 15/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import "TGFoursquareLocationDetail.h"

@implementation TGFoursquareLocationDetail

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _defaultimagePagerHeight        = 180.0f;
    _parallaxScrollFactor           = 0.6f;
    _headerFade                     = 130.0f;
    self.autoresizesSubviews        = YES;
    self.autoresizingMask           = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    self.backgroundViewColor        = [UIColor clearColor];
}

- (void)dealloc
{
	[self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    if (!self.tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self.tableViewDelegate;
        self.tableView.dataSource = self.tableViewDataSource;
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        
        // Add scroll view KVO
        void *context = (__bridge void *)self;
        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:context];
        
        [self addSubview:self.tableView];
        
        if([self.delegate respondsToSelector:@selector(locationDetail:tableViewDidLoad:)]){
            [self.delegate locationDetail:self tableViewDidLoad:self.tableView];
        }
        
    }
    
    if (!self.tableView.tableHeaderView) {
        CGRect tableHeaderViewFrame = CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.defaultimagePagerHeight);
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:tableHeaderViewFrame];
        tableHeaderView.backgroundColor = [UIColor clearColor];
        self.tableView.tableHeaderView = tableHeaderView;
        
        UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(catchHeaderGestureRight:)];
        swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight ;
        swipeGestureRight.cancelsTouchesInView = YES;
        
        UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(catchHeaderGestureLeft:)];
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft ;
        swipeGestureLeft.cancelsTouchesInView = YES;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(catchTapEvent:)];
        
        [self.tableView.tableHeaderView  addGestureRecognizer:swipeGestureRight];
        [self.tableView.tableHeaderView  addGestureRecognizer:swipeGestureLeft];
        [self.tableView.tableHeaderView  addGestureRecognizer:tapRecognizer];
    }
    
    if(!self.imagePager){
        self.defaultimagePagerFrame = CGRectMake(0.0f, -self.defaultimagePagerHeight * self.parallaxScrollFactor *2, self.tableView.frame.size.width, self.defaultimagePagerHeight + (self.defaultimagePagerHeight * self.parallaxScrollFactor * 4));
        _imagePager = [[KIImagePager alloc] initWithFrame:self.defaultimagePagerFrame];
        self.imagePager.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        self.imagePager.indicatorDisabled = YES;
        
        [self insertSubview:self.imagePager belowSubview:self.tableView];
        
        if([self.delegate respondsToSelector:@selector(locationDetail:imagePagerDidLoad:)]){
            [self.delegate locationDetail:self imagePagerDidLoad:self.imagePager];
        }        
    }
    
    // Add the background tableView
    if (!self.backgroundView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.defaultimagePagerHeight,
                                                                self.tableView.frame.size.width,
                                                                self.tableView.frame.size.height - self.defaultimagePagerHeight)];
        view.backgroundColor = self.backgroundViewColor;
        self.backgroundView = view;
		self.backgroundView.userInteractionEnabled=NO;
        [self.tableView insertSubview:self.backgroundView atIndex:0];
    }

}

-(void)catchHeaderGestureRight:(UISwipeGestureRecognizer*)sender
{
    NSLog(@"header gesture right");
    
    if(self.currentImage > 0){
        self.currentImage --;
        [self.imagePager setCurrentPage:self.currentImage animated:YES];
        
        [self.imagePager.delegate imagePager:self.imagePager didScrollToIndex:self.currentImage];
        [self.imagePager updateCaptionLabelForImageAtIndex:self.currentImage];
    }
}

-(void)catchHeaderGestureLeft:(UISwipeGestureRecognizer*)sender
{    
    NSLog(@"header gesture Left");
    
    if(self.currentImage < [[self.imagePager.dataSource arrayWithImages] count] -1){
        self.currentImage ++;
        [self.imagePager setCurrentPage:self.currentImage animated:YES];
        
        [self.imagePager.delegate imagePager:self.imagePager didScrollToIndex:self.currentImage];
        [self.imagePager updateCaptionLabelForImageAtIndex:self.currentImage];
    }
}

-(void)catchTapEvent:(UITapGestureRecognizer*)sender
{
    NSLog(@"tap gesture");
    
    [self.imagePager.delegate imagePager:self.imagePager didSelectImageAtIndex:self.currentImage];
}

- (void)setTableViewDataSource:(id<UITableViewDataSource>)tableViewDataSource
{
    _tableViewDataSource = tableViewDataSource;
    self.tableView.dataSource = _tableViewDataSource;
    
    if (_tableViewDelegate) {
        [self.tableView reloadData];
    }
}

- (void)setTableViewDelegate:(id<UITableViewDelegate>)tableViewDelegate
{
    _tableViewDelegate = tableViewDelegate;
    self.tableView.delegate = _tableViewDelegate;
    
    if (_tableViewDataSource) {
        [self.tableView reloadData];
    }
}

- (void)setHeaderView:(UIView *)headerView
{
    _headerView = headerView;
    
    if([self.delegate respondsToSelector:@selector(locationDetail:headerViewDidLoad:)]){
        [self.delegate locationDetail:self headerViewDidLoad:self.headerView];
    }
}

#pragma mark - KVO Methods

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
	// Make sure we are observing this value.
	if (context != (__bridge void *)self) {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
		return;
	}
    
    if ((object == self.tableView) &&
        ([keyPath isEqualToString:@"contentOffset"] == YES)) {
        [self scrollViewDidScrollWithOffset:self.tableView.contentOffset.y];
        return;
    }
}

- (void)scrollViewDidScrollWithOffset:(CGFloat)scrollOffset
{
    CGFloat junkViewFrameYAdjustment = 0.0;
    
    // If the user is pulling down
    if (scrollOffset < 0) {
        junkViewFrameYAdjustment = self.defaultimagePagerFrame.origin.y - (scrollOffset * self.parallaxScrollFactor);
    }
    
    // If the user is scrolling normally,
    else {
        junkViewFrameYAdjustment = self.defaultimagePagerFrame.origin.y - (scrollOffset * self.parallaxScrollFactor);
        
        // Don't move the map way off-screen
        if (junkViewFrameYAdjustment <= -(self.defaultimagePagerFrame.size.height)) {
            junkViewFrameYAdjustment = -(self.defaultimagePagerFrame.size.height);
        }

    }
    
    //NSLog(@"scrollOffset: %f",scrollOffset);
    
    if(scrollOffset > _headerFade && _headerView.alpha == 0.0){ //make the header appear
        _headerView.alpha = 0;
        _headerView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _headerView.alpha = 1;
        }];
    }
    else if(scrollOffset < _headerFade && _headerView.alpha == 1.0){ //make the header disappear
        [UIView animateWithDuration:0.3 animations:^{
            _headerView.alpha = 0;
        } completion: ^(BOOL finished) {
            _headerView.hidden = YES;
        }];
    }
    
    if (junkViewFrameYAdjustment) {
        CGRect newJunkViewFrame = self.imagePager.frame;
        newJunkViewFrame.origin.y = junkViewFrameYAdjustment;
        self.imagePager.frame = newJunkViewFrame;
    }
}

@end
