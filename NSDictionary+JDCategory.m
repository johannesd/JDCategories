//
//  NSDictionary+JDCategory.m
//  Pods
//
//  Created by Johannes Dörr on 24.02.15.
//
//

#import "NSDictionary+JDCategory.h"

@implementation NSDictionary (JDCategory)

- (NSDictionary *)dictionaryByAddingDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *mutableSelf = [self mutableCopy];
    for (id<NSCopying>key in dictionary.keyEnumerator) {
        mutableSelf[key] = dictionary[key];
    }
    return [mutableSelf copy];
}

@end
