//
//  PhotoPageViewController.m
//  scrollViewTest
//
//  Created by 연희 김 on 2014. 4. 21..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//

#import "PhotoPageViewController.h"
#import "ImageScrollView.h"
#import "PhotoViewController.h"

@interface PhotoPageViewController ()

@end

@implementation PhotoPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_imageArray == nil) _imageArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark image add/remove/clear functions

-(NSMutableArray*)imageArray
{
    return _imageArray;
}

-(void)addImage:(UIImage*)image
{
    if (_imageArray == nil) _imageArray = [[NSMutableArray alloc]init];
    [_imageArray addObject:image];
}

-(void)addImages:(NSMutableArray*)images
{
    if (_imageArray == nil) _imageArray = [[NSMutableArray alloc]init];
    [_imageArray addObjectsFromArray:images];
}

-(void)resetImages:(NSMutableArray*)images
{
    if (_imageArray == nil) _imageArray = [[NSMutableArray alloc]init];
    [_imageArray removeAllObjects];
    [_imageArray addObjectsFromArray:images];
}

-(void)clearImages
{
    if (_imageArray == nil) _imageArray = [[NSMutableArray alloc]init];
    [_imageArray removeAllObjects];
}

@end
