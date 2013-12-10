//
//  XSwitch.m
//
//  Created by Tim Monroe on 11/26/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XSwitch.h"


////////////////////////////////////////////////////////////////////////////////
//
//  XSwitch class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XSwitch class implementation
@interface XSwitch ()
{
}

- (void)xSwitchValueChanged:(id)sender;

@end


@implementation XSwitch
{
@private
    id<XSwitchDelegate> _delegate;
}

- (void)dealloc
{
    _delegate = Nil;
}


/*********************** Private XSwitch Properties/Methods ***********************/

- (void)xSwitchValueChanged:(id)sender
{
    // Call the delegate (if implemented)
    if (_delegate && [_delegate respondsToSelector:@selector(xSwitch: valueChanged:)])
    {
        [_delegate xSwitch:sender valueChanged:self.on];
    }
}


/*********************** Public XSwitch Properties/Methods ***********************/

- (XSwitch *)initWithFrame:(CGRect)frame on:(BOOL)on
{
    // The size component of this rectangle is ignored.
    // UISwitch overrides initWithFrame: and enforces a size appropriate for the control.
    self = [super initWithFrame:frame];
    if (self)
    {
        // Add a target/action event for the ValueChanged event
        [self addTarget:self action:@selector(xSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        // Set the default state of the XSwitch
        self.on = on;
    }
    
    return self;
}

- (XSwitch *)initWithSuperView:(UIView *)superView on:(BOOL)on
{
    if (!superView) return Nil;
    
    // Call the init method above
    if (![self initWithFrame:superView.bounds on:on]) return Nil;
    
    // Set the Switch's location (centered in the superView)
    CGSize size = superView.bounds.size;
    CGPoint center;
    center.x = size.width / 2;
    center.y = size.height / 2;
    // The center is specified within the coordinate system of its superview and is measured in points.
    // Setting this property changes the values of the frame properties accordingly.
    self.center = center;
        
    // Add the XSwitch as a subview to the superView
    [superView addSubview:self];
    
    return self;
}

- (id<XSwitchDelegate>)delegate {return _delegate;}
- (void)setDelegate:(id<XSwitchDelegate>)delegate
{
    _delegate = Nil;
    _delegate = delegate;
}

@end
