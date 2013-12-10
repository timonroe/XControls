//
//  TableViewController.m
//
//  Created by Tim Monroe on 11/22/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "TableViewController.h"
#import "XUserRecordTVCell.h"
#import "XSwitch.h"
#import "pthread.h"     // Needed for pthread_rwlock_* methods


/////////////////////////////////////////////////////////////////////////////////
//
//   UserRecord class implementation
//
/////////////////////////////////////////////////////////////////////////////////

enum {
    UserStatus_Online = 1,
    UserStatus_Away = 2,
    UserStatus_Offline = 4
};
typedef NSUInteger UserStatus;

@interface UserRecord : NSObject
{
}

- (UserRecord *)initWithIdx:(NSUInteger)idx imageName:(NSString *)imageName name:(NSString *)name status:(UserStatus)status;

@property(nonatomic, readonly) NSUInteger idx;
@property(nonatomic, readwrite) NSString* imageName;
@property(nonatomic, readwrite) NSString* name;
@property(nonatomic, readwrite) UserStatus status;

@end


@implementation UserRecord
{
@private
    NSUInteger _idx;
    NSString* _imageName;
    NSString* _name;
    UserStatus _status;
}

- (void)dealloc
{
    _imageName = Nil;
    _name = Nil;
}


- (UserRecord *)initWithIdx:(NSUInteger)idx imageName:(NSString *)imageName name:(NSString *)name status:(UserStatus)status;
{
    //  Validate the input params
    if (!imageName || !name || (status != UserStatus_Online && status != UserStatus_Away && status != UserStatus_Offline)) return Nil;
    
    self = [super init];
    if (self)
    {
        _idx = idx;
        _imageName = [NSString stringWithString:imageName];
        _name = [NSString stringWithString:name];
        _status = status;
    }
    
    return self;
}

- (NSUInteger)idx {return _idx;}

- (NSString *)imageName {return _imageName;}
- (void)setImageName:(NSString *)imageName
{
    _imageName = Nil;
    _imageName = [NSString stringWithString:imageName];
}

- (NSString *)name {return _name;}
- (void)setName:(NSString *)name
{
    _name = Nil;
    _name = [NSString stringWithString:name];
}

- (UserStatus)status {return _status;}
- (void)setStatus:(UserStatus)status {_status = status;}

@end


/////////////////////////////////////////////////////////////////////////////////
//
//   UserRecords class implementation
//
/////////////////////////////////////////////////////////////////////////////////

// Use a bitmask so we can query user status values below
#define Online     1  // 2^0, bit 0
#define Away       2  // 2^1, bit 1
#define Offline    4  // 2^2, bit 2

typedef unsigned char UserStatusBitmask;

@interface UserRecords : NSObject
{
}

- (void)update;
- (NSArray *)fetchWithUserStatus:(UserStatusBitmask)flags;

@end


@implementation UserRecords
{
@private
    pthread_rwlock_t _rwLock;            // Used for locking the data
    NSMutableArray* _userRecords;
}

- (void)dealloc
{
    _userRecords = Nil;
    
    if (pthread_rwlock_destroy(&_rwLock) != 0)
    {
        // Unable to destroy the read/write lock.  This could happen if the lock is still in use
        // or the caller does not have the privilege to perform the operation.
    }
}

/*********************** Private UserRecords Properties/Methods ***********************/

//  Generate a random number between 0 and 9
- (NSUInteger)genRandomNumber
{
    NSUInteger bit0 = 1;
    NSUInteger bit1 = 2;
    NSUInteger bit2 = 4;
    NSUInteger bit3 = 8;
    
    unsigned char flags = bit0 | bit1 | bit2 | bit3;  // will generate values between 0 - 15
    NSUInteger number = rand() & flags;
    if (number > 9) number = 0;
    
    return number;
}

- (int)lockForReading
{
    return pthread_rwlock_rdlock(&_rwLock);
}

- (int)unlockForReading
{
    return pthread_rwlock_unlock(&_rwLock);
}

- (int)lockForUpdating
{
    return pthread_rwlock_wrlock(&_rwLock);
}

- (int)unlockForUpdating
{
    return pthread_rwlock_unlock(&_rwLock);
}


/*********************** Public UserRecords Properties/Methods ***********************/

- (UserRecords *)init
{
    self = [super init];
    if (self)
    {
        _userRecords = [[NSMutableArray alloc] initWithCapacity:1];
        if (!_userRecords) return Nil;

        // initialize read-write lock
        if (pthread_rwlock_init(&_rwLock, NULL) != 0)
        {
            // The lock could fail to initialize if:
            //   * The system lacked the necessary resources (other than memory) to initialize the lock.
            //   * Insufficient memory exists to initialize the lock.
            //   * The caller does not have sufficient privilege to perform the operation
            return Nil;
        }
        
        UserRecord* userRecord = Nil;
        
        userRecord = [[UserRecord alloc] initWithIdx:0 imageName:@"WayneGretzky" name:@"Wayne Gretzky" status:UserStatus_Away];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
        
        userRecord = [[UserRecord alloc] initWithIdx:1 imageName:@"LebronJames" name:@"Lebron James" status:UserStatus_Online];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
        
        userRecord = [[UserRecord alloc] initWithIdx:2 imageName:@"MichaelJordan" name:@"Michael Jordan" status:UserStatus_Away];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
        
        userRecord = [[UserRecord alloc] initWithIdx:3 imageName:@"PeytonManning" name:@"Peyton Manning" status:UserStatus_Online];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
        
        userRecord = [[UserRecord alloc] initWithIdx:4 imageName:@"JackNicklaus" name:@"Jack Nicklaus" status:UserStatus_Away];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
        
        userRecord = [[UserRecord alloc] initWithIdx:5 imageName:@"BobbyOrr" name:@"Bobby Orr" status:UserStatus_Away];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
        
        userRecord = [[UserRecord alloc] initWithIdx:6 imageName:@"DavidOrtiz" name:@"David Ortiz" status:UserStatus_Online];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
        
        userRecord = [[UserRecord alloc] initWithIdx:7 imageName:@"BabeRuth" name:@"Babe Ruth" status:UserStatus_Away];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
        
        userRecord = [[UserRecord alloc] initWithIdx:8 imageName:@"LawrenceTaylor" name:@"Lawrence Taylor" status:UserStatus_Away];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
        
        userRecord = [[UserRecord alloc] initWithIdx:9 imageName:@"TigerWoods" name:@"Tiger Woods" status:UserStatus_Online];
        if (!userRecord) return Nil;
        [_userRecords addObject:userRecord];
    }
    
    return self;
}


- (void)update
{
    [self lockForUpdating];
    
    // Generate a random number (between 0 and 9)
    NSUInteger idx = [self genRandomNumber];
    
    // Get the user record
    UserRecord* userRecord = _userRecords[idx];
    
    // Update its status
    UserStatus status = userRecord.status;
    if (status == UserStatus_Online) status = UserStatus_Away;
    else if (status == UserStatus_Away) status = UserStatus_Offline;
    else status = UserStatus_Online;
    
    userRecord.status = status;
    
    [self unlockForUpdating];
}

- (NSArray *)fetchWithUserStatus:(UserStatusBitmask)flags
{
    NSMutableArray* userRecords = Nil;
    
    [self lockForReading];
    
    userRecords = [[NSMutableArray alloc] initWithCapacity:1];
    if (userRecords)
    {
        UserRecord* userRecord = Nil;
        UserRecord* dupUserRecord = Nil;
        for (NSUInteger x = 0; x < _userRecords.count; x++)
        {
            userRecord = _userRecords[x];
            
            if ((flags & userRecord.status) == userRecord.status)
            {
                dupUserRecord = [[UserRecord alloc] initWithIdx:userRecord.idx imageName:userRecord.imageName name:userRecord.name status:userRecord.status];
                if (!dupUserRecord)
                {
                    userRecords = Nil;
                    break;
                }
                else
                {
                    [userRecords addObject:dupUserRecord];
                }
            }
        }
    }
    
    [self unlockForReading];
    
    return userRecords;
}

@end


/////////////////////////////////////////////////////////////////////////////////
//
//  TableViewController class implementation
//
/////////////////////////////////////////////////////////////////////////////////

const NSUInteger kSectionCount = 1;

const NSString* kStatusOnline = @"StatusOnline";
const NSString* kStatusAway = @"StatusAway";
const NSString* kStatusOffline = @"StatusOffline";

const NSTimeInterval kTimerInterval = 3;   // seconds

@interface TableViewController ()
{
}

- (void)updateTitleWithCurrentTime;
- (void)timerTarget:(NSTimer *)timer;

@end


@implementation TableViewController
{
@private
    UserRecords* _userRecords;
    NSArray* _userRecordsCache;
    BOOL _showOnlineUsersOnly;
    NSTimer* _repeatingTimer;
}

- (void)dealloc
{
    _userRecords = Nil;
    _userRecordsCache = Nil;
    
    // Note: cannot call 'invalidate' from this thread.  Must be called from the
    //       thread the Timer was created on.
    _repeatingTimer = Nil;
}


/*********************** Private TableViewController Properties/Methods ***********************/

- (void)updateTitleWithCurrentTime
{
    unsigned unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate* date = [NSDate date];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* dateComponents = [calendar components:unitFlags fromDate:date];
    NSString*  time = [NSString stringWithFormat:@"%.2lu:%.2lu:%.2lu", (unsigned long)dateComponents.hour, (unsigned long)dateComponents.minute, (unsigned long)dateComponents.second];
    self.title = time;
}

- (void)updateTableView
{
    UITableView* tableView = self.tableView;
    if (!tableView) return;
    [tableView reloadData];
}

- (void)updateUserRecordsCache
{
    UserStatusBitmask flags = 0;
    
    if (_showOnlineUsersOnly) flags = Online;
    else flags = Online | Away | Offline;
    
    _userRecordsCache = [_userRecords fetchWithUserStatus:flags];
}

- (void)updateUserRecords
{
    [_userRecords update];
}

// Simulate the UserRecords database being updated
- (void)timerTarget:(NSTimer *)timer
{
    //[self updateTitleWithCurrentTime];
    [self updateUserRecords];
    [self updateUserRecordsCache];
    [self updateTableView];
}


/*********************** Overriding Public UIViewController Properties/Methods ***********************/

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    // Note: the frame's height and width are ignored for the XSwitch control
    XSwitch* xSwitch = [[XSwitch alloc] initWithFrame:frame on:_showOnlineUsersOnly];
    xSwitch.delegate = self;
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:xSwitch];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    UITableView* tableView = self.tableView;
    [tableView registerClass:[XUserRecordTVCell class] forCellReuseIdentifier:@"XUserRecordTVCell"];
    
    // Create the UserRecords database
    _userRecords = [[UserRecords alloc] init];
    if (!_userRecords) return;
    
    // Init the show only users online flag
    _showOnlineUsersOnly = NO;
    
    // Update the UserRecords cache
    [self updateUserRecordsCache];
}

- (void)viewWillAppear:(BOOL)animated
{
    _repeatingTimer = [NSTimer scheduledTimerWithTimeInterval:kTimerInterval target:self selector:@selector(timerTarget:) userInfo:Nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (_repeatingTimer)
    {
        [_repeatingTimer invalidate];
        _repeatingTimer = Nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*********************** Implement Public UITableViewDataSource Protocol Properties/Methods ***********************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"Row Count: %lu", _userRecordsCache.count);
    return _userRecordsCache.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    
    // Fetch the UserRecord from the cache
    UserRecord* userRecord = _userRecordsCache[row];
    
    // Get a XUserRecordTVCell (note: my create or reuse an existing cell)
    XUserRecordTVCell* xUserRecordTVCell = [tableView dequeueReusableCellWithIdentifier:@"XUserRecordTVCell" forIndexPath:indexPath];
    
    // Important note: Must call setup After the cell object is dequeued
    //       The size of the cell (bounds/frame) isn't set (on the iPad) until after the dequeueReusable... call returns
    [xUserRecordTVCell setup];
   
    // Set the XUserRecordTVCell's user image
    xUserRecordTVCell.userImage.imageName = userRecord.imageName;
    
    // Set the XUserRecordTVCell's user name
    xUserRecordTVCell.userName.text = userRecord.name;
    
    // Set the XUserRecordTVCell's user status image
    NSString* userStatusImageName = Nil;
    if (userRecord.status == UserStatus_Online) userStatusImageName = (NSString*)kStatusOnline;
    else if (userRecord.status == UserStatus_Away) userStatusImageName = (NSString*)kStatusAway;
    else userStatusImageName = (NSString*)kStatusOffline;
    xUserRecordTVCell.userStatusImage.imageName = userStatusImageName;
    
    return xUserRecordTVCell;
}


/*********************** Implement Public XSwitchDelegate Protocol Properties/Methods ***********************/
#pragma mark - Public XSwitchDelegate Protocol Properties/Methods

- (void)xSwitch:(XSwitch *)xSwitch valueChanged:(BOOL)isOn
{
    // Set the show online users only flag
    _showOnlineUsersOnly = isOn;
    
    [self updateUserRecordsCache];
    [self updateTableView];
}


@end
