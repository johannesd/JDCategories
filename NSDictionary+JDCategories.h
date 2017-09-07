//
//  NSDictionary+JDCategories.h
//
//  Created by Johannes Dörr on 24.02.15.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary<KeyType, ObjectType> (JDCategories)

- (NSDictionary *)dictionaryByAddingDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryByRemovingKey:(id<NSCopying>)key;
- (NSDictionary *)dictionaryByAddingObject:(id)object forKey:(id<NSCopying>)key;
- (NSDictionary *)invertedDictionary;
- (NSDictionary *)invertedDictionaryAssertBijectivity:(bool)assertBijectivity;
- (NSArray<ObjectType> *)objectsForKeysIfAvailable:(NSArray<KeyType> *)keys;
- (NSDictionary *)copyWithDeepCopiedValues;
- (NSMutableDictionary *)copyWithDeepCopiedAndMutableValues;

@end
