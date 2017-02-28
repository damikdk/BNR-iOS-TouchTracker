//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Copyright © 2017 in-tech. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"
#import "BNRColorSwitcherView.h"

@interface BNRDrawViewController ()

@property (nonatomic, strong) IBOutlet BNRColorSwitcherView *colorSwitcherView;

@end

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidAppear:(BOOL)animated
{
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(callColorSwitcher:)];
    
    [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [swipeRecognizer setNumberOfTouchesRequired:3];
    [self.view addGestureRecognizer:swipeRecognizer];
}


- (BNRColorSwitcherView *)callColorSwitcher:(UIPanGestureRecognizer *)gr
{
    if (!self.colorSwitcherView) {
        BNRColorSwitcherView *colorSwitcher = [[BNRColorSwitcherView alloc] initWithFrame:self.view.bounds];
        [colorSwitcher.segmentedControl  addTarget:self action:@selector(whichColor:) forControlEvents:UIControlEventValueChanged];
        self.colorSwitcherView = colorSwitcher;
        
        [self.view addSubview:colorSwitcher];
    } else {
        [self.view addSubview:self.colorSwitcherView];
    }
    
    return self.colorSwitcherView;
}

- (void)whichColor:(UISegmentedControl *)paramSender
{
    switch (paramSender.selectedSegmentIndex) {
        case 0:
            [(BNRDrawView *)self.view setColorOfLines:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
            break;
        case 1:
            [(BNRDrawView *)self.view setColorOfLines:[UIColor colorWithRed:0 green:1 blue:0 alpha:1]];
            break;
        case 2:
            [(BNRDrawView *)self.view setColorOfLines:[UIColor colorWithRed:0 green:0 blue:1 alpha:1]];
            break;
        default:
            break;
    }
    
}



@end
