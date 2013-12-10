//
//  XUserRecordTVCell.h
//
//  Created by Tim Monroe on 12/3/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLabel.h"
#import "XImage.h"


@interface XUserRecordTVCell : UITableViewCell

- (BOOL)setup;

@property(nonatomic, readonly) XImage* userImage;
@property(nonatomic, readonly) XLabel* userName;
@property(nonatomic, readonly) XImage* userStatusImage;

@end
