//
//  BNRColorSwitcher.m
//  TouchTracker
//
//  Created by admin on 23/02/2017.
//  Copyright © 2017 in-tech. All rights reserved.
//

#import "BNRColorSwitcherView.h"

@interface BNRColorSwitcherView ()


@end

@implementation BNRColorSwitcherView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect bottomFrame = frame;
    bottomFrame.origin.y = frame.size.height - frame.size.height / 5;
    bottomFrame.size.height = frame.size.height / 5;
    
    
    self = [super initWithFrame:bottomFrame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // Create a UISegmentedControl
        NSArray *mySegments = [[NSArray alloc] initWithObjects:@"Red", @"Green", @"Blue", nil];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:mySegments];
        _segmentedControl.tintColor = [UIColor whiteColor];
        
        [self addSubview:_segmentedControl];
        
        _segmentedControl.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //
}

@end
