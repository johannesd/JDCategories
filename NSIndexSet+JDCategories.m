//
//  NSIndexSet+JDCategories.m
//
//  Created by Johannes Dörr on 25.01.15.
//
//

#import "NSIndexSet+JDCategories.h"

@implementation NSIndexSet (JDCategories)

+ (NSIndexSet *)indexSetWithArray:(NSArray *)array
{
    NSMutableIndexSet *indices = [NSMutableIndexSet indexSet];
    for (NSNumber *index in array) {
        int intIndex = [index intValue];
        if (intIndex >= 0) {
            [indices addIndex:intIndex];
        }
    }
    return [indices copy];
}

- (NSIndexSet *)indexSetByAddingIndicesFromSet:(NSIndexSet *)indexSet
{
    NSMutableIndexSet *indices = [self mutableCopy];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger intIndex, BOOL *stop) {
        [indices addIndex:intIndex];
    }];
    return [indices copy];
}

@end
