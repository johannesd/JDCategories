//
//  NSSet+JDCategory.h
//
//  Created by Johannes Dörr on 24.12.12.
//
//

#import <Foundation/Foundation.h>

@interface NSSet (JDCategory)

- (NSSet*)setByXorWithSet:(NSSet*)set;
- (NSSet*)setByDeletingFromSet:(NSSet*)set;

@end
