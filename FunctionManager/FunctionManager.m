//
//  FunctionManager.m
//  FunctionManager
//
//  Created by Tops on 12/23/14.
//  Copyright (c) 2014 Tops Technology Pvt.Ltd. All rights reserved.
//

#import "FunctionManager.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@implementation FunctionManager


#pragma mark - String Operations

+ (NSString *)makeFirstCharecterCapital : (NSString *)str {
    NSString *capitalisedSentence;
    capitalisedSentence = [str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] capitalizedString]];
    return capitalisedSentence;
}

+ (NSString *)removeNull:(NSString *)str
{
    str = [NSString stringWithFormat:@"%@",str];
    if (!str) {
        return @"";
    }
    else if([str isEqualToString:@"<null>"]){
        return @"";
    }
    else if([str isEqualToString:@"(null)"]){
        return @"";
    }
    else if([str isEqualToString:@"N/A"]){
        return @"";
    }
    else if([str isEqualToString:@"n/a"]){
        return @"";
    }
    else if ([str isEqualToString:nil]){
        return @"";
    }
    else{
        return str;
    }
}

+(NSString *)trimWhiteSpace : (NSString *) strTemp
{
    NSMutableString *s = [strTemp mutableCopy] ;
    CFStringTrimWhitespace ((CFMutableStringRef) s);
    return (NSString *) [s copy];
}

+ (BOOL) stringIsBlankOrNot :(NSString *)stringTemp {
    stringTemp = [self removeNull:stringTemp];
    if ([stringTemp isEqualToString:@""] || stringTemp==nil) {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - UIAlertView Functions
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
+(void)showMessage:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withDelegage:(id)pIDDelegate  view:(UIViewController *)veiwObj{
    
    UIAlertController *alertObj =[UIAlertController alertControllerWithTitle:pstrTitle message:pstrMsg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Okaction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [alertObj addAction:Okaction];
    [veiwObj presentViewController:alertObj animated:YES completion:nil];
    
}


#else
+(void)showMessage:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withDelegage:(id)pIDDelegate{
    UIAlertView *objAlertMsg = [[UIAlertView alloc] initWithTitle:pstrTitle
                                                          message:pstrMsg
                                                         delegate:pIDDelegate
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
    [objAlertMsg show];
}
+(void)showMessageWithConfirm:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withTag:(NSInteger)pintTag withDelegage:(id)pIDDelegate{
    UIAlertView *objAlertMsg = [[UIAlertView alloc] initWithTitle:pstrTitle
                                                          message:pstrMsg
                                                         delegate:pIDDelegate
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"Yes",@"No",nil];
    objAlertMsg.tag = pintTag;
    [objAlertMsg show];
}

+(void)showMessageWithButtons:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withOtherButtons:(NSString *)pstrBtns withTag:(NSInteger)pintTag withDelegage:(id)pIDDelegate{
    UIAlertView *objAlertMsg = [[UIAlertView alloc] initWithTitle:pstrTitle
                                                          message:pstrMsg
                                                         delegate:pIDDelegate
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:nil];
    
    NSArray *arrBtns = [pstrBtns componentsSeparatedByString:@","];
    for(int i=0;i<[arrBtns count];i++)
        [objAlertMsg addButtonWithTitle:[arrBtns objectAtIndex:i]];
    
    objAlertMsg.tag = pintTag;
    [objAlertMsg show];
}

#endif


#pragma mark - Image Functions
+(UIImage *)imageScaleAndCropToMaxSize:(UIImage *)pImage withSize:(CGSize)pNewSize
{
    CGFloat largestSize = (pNewSize.width > pNewSize.height) ? pNewSize.width : pNewSize.height;
    CGSize imageSize = [pImage size];
    
    // Scale the image while mainting the aspect and making sure the
    // the scaled image is not smaller then the given new size. In
    // other words we calculate the aspect ratio using the largest
    // dimension from the new size and the small dimension from the
    // actual size.
    CGFloat ratio;
    if (imageSize.width > imageSize.height)
        ratio = largestSize / imageSize.height;
    else
        ratio = largestSize / imageSize.width;
    
    CGRect rect = CGRectMake(0.0, 0.0, ratio * imageSize.width, ratio * imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    [pImage drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Crop the image to the requested new size maintaining
    // the inner most parts of the image.
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    imageSize = [scaledImage size];
    if (imageSize.width < imageSize.height)
        offsetY = (imageSize.height / 2) - (imageSize.width / 2);
    else
        offsetX = (imageSize.width / 2) - (imageSize.height / 2);
    
    CGRect cropRect = CGRectMake(offsetX, offsetY, imageSize.width - (offsetX * 2), imageSize.height - (offsetY * 2));
    
    CGImageRef croppedImageRef = CGImageCreateWithImageInRect([scaledImage CGImage], cropRect);
    UIImage *newImage = [UIImage imageWithCGImage:croppedImageRef];
    CGImageRelease(croppedImageRef);
    
    return newImage;
}

+(UIImage *)imageScaleAndCropWithFixWidth:(UIImage *)pImage withWidth:(CGFloat)pfltWidth
{
    CGFloat largestSize = pfltWidth;
    CGSize imageSize = [pImage size];
    
    // Scale the image while mainting the aspect and making sure the
    // the scaled image is not smaller then the given new size. In
    // other words we calculate the aspect ratio using the largest
    // dimension from the new size and the small dimension from the
    // actual size.
    CGFloat ratio;
    
    if (imageSize.width>largestSize)
        ratio = largestSize / imageSize.width;
    else
        ratio=1;
    
    CGRect rect = CGRectMake(0.0, 0.0, ratio * imageSize.width, ratio * imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    [pImage drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Crop the image to the requested new size maintaining
    // the inner most parts of the image.
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    imageSize = [scaledImage size];
    
    CGRect cropRect = CGRectMake(offsetX, offsetY, imageSize.width - (offsetX * 2), imageSize.height - (offsetY * 2));
    
    CGImageRef croppedImageRef = CGImageCreateWithImageInRect([scaledImage CGImage], cropRect);
    UIImage *newImage = [UIImage imageWithCGImage:croppedImageRef];
    CGImageRelease(croppedImageRef);
    
    return newImage;
}

+(UIImage *)imageWithImage:(UIImage *)pImage scaledToSize:(CGSize)psizNewSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(psizNewSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [pImage drawInRect:CGRectMake(0, 0, psizNewSize.width, psizNewSize.height)];
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+(void)setImageCorner:(UIImageView *)pImgView radius:(float)pfltRadios
{
    pImgView.layer.masksToBounds = YES;
    pImgView.layer.cornerRadius = pfltRadios;
}


#pragma mark - Email Function
+(BOOL)isValidEmail : (NSString *)emailAddress
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailAddress];
}


#pragma mark - Camera Availability Functions
+(BOOL)isCameraDeviceAvailable
{
    BOOL bolCameraAvailable=NO;
    if([UIImagePickerController	isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
            bolCameraAvailable = YES;
    }
    return bolCameraAvailable;
}

+(BOOL)isFrontCameraDeviceAvailable
{
    BOOL bolCameraAvailable=NO;
    if([UIImagePickerController	isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
            bolCameraAvailable = YES;
    }
    return bolCameraAvailable;
}

+(BOOL)isRearCameraDeviceAvailable
{
    BOOL bolCameraAvailable=NO;
    if([UIImagePickerController	isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
            bolCameraAvailable = YES;
    }
    return bolCameraAvailable;
}

+(UIImagePickerControllerCameraDevice)getAvailableCameraFront
{
    UIImagePickerControllerCameraDevice availableDevice = NSNotFound;
    
    if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
        availableDevice = UIImagePickerControllerCameraDeviceFront;
    
    return availableDevice;
}

+(UIImagePickerControllerCameraDevice)getAvailableCameraRear
{
    UIImagePickerControllerCameraDevice availableDevice = NSNotFound;
    
    if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
        availableDevice = UIImagePickerControllerCameraDeviceRear;
    
    return availableDevice;
}

#pragma mark - Font

+ (UIFont *)setNavigationTitleFont {
    UIFont *fontName=[UIFont fontWithName:@"Didot" size:16.0f];
    return fontName;
}

+ (UIFont *)setOtherFont {
    UIFont *fontName=[UIFont fontWithName:@"Didot" size:12.0f];
    return fontName;
}

#pragma  mark - UIColor

+ (UIColor *)getRGBColor : (float)r g:(float)g b:(float)b {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

#pragma mark - Dynamicheight of UILabel

+ (CGRect)getDynamicHeightofLabel : (NSString *)textString myLabel:(UILabel *)resizableLable{
    
    CGSize maxSize = CGSizeMake(resizableLable.frame.size.width, MAXFLOAT);
    
    CGRect labelRect = [resizableLable.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:resizableLable.font} context:nil];
    return labelRect;
    
/*
    
    CGSize constrainedSize = CGSizeMake(resizableLable.frame.size.width  , 9999);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"HelveticaNeue" size:11.0], NSFontAttributeName,NSLineBreakByWordWrapping,
                                          nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:textString attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    if (requiredHeight.size.width > resizableLable.frame.size.width) {
        requiredHeight = CGRectMake(0,0, resizableLable.frame.size.width, requiredHeight.size.height);
    }
    
    CGRect newFrame = resizableLable.frame;
    newFrame.size.height = requiredHeight.size.height;
    return newFrame;*/
}
@end
