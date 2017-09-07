//
//  NSString+JDCategories.m
//  Pods
//
//  Created by Johannes Dörr on 23.01.16.
//
//

#import "NSString+JDCategories.h"

@implementation NSString (JDCategories)

- (NSArray *)keyPathParts
{
    NSUInteger dotLocation = [self rangeOfString:@"." options:NSBackwardsSearch].location;
    NSString *lastKeyPart = self;
    NSString *baseKeyPath = @"";
    if (dotLocation != NSNotFound) {
        lastKeyPart = [self substringFromIndex:dotLocation + 1];
        baseKeyPath = [self substringToIndex:self.length - lastKeyPart.length];
    }
    return @[baseKeyPath, lastKeyPart];
}

@end
