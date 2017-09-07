//
//  NSURL+JDCategories.h
//  Pods
//
//  Created by Johannes Dörr on 01.07.17.
//
//

#import <Foundation/Foundation.h>

@interface NSURL (JDCategories)

- (nullable NSURL *)URLBySavelyAppendingPathComponent:(NSString * _Nonnull)pathComponent;

@end
