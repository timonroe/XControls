//
//  TableViewController.h
//
//  Created by Tim Monroe on 11/22/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSwitch.h"    // Needed for protocol definitions


@interface TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, XSwitchDelegate>

@end
