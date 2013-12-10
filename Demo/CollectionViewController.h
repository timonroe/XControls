//
//  CollectionViewController.h
//
//  Created by Tim Monroe on 11/22/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSwitch.h"       // Needed for protocol definitions
#import "XStepper.h"      // Needed for protocol definitions
#import "XImageButton.h"  // Needed for protocol definitions


@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, XSwitchDelegate, XStepperDelegate, XImageButtonDelegate>

@end
