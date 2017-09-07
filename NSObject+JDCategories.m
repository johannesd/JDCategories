//
//  NSObject+JDCategories.m
//  Pods
//
//  Created by Johannes Dörr on 14.05.15.
//
//

#import "NSObject+JDCategories.h"
#import <BlocksKit/BlocksKit.h>
#import <objc/runtime.h>


extern void JDSwizzleMethods(Class class, SEL originalSelector, SEL overrideSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method overrideMethod = class_getInstanceMethod(class, overrideSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(class, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}


@implementation NSObject (JDCategories)

- (void)performSelector:(SEL)aSelector withMinTimeInterval:(NSTimeInterval)timeInterval
{
    assert(timeInterval > 0);
    NSMutableDictionary *lastCalls = [self bk_associatedValueForKey:@"JDCategoriesLastCalls"];
    if (lastCalls == nil) {
        lastCalls = [NSMutableDictionary dictionary];
        [self bk_associateValue:lastCalls withKey:@"JDCategoriesLastCalls"];
    }
    NSString *selectorString = NSStringFromSelector(aSelector);
    NSDate *lastCall = lastCalls[selectorString];
    if (lastCall == nil) {
        [self performSelector:aSelector withObject:nil afterDelay:0];
        lastCalls[selectorString] = [NSDate date];
//        NSLog(@"no previous call");
    }
    else {
        NSTimeInterval lastCallInterval = -[lastCall timeIntervalSinceNow];
        if (lastCallInterval < 0) {
            // A future call is already scheduled
//            NSLog(@"future call already scheduled");
        }
        else if (lastCallInterval > timeInterval) {
            // Last call was long ago enough
            [self performSelector:aSelector withObject:nil afterDelay:0];
            lastCalls[selectorString] = [NSDate date];
//            NSLog(@"ok, new call");
        }
        else if (lastCallInterval < timeInterval) {
            NSTimeInterval remainingTime = timeInterval - lastCallInterval;
            [self performSelector:aSelector withObject:nil afterDelay:remainingTime];
            lastCalls[selectorString] = [NSDate dateWithTimeIntervalSinceNow:remainingTime];
//            NSLog(@"schedule next call");
        }
    }
}

@end
