//
//  XLabelCVCell.m
//
//  Created by Tim Monroe on 11/27/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XLabelCVCell.h"


/////////////////////////////////////////////////////////////////////////////////
//
//  XLabelCVCell class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XLabelCVCell class implementation
@interface XLabelCVCell ()
{
}
@end

@implementation XLabelCVCell
{
@private
    XLabel* _xLabel;
}

- (void)dealloc
{
   _xLabel = Nil;
}


/*********************** Overriding Public UIView Properties/Methods ***********************/

- (XLabelCVCell *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        _xLabel = [[XLabel alloc] initWithSuperView:self.contentView text:Nil];
        if (!_xLabel) return Nil;
    }
    
    return self;
}

// This method gets called when the cell is going to be reused
- (void)prepareForReuse
{
    [super prepareForReuse];
}


/*********************** Public XLabelCVCell Properties/Methods ***********************/

- (XLabel *)xLabel {return _xLabel;}

@end

