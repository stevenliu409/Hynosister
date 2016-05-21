//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Steven Liu on 2016-05-19.
//  Copyright © 2016 Steven Liu. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGRect bounds = self.bounds;
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    float maxRadius = hypotf(bounds.size.width, bounds.size.height)/2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        
        
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)]; // lift pencil off and reposition
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0
                      endAngle:M_PI * 2
                     clockwise:YES]; // create the circle to be drawn in
    }
    
    path.lineWidth = 10.0; // set the stroke width
    
    [[UIColor lightGrayColor] setStroke]; // set the color of stroke
    
    [path stroke]; // draw the circle
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext(); //grab the current graphics context
    
    UIImage *logoImage = [UIImage imageNamed:@"BNRLogo"];
    
    CGPoint startPoint = CGPointMake(center.x,
                                     center.y-(logoImage.size.height/2) - 20);
    
    CGPoint endPoint = CGPointMake(center.x-(logoImage.size.width/2),
                                   center.y-(logoImage.size.height/2) + logoImage.size.height);
    
    CGPoint thirdPoint = CGPointMake(center.x-(logoImage.size.width/2) + logoImage.size.width,
                                     center.y-(logoImage.size.height/2) + logoImage.size.height);

    CGContextSaveGState(currentContext); // need to save the state before creating a gradient
    
    UIBezierPath *triangle = [self createBezierTrianglePathWithPoints:startPoint p2:endPoint p3:thirdPoint];

    [triangle addClip];
    
    [self drawGradientWithContext:currentContext startPoint:startPoint endPoint:endPoint];

    CGContextRestoreGState(currentContext); // turn off Core Graphics draw methods

    CGContextSaveGState(currentContext); // need to save the state before creating a shadow
    
    CGRect logoFrame = CGRectMake(center.x-(logoImage.size.width/2),
               center.y-(logoImage.size.height/2) - 20,
               logoImage.size.width,
               logoImage.size.height);
    
    [self drawShadowWithContext:currentContext onImage:logoImage withFrame:logoFrame];

    CGContextRestoreGState(currentContext); // turn off Core Graphics draw methods
}

- (void)drawShadowWithContext:(CGContextRef)currentContext
                      onImage:(UIImage *)image
                     withFrame:(CGRect)frame {
    
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 1); // create the shadow
    
    // draw the elements, will appear with the shadow
    [image drawInRect:frame];
}

- (void)drawGradientWithContext:(CGContextRef)currentContext startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {0.0, 1.0, 0.0, 1.0, //start color = green (RGBA)
        1.0, 1.0, 0.0, 1.0}; // end color = yellow
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    // create the gradient
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    // draw the gradient
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    // need to manually release these as per documentation
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
}

- (UIBezierPath *)createBezierTrianglePathWithPoints:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 {
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    
    [trianglePath moveToPoint:p1];
    [trianglePath addLineToPoint:p2];
    [trianglePath addLineToPoint:p3];
    [trianglePath closePath];
    
    return trianglePath;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
