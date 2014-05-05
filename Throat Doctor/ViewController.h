//
//  ViewController.h
//  Throat Doctor
//
//  Created by 연희 김 on 2014. 4. 9..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UITableView* _tableView;
}

@end
