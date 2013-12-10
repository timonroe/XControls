//
//  XLabel.m
//
//  Created by Tim Monroe on 11/26/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XLabel.h"


////////////////////////////////////////////////////////////////////////////////
//
//  XLabel class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XLabel class implementation
@interface XLabel ()
{
}
@end

@implementation XLabel
{
@private
}

- (void)dealloc
{
}


/*********************** Public XLabel Properties/Methods ***********************/

// Usage Notes:
//   * 'text' parameter is optional (else pass in Nil)
- (XLabel *)initWithFrame:(CGRect)frame text:(NSString *)text
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        /*
         // Default properties for the Label
         self.clearsContextBeforeDrawing = YES;   // Default value is YES
         self.userInteractionEnabled = YES;       // Default value is NO
         self.multipleTouchEnabled = NO;          // Default value is NO
         self.textColor = [UIColor blackColor];   // Default value is colorBlack
         self.textAlignment = NSTextAlignmentCenter;   // Default value is NSTextAlignmentLeft
         self.numberOfLines = 0;   // Use as many lines as needed to draw the text (Default value is 1)
         */
        
        // If the caller specifies the text
        if (text) self.text = text;
    }
    
    return self;
}

// Usage Notes:
//   * 'text' parameter is optional (else pass in Nil)
- (XLabel *)initWithSuperView:(UIView *)superView text:(NSString *)text
{
    if (!superView) return Nil;
    
    // Call the init method above
    if (![self initWithFrame:superView.bounds text:text]) return Nil;
        
    // Add the XLabel as a subview to the superView
    [superView addSubview:self];
    
    return self;
}

@end
