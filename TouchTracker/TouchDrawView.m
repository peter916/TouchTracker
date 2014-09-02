//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by peter on 14-9-2.
//  Copyright (c) 2014年 org.peter. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@implementation TouchDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    NSLog(@"initWithCoder");
    if (self) {
        linesInProcess = [[NSMutableDictionary alloc] init];
        completeLines = [[NSMutableArray alloc] init];
        
        [self setMultipleTouchEnabled:YES];
    }
    
    return self;
}


-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    [[UIColor blackColor] set];
    for (Line* line in completeLines) {
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
    
    [[UIColor redColor] set];
    for (NSValue* v in linesInProcess) {
        Line* line = [linesInProcess objectForKey:v];
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches) {
        
        if ( [t tapCount] > 1 ) {
            [self clearAll];
            return;
        }
        
        NSValue* key = [NSValue valueWithPointer:(__bridge const void *)(t)];
        
        CGPoint loc = [t locationInView:self];
        Line* newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        
        [linesInProcess setObject:newLine forKey:key];
        
        
    }
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches) {
        NSValue* key = [NSValue valueWithPointer:(__bridge const void *)(t)];
        
        Line* line = [linesInProcess objectForKey:key];
        
        CGPoint loc = [t locationInView:self];
        [line setEnd:loc];
    }
    
    [self setNeedsDisplay];
}


-(void)endTouches:(NSSet *)touches
{
    
    for (UITouch* t in touches) {
        NSValue* key = [NSValue valueWithPointer:(__bridge const void *)(t)];
        Line* line = [linesInProcess objectForKeyedSubscript:key];
        if (line){
            [completeLines addObject:line];
            [linesInProcess removeObjectForKey:key];
        }
    }
    
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



-(void)clearAll
{
    [linesInProcess removeAllObjects];
    [completeLines removeAllObjects];
    
    [self setNeedsDisplay];
}
@end
