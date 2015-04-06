//
//  SPDeepCopy.m
//
//  Created by Sherm Pendley on 3/15/09.
//

#import "NSArray+JDCategories.h"


@implementation NSArray (JDCategories)

- (NSArray *)copyWithDeepCopiedValues
{
    NSUInteger count = [self count];
    id cArray[count];
    
    for (unsigned int i = 0; i < count; ++i) {
        id obj = [self objectAtIndex:i];
        if ([obj respondsToSelector:@selector(copyWithDeepCopiedValues)])
            cArray[i] = [obj copyWithDeepCopiedValues];
        else
            cArray[i] = [obj copy];
    }
    
    NSArray *ret = [NSArray arrayWithObjects:cArray count:count];
    return ret;
}

- (NSMutableArray *)copyWithDeepCopiedAndMutableValues
{
    NSUInteger count = [self count];
    id cArray[count];
    
    for (unsigned int i = 0; i < count; ++i) {
        id obj = [self objectAtIndex:i];
        
        // Try to do a deep mutable copy, if this object supports it
        if ([obj respondsToSelector:@selector(copyWithDeepCopiedAndMutableValues)])
            cArray[i] = [obj copyWithDeepCopiedAndMutableValues];
        
        // Then try a shallow mutable copy, if the object supports that
        else if ([obj respondsToSelector:@selector(mutableCopyWithZone:)])
            cArray[i] = [obj mutableCopy];
        
        // Next try to do a deep copy
        else if ([obj respondsToSelector:@selector(copyWithDeepCopiedValues)])
            cArray[i] = [obj copyWithDeepCopiedValues];
        
        // If all else fails, fall back to an ordinary copy
        else
            cArray[i] = [obj copy];
    }
    
    NSMutableArray *ret = [NSMutableArray arrayWithObjects:cArray count:count];
    return ret;
}

- (BOOL)containsPrefix:(NSString *)prefix
{
    for (id obj in self) {
        if ([obj isKindOfClass:[NSString class]] && [obj hasPrefix:prefix]) {
            return TRUE;
        }
    }
    return FALSE;
}

@end


@implementation NSDictionary (JDCategories)

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