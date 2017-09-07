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

- (NSDictionary *)dictionaryByAddingObject:(id)object forKey:(id<NSCopying>)key
{
    return [self dictionaryByAddingDictionary:@{key: object}];
}

- (NSDictionary *)dictionaryByRemovingKey:(id<NSCopying>)key
{
    NSMutableDictionary *mutableSelf = [self mutableCopy];
    [mutableSelf removeObjectForKey:key];
    return [mutableSelf copy];
}

- (NSDictionary *)invertedDictionary
{
    return [self invertedDictionaryAssertBijectivity:FALSE];
}

- (NSDictionary *)invertedDictionaryAssertBijectivity:(bool)assertBijectivity
{
    NSMutableDictionary *inverted = [self mutableCopy];
    for (NSNumber *key in self) {
        NSNumber *value = self[key];
        assert(!assertBijectivity || inverted[value] != nil);
        inverted[value] = key;
    }
    return [inverted copy];
}

- (NSArray<id> *)objectsForKeysIfAvailable:(NSArray<id> *)keys
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *key in keys) {
        id object = [self objectForKey:key];
        if (object != nil) {
            [arr addObject:object];
        }
    }
    return [arr copy];
}

- (NSDictionary *)copyWithDeepCopiedValues
{
    NSUInteger count = [self count];
    id cObjects[count];
    id cKeys[count];
    
    NSEnumerator *e = [self keyEnumerator];
    unsigned int i = 0;
    id thisKey;
    while ((thisKey = [e nextObject]) != nil) {
        id obj = [self objectForKey:thisKey];
        
        if ([obj respondsToSelector:@selector(copyWithDeepCopiedValues)])
            cObjects[i] = [obj copyWithDeepCopiedValues];
        else
            cObjects[i] = [obj copy];
        
        if ([thisKey respondsToSelector:@selector(copyWithDeepCopiedValues)])
            cKeys[i] = [thisKey copyWithDeepCopiedValues];
        else
            cKeys[i] = [thisKey copy];
        
        ++i;
    }
    
    NSDictionary *ret = [NSDictionary dictionaryWithObjects:cObjects forKeys:cKeys count:count];
    return ret;
}

- (NSMutableDictionary *)copyWithDeepCopiedAndMutableValues
{
    NSUInteger count = [self count];
    id cObjects[count];
    id cKeys[count];
    
    NSEnumerator *e = [self keyEnumerator];
    unsigned int i = 0;
    id thisKey;
    while ((thisKey = [e nextObject]) != nil) {
        id obj = [self objectForKey:thisKey];
        
        // Try to do a deep mutable copy, if this object supports it
        if ([obj respondsToSelector:@selector(copyWithDeepCopiedAndMutableValues)]) {
            cObjects[i] = [obj copyWithDeepCopiedAndMutableValues];
        }
        
        // Then try a shallow mutable copy, if the object supports that
        else if ([obj respondsToSelector:@selector(mutableCopyWithZone:)]) {
            cObjects[i] = [obj mutableCopy];
        }
        
        // Next try to do a deep copy
        else if ([obj respondsToSelector:@selector(copyWithDeepCopiedValues)]) {
            cObjects[i] = [obj copyWithDeepCopiedValues];
        }
        
        // If all else fails, fall back to an ordinary copy
        else {
            cObjects[i] = [obj copy];
        }
        
        // I don't think mutable keys make much sense, so just do an ordinary copy
        if ([thisKey respondsToSelector:@selector(copyWithDeepCopiedValues)])
            cKeys[i] = [thisKey copyWithDeepCopiedValues];
        else
            cKeys[i] = [thisKey copy];
        
        ++i;
    }
    
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithObjects:cObjects forKeys:cKeys count:count];
    return ret;
}

@end

