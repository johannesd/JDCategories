//
//  NSDictionary+JDCategories.m
//
//  Created by Johannes Dörr on 24.02.15.
//
//

#import "NSDictionary+JDCategories.h"

@implementation NSDictionary (JDCategories)

- (NSDictionary *)dictionaryByAddingDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *mutableSelf = [self mutableCopy];
    for (id<NSCopying>key in dictionary.keyEnumerator) {
        mutableSelf[key] = dictionary[key];
    }
    return [mutableSelf copy];
}

@end
