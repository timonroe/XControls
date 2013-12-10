//
//  XImageCVCell.m
//
//  Created by Tim Monroe on 11/27/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XImageCVCell.h"


/////////////////////////////////////////////////////////////////////////////////
//
//  XImageCVCell class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XImageCVCell class implementation
@interface XImageCVCell ()
{
}
@end

@implementation XImageCVCell
{
@private
    XImage* _xImage;
}

- (void)dealloc
{
    _xImage = Nil;
}


/*********************** Overriding Public UIView Properties/Methods ***********************/

- (XImageCVCell *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        _xImage = [[XImage alloc] initWithSuperView:self.contentView imageName:Nil];
        if (!_xImage) return Nil;
    }
    
    return self;
}

// This method gets called when the cell is going to be reused
- (void)prepareForReuse
{
    [super prepareForReuse];
}


/*********************** Public XImageCVCell Properties/Methods ***********************/

- (XImage *)xImage {return _xImage;}

@end



