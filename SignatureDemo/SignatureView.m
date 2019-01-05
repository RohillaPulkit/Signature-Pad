//
//  SignatureView.m
//  SignatureDemo
//
//  Created by Pulkit Rohilla on 13/09/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import "SignatureView.h"

@implementation SignatureView
{
    NSMutableArray *pathArray;
    UIBezierPath *currentPath;
}

-(void)awakeFromNib{

    pathArray = [NSMutableArray new];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    
    for (UIBezierPath *_path in pathArray) {
        
        _path.lineCapStyle = kCGLineCapRound;
        _path.lineJoinStyle = kCGLineJoinRound;
        _path.lineWidth = 1.5f;
        
        [_path stroke];
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, currentPoint)) {
        
        UIBezierPath *path = [UIBezierPath new];  //locally created
        
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinMiter;
        path.lineWidth = 1.5f;
        
        [path moveToPoint:currentPoint];
        
        [path addLineToPoint:CGPointMake(currentPoint.x, currentPoint.y)];
        
        [self setNeedsDisplay];
        
        currentPath = path;
        
        [pathArray addObject:currentPath];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    NSLog(@"Current point (%f,%f)",currentPoint.x, currentPoint.y);

    if (CGRectContainsPoint(self.bounds, currentPoint)) {
        
        NSLog(@"Draw point (%f,%f)",currentPoint.x, currentPoint.y);

        [currentPath addLineToPoint:currentPoint];
        
        [self setNeedsDisplay];
    }
    else
    {
        currentPath = nil;
    }
}


@end
