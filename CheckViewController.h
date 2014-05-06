//
//  CheckViewController.h
//  Throat Doctor
//
//  Created by 연희 김 on 2014. 4. 10..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoPageViewController.h"
#import "PhotoViewController.h"
#import "LocalImageManager.h"

#pragma mark -
#pragma mark PhotoViewController DataSource (Up)
@interface PVCDataSourceUp :NSObject <PhotoViewControllerDataSource>
{

}
@end

#pragma mark -
#pragma mark PhotoViewController DataSource (Down)
@interface PVCDataSourceDown :NSObject <PhotoViewControllerDataSource>
{
    NSMutableArray *_imageArray;
}
@end

@interface CheckViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    UIScrollView* _scrollViewUp;
    UIScrollView* _scrollViewDown;
    
    PhotoPageViewController* _photoPageViewControllerUp;
    PhotoPageViewController* _photoPageViewControllerDown;
    
    PVCDataSourceUp* _pvcDataSourceUp;
    PVCDataSourceDown* _pvcDataSourceDown;
    
    IBOutlet UITabBar* _tabBar;
}

@end


