//
//  ViewController.m
//  Throat Doctor
//
//  Created by 연희 김 on 2014. 4. 9..
//  Copyright (c) 2014년 연희 김. All rights reserved.
//

#import "ViewController.h"
#import "CheckViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <Dropbox/Dropbox.h>
#import "LocalImageManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self setDropboxDBFileSystem];
//    [[LocalImageManager sharedManager] updateLocalImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////

// section갯수를 정하는 함수
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// section번호마다 항목이 몇개인지 정하는 함수
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Section 제목
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

// 기본 cell 생성 delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier_VH1981222";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    switch(indexPath.row) {
        case 0:
            [cell.textLabel setText:@"사진촬영"];
            break;
        case 1:
            [cell.textLabel setText:@"검사"];
            break;
        case 2:
            [cell.textLabel setText:@"Dropbox 링크"];
            break;
        default:
            [cell.textLabel setText:@"undefined"];
            break;
    }
    
    return cell;
}

// 선택할 때 호출되는 함수
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld selected", (long)indexPath.row);
    
    switch(indexPath.row) {
        case 0:
            // 사진을 찍는다.
            return [self takePicture];
        case 1:
            // 검사화면으로 이동
            return [self checkStatus];
        case 2:
            // 검사화면으로 이동
            return [self didPressLink];
    }
}

-(void)takePicture
{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate
{
    // 해당 장치가 카메라 사용이 가능한지 확인
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO) {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = YES;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        if (![[LocalImageManager sharedManager] saveUserImage:image]) {
            NSLog(@"can't save image!");
        }
    }
    else {
        NSLog(@"Not supported media type=%@", mediaType);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)checkStatus
{
//    [[LocalImageManager sharedManager] updateLocalImages];
    [self performSegueWithIdentifier:@"segueCheckViewController" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"segueCheckViewController"]){
        // segue대로 이동하기 전에 해야 할 작업이 있다면 여기에 작성한다.
    }
}

#pragma mark -
#pragma mark DropBox

- (IBAction)didPressLink {
    [[DBAccountManager sharedManager] linkFromController:self];
}

-(void)setDropboxDBFileSystem
{
    DBAccount *account = [[DBAccountManager sharedManager] linkedAccount];
    
    if (account) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:account];
        if ([DBFilesystem sharedFilesystem] == nil) {
            [DBFilesystem setSharedFilesystem:filesystem];
        }
    }
    else {
        NSLog(@"Can't get DBAccount!");
        //[self setDropboxDBFileSystem];
        [NSTimer scheduledTimerWithTimeInterval:0.5f
                                         target:self
                                       selector:@selector(setDropboxDBFileSystem)
                                       userInfo:nil
                                        repeats:NO];
    }
}

-(void)makeFile
{
    NSString* filename = [NSString stringWithFormat:@"%@_text.txt", [NSDate date]];
    DBPath *newPath = [[DBPath root] childPath:filename];
    DBFile *file = [[DBFilesystem sharedFilesystem] createFile:newPath error:nil];
    [file writeString:@"Hello World!" error:nil];
    [file close];
}

@end
