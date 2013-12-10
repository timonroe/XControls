//
//  XCheckedCVCell.m
//
//  Created by Tim Monroe on 12/8/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XCheckedCVCell.h"


/////////////////////////////////////////////////////////////////////////////////
//
//  XCheckedCVCell class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XCheckedCVCell class implementation
@interface XCheckedCVCell ()
{
}
@end

@implementation XCheckedCVCell
{
@private
    XChecked* _xChecked;
}

- (void)dealloc
{
    _xChecked = Nil;
}


/*********************** Overriding Public UIView Properties/Methods ***********************/

- (XCheckedCVCell *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        _xChecked = [[XChecked alloc] initWithSuperView:self.contentView checkedImageName:(NSString*)kXCheckedDefaultCheckedImageName uncheckedImageName:(NSString*)kXCheckedDefaultUncheckedImageName checked:YES];
        if (!_xChecked) return Nil;
    }
    
    return self;
}

// This method gets called when the cell is going to be reused
- (void)prepareForReuse
{
    [super prepareForReuse];
}


/*********************** Public XCheckedCVCell Properties/Methods ***********************/

- (XChecked *)_xChecked {return _xChecked;}

@end