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
@synthesize _pvcDataSource;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
