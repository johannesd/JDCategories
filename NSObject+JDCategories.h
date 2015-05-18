//
//  NSObject+JDCategories.h
//  Pods
//
//  Created by Johannes Dörr on 14.05.15.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JDCategories)

- (void)performSelector:(SEL)aSelector withMinTimeInterval:(NSTimeInterval)timeInterval;

@end
