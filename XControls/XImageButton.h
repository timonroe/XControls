//
//  XImageButton.h
//  XControls
//
//  Created by Tim Monroe on 12/2/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XImageButton;

extern const NSString* kXImageButtonDefaultImageName;


@protocol XImageButtonDelegate <NSObject>

- (void)xImageButtonTouchUpInside:(XImageButton *)xImageButton;

@end


@interface XImageButton : UIButton

// Usage Notes:
//   * 'imageName' parameter is optional (else pass in Nil).  If Nil, loads the DefaultImage
- (XImageButton *)initWithFrame:(CGRect)frame imageName:(NSString *)imageName;

// Usage Notes:
//   * 'imageName' parameter is optional (else pass in Nil).  If Nil, loads the DefaultImage
- (XImageButton *)initWithSuperView:(UIView *)superView imageName:(NSString *)imageName;

@property(nonatomic, readwrite) NSString* imageName;

@property(nonatomic, assign) id<XImageButtonDelegate> delegate;

@end

/*
@protocol cvDetailDisclosureCellDelegate <NSObject>

- (void)detailDisclosureBtnPressedForRow:(NSUInteger)row column:(NSUInteger)column;

@end

@interface cvDetailDisclosureCell : UICollectionViewCell

@property(nonatomic, assign) id<cvDetailDisclosureCellDelegate> delegate;
@property(nonatomic, readwrite) NSUInteger row;
@property(nonatomic, readwrite) NSUInteger column;

@end


*/
