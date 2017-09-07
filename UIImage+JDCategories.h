//
//  UIImage+JDCategories.h
//
//  Created by Johannes Dörr on 16.10.14.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (JDCategories)

- (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)grayscaleImage;
- (UIImage *)imageConvertedToSize:(CGSize)size;
- (UIImage *)verticallyReflectedImage;
- (UIImage *)horizontallyReflectedImage;
- (UIImage *)rotatedImage:(BOOL)clockwise;

+ (id)imageFromImage:(UIImage *)image string:(NSString *)string color:(UIColor *)color;
+ (id)imageFromImageAtTop:(UIImage *)image string:(NSString *)string color:(UIColor *)color;

@end
