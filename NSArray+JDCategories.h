//
//  SPDeepCopy.h
//
//  Created by Sherm Pendley on 3/15/09.
//

#import <Foundation/Foundation.h>


@interface NSArray (JDCategories)

- (NSArray *)copyWithDeepCopiedValues;
- (NSMutableArray *)copyWithDeepCopiedAndMutableValues;
- (BOOL)containsPrefix:(NSString *)prefix;
- (BOOL)containsSuffix:(NSString *)suffix;
- (NSArray *)arrayByRemovingObject:(id)object;
- (NSDictionary *)groupItemsByKeyFromBlock:(id<NSCopying> (^)(id))keyBlock;
- (NSDictionary *)groupItemsByKey:(NSString *)key;

@end
