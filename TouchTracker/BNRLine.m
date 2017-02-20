//
//  BNRLine.m
//  TouchTracker
//
//  Created by admin on 17/02/2017.
//  Copyright © 2017 in-tech. All rights reserved.
//

#import "BNRLine.h"

@implementation BNRLine

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.begin = [decoder decodeCGPointForKey:@"begin"];
        self.end = [decoder decodeCGPointForKey:@"end"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeCGPoint:self.begin forKey:@"begin"];
    [encoder encodeCGPoint:self.end forKey:@"end"];
}

@end
