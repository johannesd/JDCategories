//
//  NSURL+JDCategories.m
//  Pods
//
//  Created by Johannes Dörr on 01.07.17.
//
//

#import "NSURL+JDCategories.h"

@implementation NSURL (JDCategories)

- (nullable NSURL *)URLBySavelyAppendingPathComponent:(NSString * _Nonnull)pathComponent
{
    if ([pathComponent hasPrefix:@"/"]) {
        pathComponent = [pathComponent substringFromIndex:1];
    }
    return [self URLByAppendingPathComponent:pathComponent];
}

@end
