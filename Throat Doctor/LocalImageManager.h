//
//  LocalImageManager.h
//  Throat Doctor
//
//  Created by 연희 김 on 2014. 5. 6..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalImageManager : NSObject 
{
    NSMutableArray* _userImages;
}

// external interfaces
+(LocalImageManager*)sharedManager;
-(BOOL)saveUserImage:(UIImage*)image;
-(void)updateLocalImages;

@property (nonatomic,retain,readonly) NSMutableArray* userImages;

@end
