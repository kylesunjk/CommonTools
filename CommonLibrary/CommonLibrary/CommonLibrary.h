//
//  CommonLibrary.h
//  CommonLibrary
//
//  Created by Sun Jiakang on 30/7/14.
//  Copyright (c) 2014 Massive_Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonLibrary : NSObject
+ (UIImage *)fixOrientation:(UIImage *)oldImage withSize:(CGFloat)size;

+ (BOOL)isValidateByRegex:(NSString *)regex withValidateString:(NSString *)validateString;

+ (NSData *)toJSONData:(id)theData;

+ (id)toArrayOrNSDictionary:(NSData *)jsonData;
@end
