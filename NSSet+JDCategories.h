//
//  NSSet+Operations.h
//
//  Created by Johannes Dörr on 24.12.12.
//
//

#import <Foundation/Foundation.h>

@interface NSSet (JDCategories)

- (NSSet*)setByXorWithSet:(NSSet*)set;
- (NSSet*)setByDeletingFromSet:(NSSet*)set;

@end
