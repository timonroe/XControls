//
//  XImageButtonCVCell.m
//
//  Created by Tim Monroe on 12/6/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XImageButtonCVCell.h"


/////////////////////////////////////////////////////////////////////////////////
//
//  XImageButtonCVCell class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XImageButtonCVCell class implementation
@interface XImageButtonCVCell ()
{
}
@end

@implementation XImageButtonCVCell
{
@private
    XImageButton* _xImageButton;
}

- (void)dealloc
{
    _xImageButton = Nil;
}


/*********************** Overriding Public UIView Properties/Methods ***********************/

- (XImageButtonCVCell *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        _xImageButton = [[XImageButton alloc] initWithSuperView:self.contentView imageName:Nil];
        if (!_xImageButton) return Nil;
    }
    
    return self;
}

// This method gets called when the cell is going to be reused
- (void)prepareForReuse
{
    [super prepareForReuse];
}


/*********************** Public XImageButtonCVCell Properties/Methods ***********************/

- (XImageButton *)xImageButton {return _xImageButton;}

@end
