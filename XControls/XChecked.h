//
//  XChecked.h
//  XControls
//
//  Created by Tim Monroe on 12/8/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "XImageButton.h"

extern const NSString* kXCheckedDefaultCheckedImageName;
extern const NSString* kXCheckedDefaultUncheckedImageName;


@interface XChecked : XImageButton

// Usage Notes:
//   * 'checkedImageName' parameter is optional (else pass in Nil).  If Nil, loads the 'Checked' image
//   * 'uncheckedImageName' parameter is optional (else pass in Nil).  If Nil, loads the 'Unchecked' image
- (XImageButton *)initWithFrame:(CGRect)frame checkedImageName:(NSString *)checkedImageName uncheckedImageName:(NSString *)uncheckedImageName checked:(BOOL)checked;

// Usage Notes:
//   * 'checkedImageName' parameter is optional (else pass in Nil).  If Nil, loads the 'Checked' image
//   * 'uncheckedImageName' parameter is optional (else pass in Nil).  If Nil, loads the 'Unchecked' image
- (XImageButton *)initWithSuperView:(UIView *)superView checkedImageName:(NSString *)checkedImageName uncheckedImageName:(NSString *)uncheckedImageName checked:(BOOL)checked;

@property(nonatomic, readwrite) NSString* checkedImageName;
@property(nonatomic, readwrite) NSString* uncheckedImageName;
@property(nonatomic, readwrite) BOOL checked;

@end
