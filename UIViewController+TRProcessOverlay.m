//
//  UIViewController+TRProcessOverlay.m
//
//  Created by Johannes Dörr on 18.10.13.
//  Copyright (c) 2013 Termine24. All rights reserved.
//

#import "UIViewController+TRProcessOverlay.h"
#import <objc/runtime.h>

static char kProcessOverlayKey;
static char kProcessOverlaySpinnerKey;
static char kProcessOverlayLabelKey;
static char kBackButtonIsVisibleKey;
static char kEnabledLeftBarButtonItemsKey;
static char kEnabledRightBarButtonItemsKey;
static char kShowingKey;


@interface UIViewController (TRProcessOverlayPrivate)

@property (nonatomic, strong, readonly) UIView *jd_processOverlay;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *jd_processOverlaySpinner;
@property (nonatomic, strong, readonly) UILabel *jd_processOverlayLabel;
@property (nonatomic, assign) BOOL backButtonIsVisible;
@property (nonatomic, strong, readonly) NSMutableSet *enabledLeftBarButtonItems;
@property (nonatomic, strong, readonly) NSMutableSet *enabledRightBarButtonItems;
@property (nonatomic, assign) BOOL showing;

@end


@implementation UIViewController (JDProcessOverlay)

+ (void)load
{
    Method original, swizzled;
    original = class_getInstanceMethod(self, @selector(viewWillLayoutSubviews));
    swizzled = class_getInstanceMethod(self, @selector(jd_processOverlay_viewWillLayoutSubviews));
    method_exchangeImplementations(original, swizzled);
}

- (void)jd_showProcessOverlay
{
    [self jd_showProcessOverlayWithText:nil];
}

- (void)jd_showProcessOverlayWithText:(NSString *)text;
{
    if (self.showing) return;
    [self.jd_processOverlay addSubview:self.jd_processOverlaySpinner];
    [self.jd_processOverlay addSubview:self.jd_processOverlayLabel];
    [self.view addSubview:self.jd_processOverlay];
    [self jd_layoutViews];

    self.backButtonIsVisible = !self.navigationItem.hidesBackButton;
    self.navigationItem.hidesBackButton = TRUE;
    [self.enabledLeftBarButtonItems removeAllObjects];
    [self.enabledRightBarButtonItems removeAllObjects];
    for (UIBarButtonItem *item in self.navigationItem.leftBarButtonItems) {
        if (item.enabled) {
            [self.enabledLeftBarButtonItems addObject:item];
            item.enabled = FALSE;
        }
    }
    for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
        if (item.enabled) {
            [self.enabledRightBarButtonItems addObject:item];
            item.enabled = FALSE;
        }
    }
    [self.jd_processOverlaySpinner startAnimating];
    self.jd_processOverlayLabel.text = text;
    self.showing = TRUE;
}

- (void)jd_hideProcessOverlay
{
    if (!self.showing) return;
    [self.jd_processOverlay removeFromSuperview];
    [self.jd_processOverlaySpinner stopAnimating];
    
    if (self.navigationController != nil && self.navigationController.childViewControllers.count > 1) {
        // XXX: a back arrow becomes visible for some reason...
        self.navigationItem.hidesBackButton = !self.backButtonIsVisible;
    }
    for (UIBarButtonItem *item in self.navigationItem.leftBarButtonItems) {
        if ([self.enabledLeftBarButtonItems containsObject:item]) {
            item.enabled = TRUE;
        }
    }
    for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
        if ([self.enabledRightBarButtonItems containsObject:item]) {
            item.enabled = TRUE;
        }
    }
    self.showing = FALSE;
}

- (void)jd_processOverlay_viewWillLayoutSubviews
{
    [self jd_processOverlay_viewWillLayoutSubviews];
    [self jd_layoutViews];
}

- (void)jd_layoutViews
{
    if ([self.view.subviews containsObject:self.jd_processOverlay]) {
        [self.jd_processOverlay removeFromSuperview];
        [self.view addSubview:self.jd_processOverlay];
        self.jd_processOverlay.frame = self.view.bounds;
        UIActivityIndicatorView *spinner = self.jd_processOverlaySpinner;
        spinner.frame = CGRectMake((self.view.bounds.size.width - spinner.frame.size.width) / 2,
                                   (self.view.bounds.size.height - spinner.frame.size.height) / 9 * 4,
                                   spinner.frame.size.width,
                                   spinner.frame.size.height);
        UILabel *label = self.jd_processOverlayLabel;
        label.frame = CGRectMake(0,
                                 spinner.frame.origin.y + spinner.frame.size.height,
                                 self.view.bounds.size.width,
                                 45);
    }
}

- (UIColor *)jd_processOverlayColor
{
    return self.jd_processOverlaySpinner.color;
}

- (void)setJd_processOverlayColor:(UIColor *)color
{
    self.jd_processOverlaySpinner.color = color;
    self.jd_processOverlayLabel.textColor = color;
}


#pragma mark - Properties for UI elements

- (UIView *)jd_processOverlay
{
    UIView *overlay = objc_getAssociatedObject(self, &kProcessOverlayKey);
    if (overlay == nil) {
        overlay = [[UIToolbar alloc] init];
        ((UIToolbar *)overlay).barStyle = UIBarStyleDefault;
        overlay.userInteractionEnabled = TRUE;
        objc_setAssociatedObject(self, &kProcessOverlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return overlay;
}

- (UIActivityIndicatorView *)jd_processOverlaySpinner
{
    UIActivityIndicatorView *spinner = objc_getAssociatedObject(self, &kProcessOverlaySpinnerKey);
    if (spinner == nil) {
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.hidesWhenStopped = TRUE;
        objc_setAssociatedObject(self, &kProcessOverlaySpinnerKey, spinner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return spinner;
}

- (UILabel *)jd_processOverlayLabel
{
    UILabel *label = objc_getAssociatedObject(self, &kProcessOverlayLabelKey);
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        objc_setAssociatedObject(self, &kProcessOverlayLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}


#pragma mark - Properties for states

- (BOOL)showing
{
    NSNumber *val = objc_getAssociatedObject(self, &kShowingKey);
    return val != nil && val.boolValue;
}

- (void)setShowing:(BOOL)showing
{
    objc_setAssociatedObject(self, &kShowingKey, @(showing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)backButtonIsVisible
{
    NSNumber *val = objc_getAssociatedObject(self, &kBackButtonIsVisibleKey);
    return val != nil && val.boolValue;
}

- (void)setBackButtonIsVisible:(BOOL)backButtonIsVisible
{
    objc_setAssociatedObject(self, &kBackButtonIsVisibleKey, @(backButtonIsVisible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet *)enabledLeftBarButtonItems
{
    NSMutableSet *set = objc_getAssociatedObject(self, &kEnabledLeftBarButtonItemsKey);
    if (set == nil) {
        set = [NSMutableSet set];
        objc_setAssociatedObject(self, &kEnabledLeftBarButtonItemsKey, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return set;
}

- (NSMutableSet *)enabledRightBarButtonItems
{
    NSMutableSet *set = objc_getAssociatedObject(self, &kEnabledRightBarButtonItemsKey);
    if (set == nil) {
        set = [NSMutableSet set];
        objc_setAssociatedObject(self, &kEnabledRightBarButtonItemsKey, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return set;
}

@end
