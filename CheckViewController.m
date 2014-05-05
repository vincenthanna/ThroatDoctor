//
//  CheckViewController.m
//  Throat Doctor
//
//  Created by 연희 김 on 2014. 4. 10..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//


#import "CheckViewController.h"

@implementation CheckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navigation bar의 반투명효과를 off
    self.navigationController.navigationBar.translucent = NO;
    
    CGRect svUpRect;
    CGRect svDownRect;
    
    // available view size = view.size - statusBar
    CGRect rectViewTotal = self.view.frame;
    rectViewTotal.size.height -= _tabBar.frame.size.height; // tabBar 사이즈 제외

    svUpRect = rectViewTotal;
    svDownRect = rectViewTotal;
    
    svUpRect.size.height /= 2;
    svDownRect.size.height = svUpRect.size.height;
    svDownRect.origin.y += svDownRect.size.height;
    
    /*
    // 시작위치가 어디인가를 확인해보자
    {
        UILabel* testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,320,240)];
        [testLabel setText:[NSString stringWithFormat:@"Label(%.01f %.01f)", testLabel.frame.origin.x, testLabel.frame.origin.y]];
        [testLabel setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:testLabel];
    }
    
    {
        UILabel* testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,240,320,240)];
        [testLabel setText:[NSString stringWithFormat:@"Label(%.01f %.01f)", testLabel.frame.origin.x, testLabel.frame.origin.y]];
        [testLabel setBackgroundColor:[UIColor blueColor]];
        [self.view addSubview:testLabel];
    }
     */

    
    NSLog(@"up=%@ down=%@", NSStringFromCGRect(svUpRect), NSStringFromCGRect(svDownRect));
    
    
    _upImageViewArray = [NSMutableArray arrayWithObjects:
                       [UIImage imageNamed:@"1.jpg"],
                       [UIImage imageNamed:@"2.jpg"],
                       [UIImage imageNamed:@"3.jpg"],
                       [UIImage imageNamed:@"4.jpg"],
                       [UIImage imageNamed:@"5.jpg"],
                       nil];
    
    _downImageViewArray = [NSMutableArray arrayWithObjects:
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         nil];
    
    _photoPageViewControllerUp = [self makePPVC:svUpRect initialImages:_upImageViewArray];
    _photoPageViewControllerDown = [self makePPVC:svDownRect initialImages:_downImageViewArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PhotoPageViewController*)makePPVC:(CGRect)viewSize initialImages:(NSMutableArray*)initialImages
{
    PhotoPageViewController* ppvc;
    ppvc = [[PhotoPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                            options:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:50.0f] forKey:UIPageViewControllerOptionInterPageSpacingKey]];
    
    [self addChildViewController:ppvc];
    [self.view addSubview:ppvc.view];
    
    ppvc.dataSource = self;
    ppvc.delegate = self;
    [ppvc addImages:initialImages];
    
    PhotoViewController *pvc = [[PhotoViewController alloc] initWithImages:[ppvc imageArray]
                                                                imageCount:[ppvc imageArray].count
                                                                imageIndex:0
                                                                     frame:viewSize];
    if (pvc != nil) {
        // assign the first page to the pageViewController (our rootViewController)
        [ppvc setViewControllers:@[pvc]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:NULL];
        [ppvc didMoveToParentViewController:self];
        [ppvc.view setFrame:viewSize];
    }
    

    
    return ppvc;
}

#pragma mark -
#pragma mark UIPageViewControllerDataSource delegates

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(PhotoViewController *)vc
{
    PhotoPageViewController* ppvc = (PhotoPageViewController*)pvc;
    PhotoViewController *photoVC = (PhotoViewController*)vc;
    return [photoVC photoViewControllerForImageIndex:photoVC._imageIndex-1
                                          imageCount:[ppvc imageArray].count
                                          imageArray:[ppvc imageArray]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(PhotoViewController *)vc
{
    PhotoPageViewController* ppvc = (PhotoPageViewController*)pvc;
    PhotoViewController *photoVC = (PhotoViewController*)vc;
    return [photoVC photoViewControllerForImageIndex:photoVC._imageIndex+1
                                          imageCount:[ppvc imageArray].count
                                          imageArray:[ppvc imageArray]];
}


@end
