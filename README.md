TGFoursquareLocationDetail-Demo
===============================

Foursquare has recently released a new version of its app taking advantage of the new features of iOS 7, this iOS project recreates Foursquare design and behaviour when presenting location details.

This project is not providing all functionnalities but the main parts are available, you are of course invited to use, fork and improve this project using your own knowledge.

Behaviour
===============================

When you scroll, image's shown area will become bigger. Like it appears on location detail page in Foursquare app.
Also when you scroll up the UITableView, the header will automatically appear. At the opposite, if you scroll down it will fade away.

![](https://raw.githubusercontent.com/Tibolte/TGFoursquareLocationDetail-Demo/master/foursquaredemosvg.gif)

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
![1](http://i.imgur.com/hZ6F1E4.png)


![2](http://i.imgur.com/YPH8NIW.png)


TODO list or suggestions
===============================

Improve scrolling behaviour of the imagePager, for now it's only based on UISwipeLeftGestureRecognizer or UISwipeRightGestureRecognizer.


Credits
===============================

About the images, I was helped by kimar and his project KIImagePager: https://github.com/kimar/KIImagePager.

Use this project as it pleases you.

You can follow me on on Github or here on Linkedin: http://www.linkedin.com/pub/thibault-gu%C3%A9gan/27/399/607
