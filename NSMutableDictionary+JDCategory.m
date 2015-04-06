//
//  NSMutableDictionary+JDCategory.m
//
//  Created by Johannes Dörr on 11.10.14.
//
//

#import "NSMutableDictionary+JDCategory.h"
#import <BlocksKit/NSObject+BKAssociatedObjects.h>

@implementation NSMutableDictionary (JDCategory)

- (void)deepUpdateWithTemplate:(NSMutableDictionary *)templateDictionary
{
    for (NSString *key in templateDictionary.keyEnumerator) {
        if (self[key] == nil) {
            self[key] = templateDictionary[key];
        }
        else if ([self[key] isKindOfClass:[NSMutableDictionary class]]) {
            NSMutableDictionary *template = [templateDictionary[key] bk_associatedValueForKey:@"itemTemplateDictionary"];
            if (template != nil) {
                if ([template isKindOfClass:[NSMutableDictionary class]]) {
                    for (NSString *subKey in [self[key] keyEnumerator]) {
                        [self[key][subKey] deepUpdateWithTemplate:template];
                    }
                }
            }
            else {
                [self[key] deepUpdateWithTemplate:templateDictionary[key]];
            }
        }
    }
}


- (void)setObjectOrNil:(id)objectOrNil forKey:(id<NSCopying>)key
{
    if (objectOrNil == nil) {
        [self removeObjectForKey:key];
    }
    else {
        [self setObject:objectOrNil forKey:key];
    }
}

@end
