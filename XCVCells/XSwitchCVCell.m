//
//  XSwitchCVCell.m
//
//  Created by Tim Monroe on 11/27/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XSwitchCVCell.h"


/////////////////////////////////////////////////////////////////////////////////
//
//  XSwitchCVCell class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XSwitchCVCell class implementation
@interface XSwitchCVCell ()
{
}
@end

@implementation XSwitchCVCell
{
@private
    XSwitch* _xSwitch;
}

- (void)dealloc
{
    _xSwitch = Nil;
}


/*********************** Overriding Public UIView Properties/Methods ***********************/

- (XSwitchCVCell *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        _xSwitch = [[XSwitch alloc] initWithSuperView:self.contentView on:YES];
        if (!_xSwitch) return Nil;
    }
    
    return self;
}

// This method gets called when the cell is going to be reused
- (void)prepareForReuse
{
    [super prepareForReuse];
}


/*********************** Public XSwitchCVCell Properties/Methods ***********************/

- (XSwitch *)xSwitch {return _xSwitch;}

@end

