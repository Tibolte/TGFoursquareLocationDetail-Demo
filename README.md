TGFoursquareLocationDetail-Demo
===============================

Foursquare has recently released a new version of its app taking advantage of the new features of iOS 7, this iOS project recreates Foursquare design and behaviour when presenting location details.

This project is not providing all functionnalities but the main parts are available, you are of course invited to use, fork and improve this project using your own knowledge.

Usage
===============================

Import the TGFoursquareLocationDetail folder into your project and set the TGFoursquareLocationDetail object in your controller:

```objective-c
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
````

Screenshots
===============================



