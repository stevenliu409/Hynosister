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
    
    UIImage *logoImage = [UIImage imageNamed:@"BNRLogo"];
    
    [logoImage drawInRect:CGRectMake(center.x-(logoImage.size.width/2),
                                     center.y-(logoImage.size.height/2) - 20,
                                     logoImage.size.width,
                                     logoImage.size.height)];

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
