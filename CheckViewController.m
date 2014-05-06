//
//  CheckViewController.m
//  Throat Doctor
//
//  Created by 연희 김 on 2014. 4. 10..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//


#import "CheckViewController.h"
#import "LocalImageManager.h"

#pragma mark -
#pragma mark PhotoViewController DataSource (Up)
@implementation PVCDataSourceUp
-(UIImage*)getImageByIndex:(NSInteger)index
{
    return [[LocalImageManager sharedManager]getImageByIndex:index];
}

-(BOOL)isImageExists:(NSInteger)index
{
    return [[LocalImageManager sharedManager]isImageExists:index];
}
@end

#pragma mark -
#pragma mark PhotoViewController DataSource (Down)
@implementation PVCDataSourceDown
-(UIImage*)getImageByIndex:(NSInteger)index
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray arrayWithObjects:
                               [UIImage imageNamed:@"1.jpg"],
                               [UIImage imageNamed:@"2.jpg"],
                               [UIImage imageNamed:@"3.jpg"],
                               [UIImage imageNamed:@"4.jpg"],
                               [UIImage imageNamed:@"5.jpg"],
                               nil];
    }
    return _imageArray[index];
}

-(BOOL)isImageExists:(NSInteger)index
{
    if (index < _imageArray.count && index >= 0) {
        return YES;
    }
    return NO;
}
@end

@implementation CheckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navigation bar의 반투명효과를 off
    self.navigationController.navigationBar.translucent = NO;
    
    _pvcDataSourceUp = [[PVCDataSourceUp alloc]init];
    _pvcDataSourceDown = [[PVCDataSourceDown alloc]init];
    
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
    
    NSLog(@"up=%@ down=%@", NSStringFromCGRect(svUpRect), NSStringFromCGRect(svDownRect));

    _photoPageViewControllerUp = [self makePPVC:svUpRect photoViewControllerDataSource:_pvcDataSourceUp];
    _photoPageViewControllerDown = [self makePPVC:svDownRect photoViewControllerDataSource:_pvcDataSourceDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PhotoPageViewController*)makePPVC:(CGRect)viewSize photoViewControllerDataSource:(id)photoViewControllerDataSource
{
    PhotoPageViewController* ppvc;
    ppvc = [[PhotoPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                            options:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:50.0f] forKey:UIPageViewControllerOptionInterPageSpacingKey]];
    
    [self addChildViewController:ppvc];
    [self.view addSubview:ppvc.view];
    
    ppvc.dataSource = self;
    ppvc.delegate = self;
    ppvc._pvcDataSource = photoViewControllerDataSource;

    PhotoViewController *pvc = [[PhotoViewController alloc] initWithIndex:0
                                                                    frame:viewSize
                                                               dataSource:photoViewControllerDataSource];

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
    return [photoVC photoViewControllerForImageIndex:photoVC._imageIndex-1 dataSource:ppvc._pvcDataSource];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(PhotoViewController *)vc
{
    PhotoPageViewController* ppvc = (PhotoPageViewController*)pvc;
    PhotoViewController *photoVC = (PhotoViewController*)vc;
    return [photoVC photoViewControllerForImageIndex:photoVC._imageIndex+1 dataSource:ppvc._pvcDataSource];
}


@end
