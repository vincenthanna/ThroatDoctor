//
//  LocalImageManager.m
//  Throat Doctor
//
//  Created by 연희 김 on 2014. 5. 6..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//

#import "LocalImageManager.h"

@interface LocalImageManager()
{
    // private variables
}

// internal functions
+(NSString*)makeFileName:(UIImage*)image;
+(NSString*)getUserImageDirPath;

@end

@implementation LocalImageManager

-(NSMutableArray*)userImages{
    return _userImages;
}

// internal functions
+(NSString*)makeFileName:(UIImage*)image
{
    NSString* filename = [NSString stringWithFormat:@"userImage_%.0f.jpg", [NSDate timeIntervalSinceReferenceDate]];
    return filename;
}

+(NSString*)getUserImageDirPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserImages"];
}

+(LocalImageManager*)sharedManager
{
    static LocalImageManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

-(id)init
{
    self = [super init];
    _userImages = [[NSMutableArray alloc]init];
    return self;
}


// external interfaces
-(BOOL)saveUserImage:(UIImage*)image
{
    NSFileManager* manager = [NSFileManager defaultManager];
    NSData* imageData = UIImageJPEGRepresentation(image, 100.0f);
    NSString* filename = [LocalImageManager makeFileName:image];
    NSString* docDir = [LocalImageManager getUserImageDirPath];
    if ([manager fileExistsAtPath:docDir] == NO) {
        NSError* error;
        if (![manager createDirectoryAtPath:docDir withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Create directory error: %@", error);
            return NO;
        }
    }
    
    NSString* newFileNameWithPath = [NSString stringWithFormat:@"%@/%@", docDir, filename];
    if ([manager createFileAtPath:newFileNameWithPath contents:imageData attributes:nil] != YES) {
        NSLog(@"can't save image file!");
        return NO;
    }
    else {
        NSLog(@"file %@ saved.", filename);
        return YES;
    }
}

-(UIImage*)getImageByIndex:(NSInteger)index
{
    NSError* error;
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString* docDir = [LocalImageManager getUserImageDirPath];
    NSArray *imageFiles;
    
    imageFiles = [manager contentsOfDirectoryAtPath:docDir error:&error];
    if (imageFiles) {
        if (index >= 0 && index < [imageFiles count]) {
            NSString* fileName = [imageFiles objectAtIndex:index];
            NSString* filePath = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
            NSData *data = [manager contentsAtPath:filePath];
            if (data) {
                return [[UIImage alloc]initWithData:data];
            }
        }
    }
    return nil;
}

-(BOOL)isImageExists:(NSInteger)index
{
    NSError* error;
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString* docDir = [LocalImageManager getUserImageDirPath];
    NSArray *imageFiles;
    
    [_userImages removeAllObjects];
    imageFiles = [manager contentsOfDirectoryAtPath:docDir error:&error];
    if (imageFiles) {
        if (index >= 0 && index < imageFiles.count) {
            return YES;
        }
    }
    return NO;
}

@end
