//
//  UIButton+JDCategories.m
//
//  Created by Johannes Dörr on 13.12.14.
//
//

#import "UIButton+JDCategories.h"

@implementation UIButton (JDCategories)

- (void)setImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setImageForDisabledState:(UIImage *)image
{
    [self setImage:image forState:UIControlStateDisabled];
}

- (void)setImageForHighlightedState:(UIImage *)image
{
    [self setImage:image forState:UIControlStateHighlighted];
}

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setAttributedTitle:(NSAttributedString *)title
{
    [self setAttributedTitle:title forState:UIControlStateNormal];
    [self setAttributedTitle:title forState:UIControlStateHighlighted];
}

@end
