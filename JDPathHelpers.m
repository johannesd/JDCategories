//
//  PathHelpers.m
//  Pods
//
//  Created by Johannes Dörr on 10.07.16.
//
//

#import "JDPathHelpers.h"

CGPathRef JDPathRoundedRect(CGAffineTransform *transform, CGRect bounds, CGFloat topLeftRadius, CGFloat bottomLeftRadius, CGFloat bottomRightRadius, CGFloat topRightRadius)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, bounds.origin.x + topLeftRadius, bounds.origin.y);
    CGPathAddArc(path, NULL, bounds.origin.x + bounds.size.width - topRightRadius, bounds.origin.y + topRightRadius, topRightRadius, 3 * M_PI / 2, 0, NO);
    CGPathAddArc(path, NULL, bounds.origin.x + bounds.size.width - bottomRightRadius, bounds.origin.y + bounds.size.height - bottomRightRadius, bottomRightRadius, 0, M_PI_2, NO);
    CGPathAddArc(path, NULL, bounds.origin.x + bottomLeftRadius, bounds.origin.y + bounds.size.height - bottomLeftRadius, bottomLeftRadius, M_PI_2, M_PI, NO);
    CGPathAddArc(path, NULL, bounds.origin.x + topLeftRadius, bounds.origin.y + topLeftRadius, topLeftRadius, M_PI, 3 * M_PI_2, NO);
    CGPathRef pathCopy = CGPathCreateCopyByTransformingPath(path, transform);
    CGPathRelease(path);
    return pathCopy;
}
