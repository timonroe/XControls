//
//  XGolfScore.m
//
//  Created by Tim Monroe on 11/27/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XGolfScore.h"

enum {
    ScoreType_EagleOrBetter = 0,
    ScoreType_Birdie,
    ScoreType_Par,
    ScoreType_Bogie,
    ScoreType_DblBogieOrWorse
};
typedef NSUInteger ScoreType;

const Par kDefaultPar = Par4;
const Score kDefaultScore = 4;

const NSUInteger kPadding = 4;
const NSUInteger kLineWidth = 2;

const double kStartFontSearchSize = 0.5;
const double kMaxFontSearchSize = 100.0;


////////////////////////////////////////////////////////////////////////////////
//
//  XGolfScore class implementation
//
/////////////////////////////////////////////////////////////////////////////////
#pragma mark - XGolfScore class implementation
@interface XGolfScore ()
{
}

- (UIFont *)fontForText:(NSString *)text forSize:(CGSize)size textSize:(CGSize *)textSize;
- (CGSize)sizeFromRadius:(CGFloat)radius;
- (CGRect)innerRectFromRect:(CGRect)rect;
- (CGFloat)outerCircleRadiusFromRect:(CGRect)rect;
- (CGFloat)innerCircleRadiusFromRect:(CGRect)rect;
- (CGPoint)centerFromRect:(CGRect)rect;
- (CGRect)drawingAreaRectFromRect:(CGRect)rect;

@end

@implementation XGolfScore
{
@private
    Par _par;
    Score _score;
}

- (void)dealloc
{
}


/*********************** Private XGolfScore Properties/Methods ***********************/

- (UIFont *)fontForText:(NSString *)text forSize:(CGSize)size textSize:(CGSize *)textSize
{
    UIFont* font = [UIFont boldSystemFontOfSize:kStartFontSearchSize];
    UIFont* tempFont = Nil;
    CGSize tempSize;
    for (CGFloat fontSize = kStartFontSearchSize; fontSize < kMaxFontSearchSize; fontSize += kStartFontSearchSize)
    {
        tempFont = [UIFont boldSystemFontOfSize:fontSize];
        tempSize = [text sizeWithFont:tempFont];
        if (tempSize.height < size.height && tempSize.width < size.width)
        {
            font = tempFont;
            // If the caller wants the size of the text
            if (textSize) *textSize = tempSize;
        }
        else break;
    }
    
    return font;
}

- (CGSize)sizeFromRadius:(CGFloat)radius
{
    CGSize size;
    
    size.height = radius * 2.0;
    size.width = radius * 2.0;

    return size;
}

- (CGRect)innerRectFromRect:(CGRect)rect
{
    CGRect innerRect = CGRectInset(rect, kPadding, kPadding);
    return innerRect;
}

- (CGFloat)outerCircleRadiusFromRect:(CGRect)rect
{
    CGFloat height = CGRectGetHeight(rect);
    CGFloat width = CGRectGetWidth(rect);
    
    // Length is the shorter of the height or width
    CGFloat length = height < width ? height : width;
    
    return length / 2.0;
}

- (CGFloat)innerCircleRadiusFromRect:(CGRect)rect
{
    CGFloat outerCircleRadius = [self outerCircleRadiusFromRect:rect];
    CGFloat innerCircleRadius = outerCircleRadius -= kPadding;
    return innerCircleRadius;
}

- (CGPoint)centerFromRect:(CGRect)rect
{
    CGFloat height = CGRectGetHeight(rect);
    CGFloat width = CGRectGetWidth(rect);
    
    CGPoint center;
    center.x = rect.origin.x + (width / 2.0);
    center.y = rect.origin.y + (height / 2.0);
    
    return center;
}

- (CGRect)drawingAreaRectFromRect:(CGRect)rect
{
    CGRect drawingAreaRect;
    
    CGFloat height = CGRectGetHeight(rect);
    CGFloat width = CGRectGetWidth(rect);
    
    // Length is the shorter of the height or width
    CGFloat length = height < width ? height : width;
    
    // Reduce the size of the drawing area rect so there's space between the
    // Score Type Symbol (circle, square) and the bounds of the view
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) length = length * .90;
    else length = length * .90;
    
    // Calculate the center of the drawing area rect
    CGPoint center = [self centerFromRect:rect];
    
    // Calculate the origin of the drawing area rect
    CGPoint origin;
    origin.x = center.x - (length / 2.0);
    origin.y = center.y - (length / 2.0);
    
    // Build the drawing area rect
    drawingAreaRect.origin.x = origin.x;
    drawingAreaRect.origin.y = origin.y;
    drawingAreaRect.size.width = length;
    drawingAreaRect.size.height = length;
    
    return drawingAreaRect;
}


/*********************** Overriding Public UIView Properties/Methods ***********************/

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGColorSpaceRef RGB = CGColorSpaceCreateDeviceRGB();
    CGFloat cmpBlack[4] = {0.0, 0.0, 0.0, 1.0};
    CGColorRef clrBlack = CGColorCreate(RGB, cmpBlack);
    
    // Calculate the bounds of the drawing area
    CGRect drawingAreaRect = [self drawingAreaRectFromRect:rect];
    
    // Calculate the Score Type
    ScoreType scoreType;
    //  Par
    if (_score == _par) scoreType = ScoreType_Par;
    // Birdie or better
    else if (_score < _par)
    {
        if (_par - _score == 1) scoreType = ScoreType_Birdie;
        else scoreType = ScoreType_EagleOrBetter;
    }
    // Bogie or worse
    else
    {
        if (_score - _par == 1) scoreType = ScoreType_Bogie;
        else scoreType = ScoreType_DblBogieOrWorse;
    }
    
    // Draw the Score Type Symbol
    // Two Circles
    if (scoreType == ScoreType_EagleOrBetter)
    {
        // Outer Circle
        CGPoint center = [self centerFromRect:drawingAreaRect];
        CGFloat outerRadius = [self outerCircleRadiusFromRect:drawingAreaRect];
        CGContextAddArc(context, center.x, center.y, outerRadius, 0, 2*M_PI, 0);
        CGContextSetLineWidth(context, kLineWidth);
        CGContextSetStrokeColorWithColor(context, clrBlack);
        CGContextStrokePath(context);
        
        // Inner Circle
        CGFloat innerRadius = [self innerCircleRadiusFromRect:drawingAreaRect];
        CGContextAddArc(context, center.x, center.y, innerRadius, 0, 2*M_PI, 0);
        CGContextSetLineWidth(context, kLineWidth);
        CGContextSetStrokeColorWithColor(context, clrBlack);
        CGContextStrokePath(context);
    }
    // One Circle
    else if (scoreType == ScoreType_Birdie)
    {
        CGPoint center = [self centerFromRect:drawingAreaRect];
        CGFloat outerRadius = [self outerCircleRadiusFromRect:drawingAreaRect];
        CGContextAddArc(context, center.x, center.y, outerRadius, 0, 2*M_PI, 0);
        CGContextSetLineWidth(context, kLineWidth);
        CGContextSetStrokeColorWithColor(context, clrBlack);
        CGContextStrokePath(context);
    }
    // One Square
    else if (scoreType == ScoreType_Bogie)
    {
        CGContextAddRect(context, drawingAreaRect);
        CGContextSetLineWidth(context, kLineWidth);
        CGContextSetStrokeColorWithColor(context, clrBlack);
        CGContextStrokePath(context);
    }
    // Two Squares
    else if (scoreType == ScoreType_DblBogieOrWorse)
    {
        // Outer Square
        CGContextAddRect(context, drawingAreaRect);
        CGContextSetLineWidth(context, kLineWidth);
        CGContextSetStrokeColorWithColor(context, clrBlack);
        CGContextStrokePath(context);
        
        // Inner Square
        CGRect innerRect = [self innerRectFromRect:drawingAreaRect];
        CGContextAddRect(context, innerRect);
        CGContextSetLineWidth(context, kLineWidth);
        CGContextSetStrokeColorWithColor(context, clrBlack);
        CGContextStrokePath(context);
    }
    
    // Draw the Score
    NSString* text = [NSString stringWithFormat:@"%lu", (unsigned long)_score];
    
    CGFloat innerRadius = [self innerCircleRadiusFromRect:drawingAreaRect];
    CGSize scoreAreaSize = [self sizeFromRadius:innerRadius];
    CGSize textSize;
    UIFont* drawFont = [self fontForText:text forSize:scoreAreaSize textSize:&textSize];
    CGPoint center = [self centerFromRect:drawingAreaRect];
    CGPoint drawPoint;
    drawPoint.x = center.x - (textSize.width / 2.0);
    drawPoint.y = center.y - (textSize.height / 2.0);
    
    if (scoreType == ScoreType_Birdie || scoreType == ScoreType_EagleOrBetter) CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);     // Red
    else CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);     // Black
    
    [text drawAtPoint:drawPoint withFont:drawFont];

    if (clrBlack) CGColorRelease(clrBlack);
    if (RGB) CGColorSpaceRelease(RGB);
    
    UIGraphicsPopContext();
}


/*********************** Public XGolfScore Properties/Methods ***********************/

- (XGolfScore *)initWithFrame:(CGRect)frame par:(Par)par score:(Score)score
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Set the view's background to Transparent
        // Always set the value of this property to NO if the view is fully or partially transparent.
        self.opaque = NO;
        
        // Init the default values
        if (par != Par3 && par != Par4 && par != Par5) par = kDefaultPar;
        else _par = par;
        _score = score;
    }
    
    return self;
}

- (XGolfScore *)initWithSuperView:(UIView *)superView par:(Par)par score:(Score)score;
{
    if (!superView) return Nil;
    
    // Call the init method above
    if (![self initWithFrame:superView.bounds par:par score:score]) return Nil;
        
    // Add the XGolfScore as a subview to the superView
    [superView addSubview:self];
    
    return self;
}

- (Par)par {return _par;}
- (void)setPar:(Par)par
{
    if (par != Par3 && par != Par4 && par != Par5) return;
    else _par = par;
    
    // Need to force the view to redraw
    [self setNeedsDisplay];
}

- (Score)score {return _score;}
- (void)setScore:(Score)score
{
    _score = score;
    
    // Need to force the view to redraw
    [self setNeedsDisplay];
}

@end




