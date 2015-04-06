//
//  UIViewController+TRProcessOverlay.h
//
//  Created by Johannes Dörr on 18.10.13.
//  Copyright (c) 2013 Termine24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JDProcessOverlay)

- (void)jd_showProcessOverlay;
- (void)jd_showProcessOverlayWithText:(NSString *)text;
- (void)jd_hideProcessOverlay;
- (UIColor *)jd_processOverlayColor;
- (void)setJd_processOverlayColor:(UIColor *)color;

@end
