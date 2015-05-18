//
//  NSMutableDictionary+JDCategories.h
//
//  Created by Johannes Dörr on 11.10.14.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (JDCategories)

- (void)deepUpdateWithTemplate:(NSMutableDictionary *)templateDictionary;
- (void)setObjectOrNil:(id)objectOrNil forKey:(id<NSCopying>)key;

@end
