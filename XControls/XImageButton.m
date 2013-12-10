//
//  XImageButton.m
//  XControls
//
//  Created by Tim Monroe on 12/2/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XImageButton.h"

const NSString* kXImageButtonDefaultImageName = @"DefaultImage";


////////////////////////////////////////////////////////////////////////////////
//
//  XImageButton class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XImageButton class implementation
@interface XImageButton ()
{
}

@end

@implementation XImageButton
{
@private
    NSString* _imageName;
    id<XImageButtonDelegate> _delegate;
}

- (void)dealloc
{
    _imageName = Nil;
    _delegate = Nil;
}


/*********************** Private XImageButton Properties/Methods ***********************/

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
    
    // Load the new image into the XImageButton control
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
    // Set the image name
    _imageName = [NSString stringWithString:imageName];
    
    return YES;
}

- (void)xImageButtonTouchUpInside:(id)sender
{
    // Call the delegate (if implemented)
    if (_delegate && [_delegate respondsToSelector:@selector(xImageButtonTouchUpInside:)])
    {
        [_delegate xImageButtonTouchUpInside:sender];
    }
}

/*********************** Public XImageButton Properties/Methods ***********************/

// Usage Notes:
//   * 'imageName' parameter is optional (else pass in Nil)
- (XImageButton *)initWithFrame:(CGRect)frame imageName:(NSString *)imageName;
{
    // If the caller didn't specify an image name, use the default
    if (!imageName) imageName = (NSString*)kXImageButtonDefaultImageName;
    
    // Load the image
    NSString* imagePath = [[NSBundle mainBundle] pathForResource:(NSString*)imageName ofType:@"png"];
    if (!imagePath) return Nil;
    UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) return Nil;
    
    // Init the XImageButton with the frame
    self = [super initWithFrame:frame];
    if (self)
    {
        // Load the image into the XImageButton control
        [self setBackgroundImage:image forState:UIControlStateNormal];
        
        // If everything succeeds so far, set the image name
        _imageName = [NSString stringWithString:imageName];
        
        /*
         [self setTitle:text forState:UIControlStateNormal];
         [self setTitleColor:color forState:UIControlStateNormal];
         self.titleLabel.font = font;
         */
        
        [self addTarget:self action:@selector(xImageButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

// Usage Notes:
//   * 'imageName' parameter is optional (else pass in Nil)
- (XImageButton *)initWithSuperView:(UIView *)superView imageName:(NSString *)imageName
{
    if (!superView) return Nil;
    
    // Call the init method above
    if (![self initWithFrame:superView.bounds imageName:imageName]) return Nil;
    
    // Add the XImageButton as a subview to the superView
    [superView addSubview:self];
    
    return self;
}

- (NSString *)imageName {return _imageName;}
- (void)setImageName:(NSString *)imageName
{
    [self loadImage:imageName];
}

- (id<XImageButtonDelegate>)delegate {return _delegate;}
- (void)setDelegate:(id<XImageButtonDelegate>)delegate
{
    _delegate = Nil;
    _delegate = delegate;
}

@end


/*
////////////////////////////////////////////////////////////////////////////////
//
//  cvDetailDisclosureCell class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - cvDetailDisclosureCell class implementation
@interface cvDetailDisclosureCell ()
{
}

@end


@implementation cvDetailDisclosureCell
{
@private
    UIButton* _detailDisclosureBtn;
    id<cvDetailDisclosureCellDelegate> _delegate;
    NSUInteger _row;
    NSUInteger _column;
}

- (void)dealloc
{
    if (_detailDisclosureBtn)
    {
        [_detailDisclosureBtn removeFromSuperview];
        _detailDisclosureBtn = Nil;
    }
    _delegate = Nil;
}



- (void)detailDisclosureBtnPressed:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(detailDisclosureBtnPressedForRow: column:)])
    {
        [_delegate detailDisclosureBtnPressedForRow:_row column:_column];
    }
}




- (cvDetailDisclosureCell *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        // Create the DetailDisclosureBtn
        _detailDisclosureBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        if (!_detailDisclosureBtn) return Nil;
        
        // Add a target/action event for the TouchDown event
        [_detailDisclosureBtn addTarget:self action:@selector(detailDisclosureBtnPressed:) forControlEvents:UIControlEventTouchDown];
        
        // Set the DetailDisclosureBtn's location (centered)
        rect.origin.x = 0;
        rect.origin.y = 0;
        
        // Set the DetailDisclusureBtn's frame rectangle to that of the Cell's
        // Describes the view’s location and size in its superview’s coordinate system.
        _detailDisclosureBtn.frame = rect;
        
        // Add the DetailDisclosureBtn as a subview for the Cell
        [self.contentView addSubview:_detailDisclosureBtn];
        
        // Init the rest of the DetailDisclosureCell's properties
        _delegate = Nil;
        _row = 0;
        _column = 0;
    }
    
    return self;
}




- (id<cvDetailDisclosureCellDelegate>)delegate {return _delegate;}
- (void)setDelegate:(id<cvDetailDisclosureCellDelegate>)delegate
{
    _delegate = Nil;
    _delegate = delegate;
}

- (NSUInteger)row {return _row;}
- (void)setRow:(NSUInteger)row {_row = row;}

- (NSUInteger)column {return _column;}
- (void)setColumn:(NSUInteger)column {_column = column;}

@end
 
*/

