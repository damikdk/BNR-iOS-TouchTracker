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

- (void)viewDidAppear:(BOOL)animated
{
    BNRDrawView *drawView = [[BNRDrawView alloc] initWithFrame:CGRectZero];

    NSData *linesData = [[NSUserDefaults standardUserDefaults] objectForKey:@"lines"];
    NSMutableArray *lines = [NSKeyedUnarchiver unarchiveObjectWithData:linesData];
    
    if (lines){
        drawView.finishedLines = lines;
    }
    
    self.view = drawView;
}

- (void)viewDidDisappear:(BOOL)animated
{
    BNRDrawView *drawView = (BNRDrawView *)self.view;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:drawView.finishedLines];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"lines"];
}

@end
