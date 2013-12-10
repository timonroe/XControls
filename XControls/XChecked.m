//
//  XChecked.m
//
//  Created by Tim Monroe on 12/8/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XChecked.h"

const NSString* kXCheckedDefaultCheckedImageName = @"Checked";
const NSString* kXCheckedDefaultUncheckedImageName = @"Unchecked";


////////////////////////////////////////////////////////////////////////////////
//
//  XChecked class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XChecked class implementation
@interface XChecked ()
{
}

- (void)initCheckedImageName:(NSString *)checkedImageName uncheckedImageName:(NSString *)uncheckedImageName checked:(BOOL)checked;

@end

@implementation XChecked
{
@private
    NSString* _checkedImageName;
    NSString* _uncheckedImageName;
    BOOL _checked;
}

- (void)dealloc
{
    _checkedImageName = Nil;
    _uncheckedImageName = Nil;
}


/*********************** Private XChecked Properties/Methods ***********************/

- (void)initCheckedImageName:(NSString *)checkedImageName uncheckedImageName:(NSString *)uncheckedImageName checked:(BOOL)checked
{
    // Set the checked image name
    self.checkedImageName = checkedImageName;
    
    // Set the unchecked image name
    self.uncheckedImageName = uncheckedImageName;
    
    // Set the checked state
    _checked = checked;
}


/*********************** Public XChecked Properties/Methods ***********************/

- (XImageButton *)initWithFrame:(CGRect)frame checkedImageName:(NSString *)checkedImageName uncheckedImageName:(NSString *)uncheckedImageName checked:(BOOL)checked
{
    // Validate and initialize the XChecked object's properties
    [self initCheckedImageName:checkedImageName uncheckedImageName:uncheckedImageName checked:checked];
    
    NSString* imageName = _checked ? _checkedImageName : _uncheckedImageName;
    self = [super initWithFrame:frame imageName:imageName];
    
    return self;
}

- (XImageButton *)initWithSuperView:(UIView *)superView checkedImageName:(NSString *)checkedImageName uncheckedImageName:(NSString *)uncheckedImageName checked:(BOOL)checked
{
    // Validate and initialize the XChecked object's properties
    [self initCheckedImageName:checkedImageName uncheckedImageName:uncheckedImageName checked:checked];
  
    NSString* imageName = _checked ? _checkedImageName : _uncheckedImageName;
    self = [super initWithSuperView:superView imageName:imageName];
    
    return self;
}

- (NSString *)checkedImageName {return _checkedImageName;}
- (void)setCheckedImageName:(NSString *)checkedImageName
{
    NSString* imagePath = Nil;
    UIImage* image = Nil;
    
    // If the caller didn't specify a checked image name, use the default
    if (!checkedImageName) checkedImageName = (NSString*)kXCheckedDefaultCheckedImageName;
    
    // Validate the checked image
    imagePath = [[NSBundle mainBundle] pathForResource:(NSString*)checkedImageName ofType:@"png"];
    if (!imagePath) return;
    image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) return;
    
    // If everything succeeds so far, set the checked image name
    _checkedImageName = [NSString stringWithString:checkedImageName];
}

- (NSString *)uncheckedImageName {return _uncheckedImageName;}
- (void)setUncheckedImageName:(NSString *)uncheckedImageName
{
    NSString* imagePath = Nil;
    UIImage* image = Nil;
    
    // If the caller didn't specify an unchecked image name, use the default
    if (!uncheckedImageName) uncheckedImageName = (NSString*)kXCheckedDefaultUncheckedImageName;
    
    // Validate the unchecked image
    imagePath = [[NSBundle mainBundle] pathForResource:(NSString*)uncheckedImageName ofType:@"png"];
    if (!imagePath) return;
    image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) return;
    
    // If everything succeeds so far, set the unchecked image name
    _uncheckedImageName = [NSString stringWithString:uncheckedImageName];
}

- (BOOL)checked {return _checked;}
- (void)setChecked:(BOOL)checked
{
    // Set the checked state
    _checked = checked;
    
    // Set the XImageButton's imageName (note: this loads and sets the image)
    self.imageName = _checked ? _checkedImageName : _uncheckedImageName;
}

@end
