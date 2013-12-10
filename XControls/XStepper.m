//
//  XStepper.m
//
//  Created by Tim Monroe on 11/27/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XStepper.h"

const double kXStepperDefaultMinValue = 1;
const double kXStepperDefaultMaxValue = 10;
const double kXStepperDefaultValue = 1;


////////////////////////////////////////////////////////////////////////////////
//
//  XStepper class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XStepper class implementation
@interface XStepper ()
{
}

- (void)xStepperValueChanged:(id)sender;

@end


@implementation XStepper
{
@private
    id<XStepperDelegate> _delegate;
}

- (void)dealloc
{
    _delegate = Nil;
}


/*********************** Private XStepper Properties/Methods ***********************/

- (void)xStepperValueChanged:(id)sender
{
    // Call the delegate (if implemented)
    if (_delegate && [_delegate respondsToSelector:@selector(xStepper: valueChanged:)])
    {
        [_delegate xStepper:sender valueChanged:self.value];
    }
}


/*********************** Public XStepper Properties/Methods ***********************/

- (XStepper *)initWithFrame:(CGRect)frame minValue:(double)minValue maxValue:(double)maxValue value:(double)value
{
    // The size component of this rectangle is ignored.
    // UIStepper overrides initWithFrame: and enforces a size appropriate for the control.
    self = [super initWithFrame:frame];
    if (self)
    {
        // Add a target/action event for the ValueChanged event
        [self addTarget:self action:@selector(xStepperValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        // Set the default state of the XStepper
        self.minimumValue = minValue;
        self.maximumValue = maxValue;
        self.value = value;
    }
    
    return self;
}

- (XStepper *)initWithSuperView:(UIView *)superView minValue:(double)minValue maxValue:(double)maxValue value:(double)value
{
    if (!superView) return Nil;
    
    // Call the init method above
    if (![self initWithFrame:superView.bounds minValue:minValue maxValue:maxValue value:value]) return Nil;
            
    // Set the Switch's location (centered in the superView)
    CGSize size = superView.bounds.size;
    CGPoint center;
    center.x = size.width / 2;
    center.y = size.height / 2;
    // The center is specified within the coordinate system of its superview and is measured in points.
    // Setting this property changes the values of the frame properties accordingly.
    self.center = center;
        
    // Add the XStepper as a subview to the superView
    [superView addSubview:self];
    
    return self;
}

- (id<XStepperDelegate>)delegate {return _delegate;}
- (void)setDelegate:(id<XStepperDelegate>)delegate
{
    _delegate = Nil;
    _delegate = delegate;
}

@end