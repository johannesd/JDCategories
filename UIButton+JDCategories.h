//
//  UIButton+JDCategories.h
//
//  Created by Johannes Dörr on 13.12.14.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (JDCategories)

- (void)setImage:(UIImage *)image;
- (void)setImageForDisabledState:(UIImage *)image;
- (void)setImageForHighlightedState:(UIImage *)image;
- (void)setTitle:(NSString *)title;

@end
