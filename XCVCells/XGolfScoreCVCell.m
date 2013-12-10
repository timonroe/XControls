//
//  XGolfScoreCVCell.m
//
//  Created by Tim Monroe on 11/27/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XGolfScoreCVCell.h"


/////////////////////////////////////////////////////////////////////////////////
//
//  XGolfScoreCVCell class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XGolfScoreCVCell class implementation
@interface XGolfScoreCVCell ()
{
}
@end

@implementation XGolfScoreCVCell
{
@private
    XGolfScore* _xGolfScore;
}

- (void)dealloc
{
    _xGolfScore = Nil;
}


/*********************** Overriding Public UIView Properties/Methods ***********************/

- (XGolfScoreCVCell *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        _xGolfScore = [[XGolfScore alloc] initWithSuperView:self.contentView par:kDefaultPar score:kDefaultScore];
        if (!_xGolfScore) return Nil;
    }
    
    return self;
}

// This method gets called when the cell is going to be reused
- (void)prepareForReuse
{
    [super prepareForReuse];
}


/*********************** Public XGolfScoreCVCell Properties/Methods ***********************/

- (XGolfScore *)xGolfScore {return _xGolfScore;}

@end


