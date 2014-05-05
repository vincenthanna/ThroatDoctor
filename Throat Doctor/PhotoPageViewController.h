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
    NSMutableArray* _imageArray;
}

-(NSMutableArray*)imageArray;

#pragma mark -
#pragma mark image add/remove/clear functions

-(void)addImage:(UIImage*)image;
-(void)addImages:(NSMutableArray*)images;
-(void)resetImages:(NSMutableArray*)images;
-(void)clearImages;

@end
