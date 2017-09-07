//
//  UIColor+JDCategories.h
//  Pods
//
//  Created by Johannes Dörr on 30.05.16.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (JDCategories)

- (UIColor *)mixWithColor:(UIColor *)color alpha:(CGFloat)alpha;
- (UIColor *)colorWithLightness:(CGFloat)lightness;
- (UIColor *)grayscale;
- (BOOL)isGrayscaleTolerance:(int)tolerance;
- (NSString *)rgbaString;

@end
