//
//  UIImage+JDCategories.m
//
//  Created by Johannes Dörr on 16.10.14.
//
//

#import "UIImage+JDCategories.h"

@implementation UIImage (JDCategories)

- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)grayscaleImage
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    CIImage *grayscale = [ciImage imageByApplyingFilter:@"CIColorControls"
                                    withInputParameters: @{ kCIInputSaturationKey: @0.0}];
    return [UIImage imageWithCIImage:grayscale scale:2 orientation:UIImageOrientationUp];
}

- (UIImage *)imageConvertedToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (UIImage *)verticallyReflectedImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -self.size.height);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (UIImage *)horizontallyReflectedImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, -1.0, 1.0);
    CGContextTranslateCTM(context, -self.size.width, 0.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (UIImage *)rotatedImage:(BOOL)clockwise
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.height, self.size.width), NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, -1.0, 1.0);
    CGContextRotateCTM(context, M_PI_2);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (!clockwise) {
        return [destImage verticallyReflectedImage];
    }
    return destImage;
}

+ (id)imageFromImage:(UIImage *)image string:(NSString *)string color:(UIColor *)color
{
    UIFont *font = [UIFont systemFontOfSize:16.0];
    CGSize expectedTextSize = [string sizeWithAttributes:@{NSFontAttributeName: font}];
    int width = expectedTextSize.width + image.size.width + 5;
    int height = MAX(expectedTextSize.height, image.size.width);
    CGSize size = CGSizeMake((float)width, (float)height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    int fontTopPosition = (height - expectedTextSize.height) / 2;
    CGPoint textPoint = CGPointMake(image.size.width + 5, fontTopPosition);
    
    [string drawAtPoint:textPoint withAttributes:@{NSFontAttributeName: font}];
    // Images upside down so flip them
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, size.height);
    CGContextConcatCTM(context, flipVertical);
    CGContextDrawImage(context, (CGRect){ {0, (height - image.size.height) / 2}, {image.size.width, image.size.height} }, [image CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (id)imageFromImageAtTop:(UIImage *)image string:(NSString *)string color:(UIColor *)color
{
    UIFont *font = [UIFont systemFontOfSize:15.0];
    CGSize expectedTextSize = [string sizeWithAttributes:@{NSFontAttributeName: font}];
    int width = MAX(expectedTextSize.width, image.size.width);
    int height = expectedTextSize.height + image.size.height;
    CGSize size = CGSizeMake((float)width, (float)height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGPoint textPoint = CGPointMake((width - expectedTextSize.width) / 2, image.size.height);
    
    [string drawAtPoint:textPoint withAttributes:@{NSFontAttributeName: font}];
    // Images upside down so flip them
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, size.height);
    CGContextConcatCTM(context, flipVertical);
    CGContextDrawImage(context, (CGRect){ {(width - image.size.width) / 2, expectedTextSize.height}, {image.size.width, image.size.height} }, [image CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
