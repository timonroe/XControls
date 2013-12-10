//
//  XSwitch.h
//
//  Created by Tim Monroe on 11/26/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSwitch;


@protocol XSwitchDelegate <NSObject>

- (void)xSwitch:(XSwitch *)xSwitch valueChanged:(BOOL)isOn;

@end


@interface XSwitch : UISwitch

- (XSwitch *)initWithFrame:(CGRect)frame on:(BOOL)on;

- (XSwitch *)initWithSuperView:(UIView *)superView on:(BOOL)on;

@property(nonatomic, assign) id<XSwitchDelegate> delegate;

@end



