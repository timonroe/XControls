//
//  XStepper.h
//
//  Created by Tim Monroe on 11/27/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XStepper;

extern const double kXStepperDefaultMinValue;
extern const double kXStepperDefaultMaxValue;
extern const double kXStepperDefaultValue;


@protocol XStepperDelegate <NSObject>

- (void)xStepper:(XStepper *)xStepper valueChanged:(double)value;

@end


@interface XStepper : UIStepper

- (XStepper *)initWithFrame:(CGRect)frame minValue:(double)minValue maxValue:(double)maxValue value:(double)value;

- (XStepper *)initWithSuperView:(UIView *)superView minValue:(double)minValue maxValue:(double)maxValue value:(double)value;

@property(nonatomic, assign) id<XStepperDelegate> delegate;

@end