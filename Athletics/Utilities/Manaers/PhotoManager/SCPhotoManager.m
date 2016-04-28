//
//  SCPhotoManager.m
//  Athletics
//
//  Created by mrzj_sc on 16/4/28.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "SCPhotoManager.h"

@interface SCPhotoManager ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, weak)     UIViewController          *fromController;
@property (nonatomic, copy)     SCPickerCompelitionBlock  completion;
@property (nonatomic, copy)     SCPickerCancelBlock       cancel;
@property (nonatomic, weak)     UIImagePickerController   *picker;

@end

@implementation SCPhotoManager

+ (instancetype)shared {
    static SCPhotoManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)shared {
    return [[self class] shared];
}

- (void)showActionSheetInView:(UIView *)inView
               fromController:(UIViewController *)fromController
                   completion:(SCPickerCompelitionBlock)completion
                       cancel:(SCPickerCancelBlock)cancel {
    self.completion = [completion copy];
    self.cancel = [cancel copy];
    self.fromController = fromController;
    
    dispatch_async(kGlobalThread, ^{
        UIActionSheet *actionSheet = nil;
        if ([self isCameraAvailable]) {
            actionSheet  = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:(id<UIActionSheetDelegate>)self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"从相册选择", @"拍照上传", nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:(id<UIActionSheetDelegate>)self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"从相册选择", nil];
        }
        
        dispatch_async(kMainThread, ^{
            [actionSheet showInView:inView];
        });
    });
}

- (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)canTakePhoto {
    return [self isCameraSupportMedia:(__bridge NSString *)kUTTypeImage
                           sourceType:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark - Private Methods
- (BOOL)isCameraSupportMedia:(NSString *)mediaType sourceType:(UIImagePickerControllerSourceType)sourceType {
    __block BOOL result = NO;
    if ([mediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:mediaType]){
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // 从相册选择
        
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            
            if (kIsIOS7OrLater) {
                picker.navigationBar.barTintColor = self.fromController.navigationController.navigationBar.barTintColor;
            }
            // 设置导航默认标题的颜色及字体大小
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
            [self.fromController presentViewController:picker animated:YES completion:nil];
        }
    } else if (buttonIndex == 1) { // 拍照
        
        if ([self canTakePhoto]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            if (kIsIOS7OrLater) {
                picker.navigationBar.barTintColor = self.fromController.navigationController.navigationBar.barTintColor;
            }
            // 设置导航默认标题的颜色及字体大小
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
            [self.fromController presentViewController:picker animated:YES completion:nil];
        }
    }
    return;
}


#pragma mark - UIImagePickerControllerDelegate
// 选择了图片或者拍照了
- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [aPicker dismissViewControllerAnimated:YES completion:nil];
    __block UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    if (image && self.completion) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        if (kIsIOS7OrLater) {
            [self.fromController setNeedsStatusBarAppearanceUpdate];
        }
        
        dispatch_async(kGlobalThread, ^{
//            CGFloat w = image.size.width;
//            CGFloat h = image.size.height;
//            if (w > kScreenWidth * 2.0) {
//                w = kScreenWidth * 2.0;
//            }
//            if (h > kScreenHeight * 2.0) {
//                h = kScreenHeight * 2.0;
//            }
            
//            image = [image scaleToSize:CGSizeMake(w, h)];
            dispatch_async(kMainThread, ^{
                if (self.completion) {
                    self.completion(image);
                }
                [aPicker dismissViewControllerAnimated:YES completion:NULL];
            });
        });
    }
    return;
}

// 取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)aPicker {
    self.picker = aPicker;
    [aPicker dismissViewControllerAnimated:YES completion:nil];
    
    if (self.cancel) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        if (kIsIOS7OrLater) {
            [self.fromController setNeedsStatusBarAppearanceUpdate];
        }
        
        self.cancel();
    }
    return;
}


@end
