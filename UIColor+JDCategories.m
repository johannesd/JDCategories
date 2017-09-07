//
//  UIColor+JDCategories.m
//  Pods
//
//  Created by Johannes Dörr on 30.05.16.
//
//

#import "UIColor+JDCategories.h"
#import <EDColor/EDColor.h>

@implementation UIColor (JDCategories)

- (UIColor *)mixWithColor:(UIColor *)color alpha:(CGFloat)alpha
{
    if ([color isEqual:[UIColor clearColor]]) {
        return self;
    }
    alpha = MIN( 1.0, MAX( 0.0, alpha ) );
    CGFloat beta = 1.0 - alpha;
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [self getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    return [UIColor colorWithRed:r1 * beta + r2 * alpha
                           green:g1 * beta + g2 * alpha
                            blue:b1 * beta + b2 * alpha
                           alpha:a1 * beta + a2 * alpha];
}

- (UIColor *)colorWithLightness:(CGFloat)lightness
{
    CGFloat lightness2;
    CGFloat a;
    CGFloat b;
    CGFloat alpha;
    [self getLightness:&lightness2 A:&a B:&b alpha:&alpha];
    return [UIColor colorWithLightness:lightness A:a B:b alpha:alpha];
}

- (UIColor *)grayscale
{
    CGFloat red = 0;
    CGFloat blue = 0;
    CGFloat green = 0;
    CGFloat alpha = 0;
    if ([self getRed:&red green:&green blue:&blue alpha:&alpha]) {
        return [UIColor colorWithWhite:(0.299 * red + 0.587 * green + 0.114 * blue) alpha:alpha];
    }
    else {
        return self;
    }
}

- (BOOL)isGrayscaleTolerance:(int)tolerance
{
    CGFloat red = 0;
    CGFloat blue = 0;
    CGFloat green = 0;
    CGFloat alpha = 0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    CGFloat mean = (red + blue + green) / 3 * 255;
    red *= 255;
    blue *= 255;
    green *= 255;
    CGFloat redDiff = fabs(red - mean);
    CGFloat blueDiff = fabs(blue - mean);
    CGFloat greenDiff = fabs(green - mean);
    return redDiff < tolerance && blueDiff < tolerance && greenDiff < tolerance;
}

- (NSString *)rgbaString
{
    CGFloat red = 0;
    CGFloat blue = 0;
    CGFloat green = 0;
    CGFloat alpha = 0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return [NSString stringWithFormat:@"[%f, %f, %f, %f]", red, green, blue, alpha];
}

@end
