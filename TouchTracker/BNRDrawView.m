//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by admin on 17/02/2017.
//  Copyright © 2017 in-tech. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView ()

@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@property (nonatomic, strong) NSMutableArray *circlesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedCircles;

@property (nonatomic) Boolean isCircleDrawing;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        
        self.circlesInProgress = [[NSMutableArray alloc] init];
        self.finishedCircles = [[NSMutableArray alloc] init];

        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        self.isCircleDrawing = NO;
    }
    
    return self;
}

- (void)strokeLine:(BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)strokeCircle:(BNRLine *)circle
{
    CGFloat circleX = 0;
    CGFloat circleY = 0;
    CGFloat circleWidth = 0;
    CGFloat circleHeight = 0;
    
    CGPoint location1 = circle.begin;
    CGPoint location2 = circle.end;
    
    circleX = MIN(location1.x, location2.x);
    circleY = MIN(location1.y, location2.y);
    circleHeight = fabs(location1.y - location2.y);
    circleWidth = fabs(location1.x - location2.x);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(circleX, circleY, circleWidth, circleHeight)];
    path.lineWidth = 7;
    
    [path stroke];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    
    [[UIColor blackColor] set];
    for (BNRLine *circle in self.finishedCircles) {
        [self strokeCircle:circle];
    }
    
    [[UIColor redColor] set];
    for (BNRLine *circle in self.circlesInProgress) {
        [self strokeCircle:circle];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    
    if (touches.count == 2) {
        self.isCircleDrawing = YES;
        NSArray *allTouches = [touches allObjects];
        
        BNRLine *circle = [[BNRLine alloc] init];
        circle.begin = [allTouches[0] locationInView:self];
        circle.end = [allTouches[1] locationInView:self];
        
        [self.circlesInProgress addObject:circle];
    } else {
        for (UITouch *t in touches) {
            self.isCircleDrawing = NO;
            CGPoint location = [t locationInView:self];
            
            BNRLine *line = [[BNRLine alloc] init];
            line.begin = location;
            line.end = location;
            
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            self.linesInProgress[key] = line;
        }
    }
  
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");

    if (self.isCircleDrawing && touches.count == 2) {
        NSArray *allTouches = [touches allObjects];
        BNRLine *circle = self.circlesInProgress[0];

        circle.begin = [allTouches[0] locationInView:self];
        circle.end = [allTouches[1] locationInView:self];
    }
    
    if (!self.isCircleDrawing && touches.count != 2) {
        for (UITouch *t in touches) {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            BNRLine *line = self.linesInProgress[key];
            
            line.end = [t locationInView:self];
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    
    if (!self.isCircleDrawing && self.linesInProgress.count) {
        for (UITouch *t in touches) {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            BNRLine *line = self.linesInProgress[key];
            
            [self.finishedLines addObject:line];
            [self.linesInProgress removeObjectForKey:key];
            [self.circlesInProgress removeAllObjects];
        }
    }

    if (self.isCircleDrawing) {
        BNRLine *circle = self.circlesInProgress[0];

        [self.finishedCircles addObject:circle];
        [self.circlesInProgress removeAllObjects];
        
        self.isCircleDrawing = NO;
    }
    self.isCircleDrawing = NO;
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    
    if (touches.count == 2) {
        if (self.circlesInProgress[0]) {
            BNRLine *circle = self.circlesInProgress[0];
            [self.circlesInProgress removeAllObjects];
            
            NSLog(@"%@", circle);
        }
    } else {
        for (UITouch *t in touches) {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            [self.linesInProgress removeObjectForKey:key];
        }
    }
    
    [self setNeedsDisplay];
}

@end
