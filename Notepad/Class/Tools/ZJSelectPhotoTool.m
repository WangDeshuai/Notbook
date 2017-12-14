//
//  ZJSelectPhotoTool.m
//  车管家
//
//  Created by linghang on 17/6/10.
//  Copyright © 2017年 zj. All rights reserved.
//

#import "ZJSelectPhotoTool.h"
#import "ZJPickerView.h"

@interface ZJSelectPhotoTool () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ZJSelectPhotoTool

static ZJSelectPhotoTool *object = nil;

+ (void)showSeletPhotoWith:(UIViewController *)controller NamesArray:(NSArray *)titlesArray IsEditing:(BOOL)isEditing BackImageBlock:(backPhotoBlock)block IsIcon:(BOOL)isIcon {

    object.isIcon = NO;
    
    // 1. 判断当前对象是否为空
    if ( object == nil ) {
        
        object = [[ZJSelectPhotoTool alloc] init];
        
    }
    object.isIcon = isIcon;
    // 2. 用来跳转界面的视图控制器赋值
    object.controller = controller;
    
    // 3. 指针指向带过来的block
    object.pointBlock = block;
    
    // 4. 显示选项列表
    [ZJPickerView showPickerViewWithNamesArray:titlesArray Block:^(NSString *title, NSInteger index) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = object;
        imagePicker.allowsEditing = isEditing;
        if (index == 1) { // 相机
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [LCProgressHUD showMessage:@"The camera doesn't work"];
                return;
            }
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [controller presentViewController:imagePicker animated:YES completion:nil];
            
        } else if (index == 0) { // 照片库
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [controller presentViewController:imagePicker animated:YES completion:nil];
            
        } else {
            
        }
        
    }];
}

#pragma mark - 图片选择器代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    // 1.  获取图片
    UIImage *newImage;
    if (_isIcon) {
        newImage = info[UIImagePickerControllerEditedImage];
        // 2. 回调图片block
        self.pointBlock(newImage);
        
        // 3. 消失图片控制器
        [self.controller dismissViewControllerAnimated:YES completion:nil];
    } else {
        newImage = info[UIImagePickerControllerOriginalImage];
        [self fixOrientation:newImage];
    }
    
}

- (UIImage *)fixOrientation:(UIImage *)aImage {
    if (aImage.imageOrientation == UIImageOrientationUp) {
        
        // 2. 回调图片block
        self.pointBlock(aImage);
    
        // 3. 消失图片控制器
        [self.controller dismissViewControllerAnimated:YES completion:nil];
        return aImage;
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
            
    }
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
            
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
            
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    // 2. 回调图片block
    self.pointBlock(img);
    
    // 3. 消失图片控制器
    [self.controller dismissViewControllerAnimated:YES completion:nil];
    return img;
}

@end
