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
    _defaultJunkViewHeight          = 130.0f;
    _parallaxScrollFactor           = 0.6f;
    _headerFade = 130.0f;
    self.autoresizesSubviews        = YES;
    self.autoresizingMask           = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    self.backgroundViewColor = [UIColor clearColor];
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
        CGRect tableHeaderViewFrame = CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.defaultJunkViewHeight);
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:tableHeaderViewFrame];
        tableHeaderView.backgroundColor = [UIColor clearColor];
        self.tableView.tableHeaderView = tableHeaderView;
    }
    
    if(!self.junkView){
        self.defaultJunkViewFrame = CGRectMake(0.0f, -self.defaultJunkViewHeight * self.parallaxScrollFactor * 2, self.tableView.frame.size.width, self.defaultJunkViewHeight + (self.defaultJunkViewHeight * self.parallaxScrollFactor * 4));
        _junkView = [[UIImageView alloc] initWithFrame:self.defaultJunkViewFrame];
        self.junkView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self insertSubview:self.junkView belowSubview:self.tableView];
        
        if([self.delegate respondsToSelector:@selector(locationDetail:junkViewDidLoad:)]){
            [self.delegate locationDetail:self junkViewDidLoad:self.junkView];
        }

    }
    
    // Add the background tableView
    if (!self.backgroundView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.defaultJunkViewHeight,
                                                                self.tableView.frame.size.width,
                                                                self.tableView.frame.size.height - self.defaultJunkViewHeight)];
        view.backgroundColor = self.backgroundViewColor;
        self.backgroundView = view;
		self.backgroundView.userInteractionEnabled=NO;
        [self.tableView insertSubview:self.backgroundView atIndex:0];
    }

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

- (void)setJunkView:(UIImageView *)junkView
{
    _junkView = junkView;
    
    if([self.delegate respondsToSelector:@selector(locationDetail:junkViewDidLoad:)]){
        [self.delegate locationDetail:self junkViewDidLoad:self.junkView];
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
        junkViewFrameYAdjustment = self.defaultJunkViewFrame.origin.y - (scrollOffset * self.parallaxScrollFactor);
    }
    
    // If the user is scrolling normally,
    else {
        junkViewFrameYAdjustment = self.defaultJunkViewFrame.origin.y - (scrollOffset * self.parallaxScrollFactor);
        
        // Don't move the map way off-screen
        if (junkViewFrameYAdjustment <= -(self.defaultJunkViewFrame.size.height)) {
            junkViewFrameYAdjustment = -(self.defaultJunkViewFrame.size.height);
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
        CGRect newJunkViewFrame = self.junkView.frame;
        newJunkViewFrame.origin.y = junkViewFrameYAdjustment;
        self.junkView.frame = newJunkViewFrame;
    }
}

@end
