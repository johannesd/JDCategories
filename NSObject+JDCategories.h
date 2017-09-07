//
//  NSObject+JDCategories.h
//  Pods
//
//  Created by Johannes Dörr on 14.05.15.
//
//

#import <Foundation/Foundation.h>


extern void JDSwizzleMethods(Class class, SEL originalSelector, SEL overrideSelector);


@interface NSObject (JDCategories)

- (void)performSelector:(SEL)aSelector withMinTimeInterval:(NSTimeInterval)timeInterval;

@end
