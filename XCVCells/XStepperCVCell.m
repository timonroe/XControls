//
//  XStepperCVCell.m
//
//  Created by Tim Monroe on 11/27/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XStepperCVCell.h"


/////////////////////////////////////////////////////////////////////////////////
//
//  XStepperCVCell class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XStepperCVCell class implementation
@interface XStepperCVCell ()
{
}
@end

@implementation XStepperCVCell
{
@private
    XStepper* _xStepper;
}

- (void)dealloc
{
    _xStepper = Nil;
}


/*********************** Overriding Public UIView Properties/Methods ***********************/

- (XStepperCVCell *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        _xStepper = [[XStepper alloc] initWithSuperView:self.contentView minValue:kXStepperDefaultMinValue maxValue:kXStepperDefaultMaxValue value:kXStepperDefaultValue];
        if (!_xStepper) return Nil;
    }
    
    return self;
}

// This method gets called when the cell is going to be reused
- (void)prepareForReuse
{
    [super prepareForReuse];
}


/*********************** Public XStepperCVCell Properties/Methods ***********************/

- (XStepper *)xStepper {return _xStepper;}

@end

