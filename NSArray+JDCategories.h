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

@end


@interface NSDictionary (JDCategories)

- (NSDictionary *)copyWithDeepCopiedValues;
- (NSMutableDictionary *)copyWithDeepCopiedAndMutableValues;

@end