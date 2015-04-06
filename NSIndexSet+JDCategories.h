//
//  NSIndexSet+JDCategories.h
//
//  Created by Johannes Dörr on 25.01.15.
//
//

#import <Foundation/Foundation.h>

@interface NSIndexSet (JDCategories)

+ (NSIndexSet *)indexSetWithArray:(NSArray *)array;
- (NSIndexSet *)indexSetByAddingIndicesFromSet:(NSIndexSet *)indexSet;

@end
