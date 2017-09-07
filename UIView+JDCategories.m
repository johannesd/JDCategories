//
//  UIView+JDCategories.m
//  Pods
//
//  Created by Johannes Dörr on 19.10.16.
//
//

#import "UIView+JDCategories.h"

@implementation UIView (JDCategories)

- (UIViewController *)firstAvailableUIViewController
{
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

@end
