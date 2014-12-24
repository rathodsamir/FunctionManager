//
//  FunctionManager.h
//  FunctionManager
//
//  Created by Tops on 12/23/14.
//  Copyright (c) 2014 Tops Technology Pvt.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionManager : NSObject

#pragma mark - String Operations
+(NSString *)removeNull:(NSString *)str;
+(NSString *)makeFirstCharecterCapital : (NSString *)str;
+(NSString *)trimWhiteSpace : (NSString *) strTemp;
+(BOOL) stringIsBlankOrNot :(NSString *)stringTemp;

#pragma mark - UIAlertView Functions
+(void)showMessage:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withDelegage:(id)pIDDelegate;
+(void)showMessageWithConfirm:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withTag:(NSInteger)pintTag withDelegage:(id)pIDDelegate;
+(void)showMessageWithButtons:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withOtherButtons:(NSString *)pstrBtns withTag:(NSInteger)pintTag withDelegage:(id)pIDDelegate;
+(void)showMessage:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withDelegage:(id)pIDDelegate  view:(UIViewController *)veiwObj;

//+(void)showMessageWithConfirm:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withTag:(NSInteger)pintTag withDelegage:(id)pIDDelegate viewObj:(UIViewController *)viewObject;
#pragma mark - Image Functions
+(UIImage *)imageScaleAndCropToMaxSize:(UIImage *)pImage withSize:(CGSize)pNewSize;
+(UIImage *)imageScaleAndCropWithFixWidth:(UIImage *)pImage withWidth:(CGFloat)pfltWidth;
+(UIImage *)imageWithImage:(UIImage *)pImage scaledToSize:(CGSize)psizNewSize;
+(void)setImageCorner:(UIImageView *)pImgView radius:(float)pfltRadios;

#pragma mark - Email Function
+(BOOL)isValidEmail : (NSString *)emailAddress;

#pragma mark - Camera Availability Functions
+(BOOL)isCameraDeviceAvailable;
+(BOOL)isFrontCameraDeviceAvailable;
+(BOOL)isRearCameraDeviceAvailable;
+(UIImagePickerControllerCameraDevice)getAvailableCameraFront;
+(UIImagePickerControllerCameraDevice)getAvailableCameraRear;

#pragma mark - Font
+ (UIFont *)setNavigationTitleFont;
+ (UIFont *)setOtherFont;

#pragma  mark - UIColor
+ (UIColor *)getRGBColor : (float)r g:(float)g b:(float)b;

#pragma mark - Dynamicheight of UILabel

+ (CGRect)getDynamicHeightofLabel : (NSString *)textString myLabel:(UILabel *)resizableLable;
/**/
@end
