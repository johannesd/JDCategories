//
//  NSMutableDictionary+JDCategory.h
//
//  Created by Johannes Dörr on 11.10.14.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (JDCategory)

- (void)deepUpdateWithTemplate:(NSMutableDictionary *)templateDictionary;
- (void)setObjectOrNil:(id)objectOrNil forKey:(id<NSCopying>)key;

@end
