//
//  XImage.m
//
//  Created by Tim Monroe on 11/26/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XImage.h"

const NSString* kXImageDefaultImageName = @"DefaultImage";


////////////////////////////////////////////////////////////////////////////////
//
//  XImage class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XImage class implementation
@interface XImage ()
{
}

@end


@implementation XImage
{
@private
    NSString* _imageName;
}

- (void)dealloc
{
    _imageName = Nil;
}


/*********************** Private XImage Properties/Methods ***********************/

- (BOOL)loadImage:(NSString *)imageName
{
    if (!imageName) return NO;
    
    // See if the image is already loaded
    if ([_imageName compare:imageName] == NSOrderedSame) return YES;
    
    // Load the UIImage
    NSString* imagePath = [[NSBundle mainBundle] pathForResource:(NSString*)imageName ofType:@"png"];
    if (!imagePath) return NO;
    UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) return NO;
    
    // Load the new image into the XImage control
    self.image = image;
    
    // Set the image name
    _imageName = [NSString stringWithString:imageName];
    
    return YES;
}


/*********************** Public XImage Properties/Methods ***********************/

// Usage Notes:
//   * 'imageName' parameter is optional (else pass in Nil)
- (XImage *)initWithFrame:(CGRect)frame imageName:(NSString *)imageName;
{
    // If the caller didn't specify an image name, use the default
    if (!imageName) imageName = (NSString*)kXImageDefaultImageName;
    
    // Load the image
    NSString* imagePath = [[NSBundle mainBundle] pathForResource:(NSString*)imageName ofType:@"png"];
    if (!imagePath) return Nil;
    UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) return Nil;
    
    // Init the XImage with the UIImage object
    self = [super initWithImage:image];
    if (self)
    {
        // Scale the content to fit the size of the view by maintaining the aspect ratio.
        // Any remaining area of the view’s bounds is transparent.
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        // Set the XImage's frame rectangle
        // Describes the view’s location and size in its superview’s coordinate system.
        self.frame = frame;
        
        // If everything succeeds so far, set the image name
        _imageName = [NSString stringWithString:imageName];
    }
    
    return self;
}

// Usage Notes:
//   * 'imageName' parameter is optional (else pass in Nil)
- (XImage *)initWithSuperView:(UIView *)superView imageName:(NSString *)imageName
{
    if (!superView) return Nil;
    
    // Call the init method above
    if (![self initWithFrame:superView.bounds imageName:imageName]) return Nil;
        
    // Add the XImage as a subview to the superView
    [superView addSubview:self];
    
    return self;
}

- (NSString *)imageName {return _imageName;}

- (void)setImageName:(NSString *)imageName
{
    [self loadImage:imageName];
}

@end

