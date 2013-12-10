//
//  XUserRecordTVCell.m
//
//  Created by Tim Monroe on 12/3/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XUserRecordTVCell.h"


/////////////////////////////////////////////////////////////////////////////////
//
//  XUserRecordTVCell class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XUserRecordTVCell class implementation
@interface XUserRecordTVCell ()
{
}
@end

@implementation XUserRecordTVCell
{
@private
    BOOL _setup;
    XImage* _userImage;
    XLabel* _userName;
    XImage* _userStatusImage;
}

- (void)dealloc
{
    _userImage = Nil;
    _userName = Nil;
    _userStatusImage = Nil;
}


/*********************** Public UITableViewCell Properties/Methods ***********************/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _setup = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


/*********************** Public XUserRecordTVCell Properties/Methods ***********************/

- (BOOL)setup
{
    // Return if already setup
    if (_setup) return YES;
    
    // Get the bounds of the cell (used for sizing controls)
    CGRect cellBounds = self.bounds;
    
    // Build the frame for the userImage
    NSUInteger yPos = cellBounds.size.height * .10;
    NSUInteger height = cellBounds.size.height - (yPos * 2);
    NSUInteger width = height;
    CGRect frame;
    frame.origin.x = width / 2;
    frame.origin.y = yPos;
    frame.size.height = height;
    frame.size.width = width;
    
    // Create the userImage
    _userImage = [[XImage alloc] initWithFrame:frame imageName:Nil];
    if (!_userImage) return NO;
    [self.contentView addSubview:_userImage];             // Add as a subview to the cell's contentView
    
    // Create the user name
    _userName = [[XLabel alloc] initWithFrame:cellBounds text:Nil];
    if (!_userName) return NO;
    [self.contentView addSubview:_userName];             // Add as a subview to the cell's contentView
    _userName.textAlignment = NSTextAlignmentCenter;     // Center the user name in the middle of the cell
    
    // Build the frame for the userStatueImage
    yPos = cellBounds.size.height * .33;
    height = cellBounds.size.height - (yPos * 2);
    width = height;
    frame.origin.x = cellBounds.size.width - (width * 3);
    frame.origin.y = yPos;
    frame.size.height = height;
    frame.size.width = width;
    
    // Create the useStatusImage
    _userStatusImage = [[XImage alloc] initWithFrame:frame imageName:Nil];
    if (!_userStatusImage) return NO;
    [self.contentView addSubview:_userStatusImage];      // Add as a subview to the cell's contentView
    
    _setup = YES;
    
    return YES;
}

- (XImage *)userImage {return _userImage;}

- (XLabel *)userName {return _userName;}

- (XImage *)userStatusImage {return _userStatusImage;}

@end
