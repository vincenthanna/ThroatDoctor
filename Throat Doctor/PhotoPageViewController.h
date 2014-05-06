//
//  PhotoPageViewController.h
//  scrollViewTest
//
//  Created by 연희 김 on 2014. 4. 21..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewController.h"

@interface PhotoPageViewController : UIPageViewController
{
    id _pvcDataSource;
}

@property (nonatomic)id _pvcDataSource;

@end
