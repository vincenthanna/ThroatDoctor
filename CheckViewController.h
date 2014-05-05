//
//  CheckViewController.h
//  Throat Doctor
//
//  Created by 연희 김 on 2014. 4. 10..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoPageViewController.h"
@interface CheckViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    UIScrollView* _scrollViewUp;
    UIScrollView* _scrollViewDown;
//    NSMutableArray* _upImageViewArray;
    NSMutableArray* _downImageViewArray;
    
    PhotoPageViewController* _photoPageViewControllerUp;
    PhotoPageViewController* _photoPageViewControllerDown;
    
    IBOutlet UITabBar* _tabBar;
}

@end
