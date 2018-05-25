//
//  SPDeepCopy.m
//
//  Created by Sherm Pendley on 3/15/09.
//

#import "NSArray+JDCategories.h"
#import <BlocksKit/NSArray+BlocksKit.h>
#import "NSDictionary+JDCategories.h"

@implementation NSArray (JDCategories)

- (NSArray *)copyWithDeepCopiedValues
{
    NSUInteger count = [self count];
    id cArray[count];
    
    for (unsigned int i = 0; i < count; ++i) {
        id obj = [self objectAtIndex:i];
        if ([obj respondsToSelector:@selector(copyWithDeepCopiedValues)])
            cArray[i] = [obj copyWithDeepCopiedValues];
        else if ([obj respondsToSelector:@selector(copyWithZone:)])
            cArray[i] = [obj copy];
        else
            cArray[i] = obj;
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
        else if ([obj respondsToSelector:@selector(copy)])
            // If all else fails, fall back to an ordinary copy
            cArray[i] = [obj copy];
        else
            cArray[i] = obj;
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

- (BOOL)containsSuffix:(NSString *)suffix
{
    for (id obj in self) {
        if ([obj isKindOfClass:[NSString class]] && [obj hasSuffix:suffix]) {
            return TRUE;
        }
    }
    return FALSE;
}

- (NSArray *)arrayByRemovingObject:(id)object
{
    NSMutableArray *arr = [self mutableCopy];
    [arr removeObject:object];
    return [arr copy];
}

- (NSDictionary *)groupItemsByKeyFromBlock:(id<NSCopying> (^)(id))keyBlock
{
    return [self bk_reduce:[NSDictionary dictionary] withBlock:^id(NSDictionary *sum, NSObject *obj) {
        id<NSCopying>value = keyBlock(obj);
        if (value == nil) {
            value = [NSNull null];
        }
        NSMutableArray *arr = [sum[value] mutableCopy];
        if (arr == nil) {
            arr = [NSMutableArray array];
        }
        [arr addObject:obj];
        return [sum dictionaryByAddingObject:arr forKey:value];
    }];
}

- (NSDictionary *)groupItemsByKey:(NSString *)key
{
    return [self groupItemsByKeyFromBlock:^id<NSCopying>(id obj) {
        return [((NSObject *)obj) valueForKey:key];
    }];
}

@end
