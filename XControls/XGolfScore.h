//
//  XGolfScore.h
//
//  Created by Tim Monroe on 11/27/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    Par3 = 3,
    Par4 = 4,
    Par5 = 5
};
typedef NSUInteger Par;
typedef NSUInteger Score;

extern const Par kDefaultPar;
extern const Score kDefaultScore;


@interface XGolfScore : UIView

- (XGolfScore *)initWithFrame:(CGRect)frame par:(Par)par score:(Score)score;

- (XGolfScore *)initWithSuperView:(UIView *)superView par:(Par)par score:(Score)score;

@property(nonatomic, readwrite) Par par;
@property(nonatomic, readwrite) Score score;

@end
