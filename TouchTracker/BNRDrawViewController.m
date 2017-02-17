//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by admin on 17/02/2017.
//  Copyright © 2017 in-tech. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
