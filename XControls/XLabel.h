//
//  XLabel.h
//
//  Created by Tim Monroe on 11/26/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import <UIKit/UIKit.h>


enum {
    TextSize_XXXSmall = 12,
    TextSize_XXSmall = 14,
    TextSize_XSmall = 16,
    TextSize_Small = 17,
    TextSize_MediumSmall = 19,
    TextSize_Medium = 20,
    TextSize_Large = 23,
    TextSize_XLarge = 26
};
typedef NSUInteger TextSize;


@interface XLabel : UILabel

// Usage Notes:
//   * 'text' parameter is optional (else pass in Nil)
- (XLabel *)initWithFrame:(CGRect)frame text:(NSString *)text;

// Usage Notes:
//   * 'text' parameter is optional (else pass in Nil)
- (XLabel *)initWithSuperView:(UIView *)superView text:(NSString *)text;

@end
