//
//  XImage.h
//
//  Created by Tim Monroe on 11/26/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const NSString* kXImageDefaultImageName;


@interface XImage : UIImageView

// Usage Notes:
//   * 'imageName' parameter is optional (else pass in Nil).  If Nil, loads the DefaultImage
- (XImage *)initWithFrame:(CGRect)frame imageName:(NSString *)imageName;

// Usage Notes:
//   * 'imageName' parameter is optional (else pass in Nil).  If Nil, loads the DefaultImage
- (XImage *)initWithSuperView:(UIView *)superView imageName:(NSString *)imageName;

// Usage Notes:
//   * sets image name and loads the image into the XImage control
@property(nonatomic, readwrite) NSString* imageName;

@end