//
//  CommonLibrary.m
//  CommonLibrary
//
//  Created by Sun Jiakang on 30/7/14.
//  Copyright (c) 2014 Massive_Infinity. All rights reserved.
//

#import "CommonLibrary.h"

@implementation CommonLibrary



+ (UIImage *)fixOrientation:(UIImage *)oldImage withSize:(CGFloat)size {
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    float a = oldImage.size.width;
    float b = oldImage.size.height;
    float c = 1;
    if(a<=b){
        c = a/size;
    }else{
        c = b/size;
    }
    
    
    switch (oldImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, oldImage.size.width/c, oldImage.size.height/c);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, oldImage.size.width/c, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, oldImage.size.height/c);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (oldImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, oldImage.size.width/c, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, oldImage.size.height/c, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, oldImage.size.width/c, oldImage.size.height/c,
                                             CGImageGetBitsPerComponent(oldImage.CGImage), 0,
                                             CGImageGetColorSpace(oldImage.CGImage),
                                             CGImageGetBitmapInfo(oldImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (oldImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,oldImage.size.height/c,oldImage.size.width/c), oldImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,oldImage.size.width/c,oldImage.size.height/c), oldImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


+ (BOOL)isValidateByRegex:(NSString *)regex withValidateString:(NSString *)validateString {
   
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:validateString];
    
}

#pragma mark - data exchange

+ (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

+ (id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}
@end
