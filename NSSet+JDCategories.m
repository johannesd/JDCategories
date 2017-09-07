//
//  NSSet+JDCategories.m
//
//  Created by Johannes Dörr on 24.12.12.
//
//

#import "NSSet+JDCategories.h"

@implementation NSSet (JDCategories)

- (NSSet *)setByXorWithSet:(NSSet *)set
{
    NSMutableSet *result = [NSMutableSet set];
    NSSet *unionSet = [self setByAddingObjectsFromSet:set];
    for (NSObject *object in unionSet) {
        if (([self containsObject:object] && ![set containsObject:object]) ||
            ([set containsObject:object] && ![self containsObject:object])) {
            [result addObject:object];
        }
    }
    return result;
}

- (NSSet *)setByDeletingFromSet:(NSSet *)set
{
    NSMutableSet *result = [NSMutableSet set];
    for (NSObject *object in self) {
        if (![set containsObject:object]) {
            [result addObject:object];
        }
    }
    return result;
}

- (NSSet *)setByIntersectingSet:(NSSet *)set
{
    NSMutableSet *mutSelf = [self mutableCopy];
    [mutSelf intersectSet:set];
    return [mutSelf copy];
}

@end
