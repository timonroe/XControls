//
//  CollectionViewController.m
//
//  Created by Tim Monroe on 11/22/13.
//  Copyright (c) 2013 Tim Monroe. All rights reserved.
//

#import "CollectionViewController.h"
#import "XLabelCVCell.h"
#import "XImageCVCell.h"
#import "XSwitchCVCell.h"
#import "XImageButtonCVCell.h"
#import "XStepperCVCell.h"
#import "XGolfScoreCVCell.h"
#import "XCheckedCVCell.h"


/////////////////////////////////////////////////////////////////////////////////
//
//  CollectionViewController class implementation
//
/////////////////////////////////////////////////////////////////////////////////

// Row info
const NSUInteger kRowCount = 10;
const NSUInteger kiPhoneRowHeight = 50;
const NSUInteger kiPadRowHeight = 100;
const NSUInteger kStepperRow = 5;

// Column info
const NSUInteger kColumnCount = 4;
const NSUInteger kStepperRowColumnCount = 3;

// Edge info
const NSUInteger kLeftEdgeInset = 5;
const NSUInteger kRightEdgeInset = 5;

// Const string variables
const NSString* kLabels = @"Labels";
const NSString* kHelloEnglish = @"Hello";
const NSString* kHelloJapanese = @"こんにちは";
const NSString* kHelloSpanish = @"Hola";

const NSString* kImages = @"Images";
const NSString* kYinYang = @"YinYang";
const NSString* kSmiley = @"Smiley";
const NSString* kOrangeSlice = @"OrangeSlice";

const NSString* kSwitch = @"Switch";
const NSString* kON = @"ON";
const NSString* kOFF = @"OFF";

const NSString* kCustomDrawing = @"Custom Drawing";

const NSString* kImageButtons = @"Image Buttons";
const NSString* kGreyButton = @"GreyButton";
const NSString* kBrickButton = @"BrickButton";
const NSString* kDefaultImageButtonsStatusMsg = @"Tap the btn";

const NSUInteger kImageButtonsRow = 4;
const NSUInteger kImageButtons_GreyButtonColumn = 1;
const NSUInteger kImageButtons_BrickButtonColumn = 2;

const NSString* kStepper = @"Stepper";

const NSString* kCheckedControl = @"Checked Control";
const NSString* kChecked = @"Checked";
const NSString* kUnchecked = @"Unchecked";

const NSUInteger kCheckedControlRow = 6;
const NSUInteger kCheckedControlColumn = 1;

//const NSString* kDetailDisclosure = @"Detail Disclosure";
//const NSString* kDetailDisclosureDefaultValue = @"<= ?";

@interface CollectionViewController ()
{
}

- (void)refreshRow:(NSUInteger)row column:(NSUInteger)column;
- (UICollectionViewCell *)collectionViewCellForXControl:(UIView *)control;
- (NSIndexPath *)indexPathForCell:(UICollectionViewCell *)cell;
- (NSIndexPath *)indexPathForXControl:(UIView *)control;
- (NSUInteger)rowForXControl:(UIView *)control;
- (NSUInteger)columnForXControl:(UIView *)control;

@end


@implementation CollectionViewController
{
@private
    UIColor* _white;
    UIColor* _black;
    UIColor* _gray;
    UIColor* _lightGray;
    UIColor* _red;
    UIColor* _darkGreen;
    UIColor* _darkBlue;
    UIColor* _blue;
    UIColor* _orange;
    NSDateFormatter* _dateFormatter;
    
    BOOL _switchIsOn;
    NSString* _imageButtonsStatusMsg;
    double _stepperValue;
    NSUInteger _detailDisclosureValue;
    BOOL _checkedControlIsChecked;
}

- (void)dealloc
{
    _white = Nil;
    _black = Nil;
    _gray = Nil;
    _lightGray = Nil;
    _red = Nil;
    _darkGreen = Nil;
    _darkBlue = Nil;
    _blue = Nil;
    _orange = Nil;
    _dateFormatter = Nil;
    
    _imageButtonsStatusMsg = Nil;
}


/*********************** Private CollectionViewController Properties/Methods ***********************/

- (void)refreshRow:(NSUInteger)row column:(NSUInteger)column
{
    // Force a reload of the cell
    UICollectionView* collectionView = self.collectionView;
    if (collectionView)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:column inSection:row];
        if (indexPath)
        {
            NSArray* array = [[NSArray alloc] initWithObjects:indexPath, nil];
            if (array)  [collectionView reloadItemsAtIndexPaths:array];
        }
    }
}

- (UICollectionViewCell *)collectionViewCellForXControl:(UIView *)control
{
    UIView* contentView = control.superview;
    UICollectionViewCell* cell = (UICollectionViewCell *)contentView.superview;
    return cell;
}

- (NSIndexPath *)indexPathForCell:(UICollectionViewCell *)cell
{
    UICollectionView* collectionView = self.collectionView;
    NSIndexPath* indexPath = [collectionView indexPathForCell:cell];
    return indexPath;
}

- (NSIndexPath *)indexPathForXControl:(UIView *)control
{
    UICollectionViewCell* cell = [self collectionViewCellForXControl:control];
    NSIndexPath* indexPath = [self indexPathForCell:cell];
    return indexPath;
}

- (NSUInteger)rowForXControl:(UIView *)control
{
    NSIndexPath* indexPath = [self indexPathForXControl:control];
    return indexPath.section;
}
- (NSUInteger)columnForXControl:(UIView *)control
{
    NSIndexPath* indexPath = [self indexPathForXControl:control];
    return indexPath.row;
}


/*********************** Overriding Public UIViewController Properties/Methods ***********************/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _white = [UIColor whiteColor];
    _black = [UIColor blackColor];
    _gray = [UIColor grayColor];
    _lightGray = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    _red = [UIColor redColor];
    _darkGreen = [[UIColor alloc] initWithRed:0.0 green:0.6 blue:0.0 alpha:1.0];
    _darkBlue = [[UIColor alloc] initWithRed:0.20 green:0.31 blue:0.52 alpha:1.0];
    _blue = [UIColor blueColor];
    _orange = [UIColor orangeColor];
    
    /*
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [_dateFormatter setDateStyle:NSDateFormatterNoStyle];
    */
    
    // Set the default values
    _switchIsOn = YES;
    _imageButtonsStatusMsg = [NSString stringWithString:(NSString*)kDefaultImageButtonsStatusMsg];
    _stepperValue = 1;
    _detailDisclosureValue = 0;
    _checkedControlIsChecked = YES;
    
    //self.title = @"Collection View Demo";
    
    UICollectionView* collectionView = self.collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = _white;
    collectionView.allowsSelection = NO;
    
    [collectionView registerClass:[XLabelCVCell class] forCellWithReuseIdentifier:@"XLabelCVCell"];
    [collectionView registerClass:[XImageCVCell class] forCellWithReuseIdentifier:@"XImageCVCell"];
    [collectionView registerClass:[XSwitchCVCell class] forCellWithReuseIdentifier:@"XSwitchCVCell"];
    [collectionView registerClass:[XImageButtonCVCell class] forCellWithReuseIdentifier:@"XImageButtonCVCell"];
    [collectionView registerClass:[XStepperCVCell class] forCellWithReuseIdentifier:@"XStepperCVCell"];
    [collectionView registerClass:[XGolfScoreCVCell class] forCellWithReuseIdentifier:@"XGolfScoreCVCell"];
    [collectionView registerClass:[XCheckedCVCell class] forCellWithReuseIdentifier:@"XCheckedCVCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*********************** Implement Public UICollectionViewDataSource Protocol Properties/Methods ***********************/

// This represents the number of Rows
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return kRowCount;
}

// Using Vertical (the default) for the Scroll Direction.  This represents the number of Columns
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)row
{
    // Note: the XStepper row only has 3 columns
    if (row == kStepperRow) return kStepperRowColumnCount;
    else return kColumnCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = Nil;
    NSUInteger row = indexPath.section;
    NSUInteger column = indexPath.row;
    
    // Labels
    if (row == 0)
    {
        XLabelCVCell* xLabelCVCell = Nil;
        XLabel* xLabel = Nil;
        if (column == 0)
        {
            xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kLabels;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_Small];
            xLabel.textColor = _black;
            xLabel.textAlignment = NSTextAlignmentLeft;
        }
        else if (column == 1)
        {
            xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kHelloEnglish;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_XLarge];
            xLabel.textColor = _red;
            xLabel.textAlignment = NSTextAlignmentCenter;
        }
        else if (column == 2)
        {
            xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kHelloSpanish;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_Medium];
            xLabel.textColor = _blue;
            xLabel.textAlignment = NSTextAlignmentCenter;
        }
        else
        {
            xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kHelloJapanese;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_XXXSmall];
            xLabel.textColor = _darkGreen;
            xLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell = xLabelCVCell;
    }
    // Images
    else if (row == 1)
    {
        if (column == 0)
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kImages;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_Small];
            xLabel.textColor = _black;
            xLabel.textAlignment = NSTextAlignmentLeft;
            cell = xLabelCVCell;
        }
        else
        {
            XImageCVCell* xImageCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XImageCVCell" forIndexPath:indexPath];
            XImage* xImage = xImageCVCell.xImage;
            if (column == 1) xImage.imageName = (NSString*)kYinYang;
            else if (column == 2) xImage.imageName = (NSString*)kSmiley;
            else xImage.imageName = (NSString*)kOrangeSlice;
            cell = xImageCVCell;
        }
    }
    // Switch
    else if (row == 2)
    {
        if (column == 0)
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kSwitch;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_Small];
            xLabel.textColor = _black;
            xLabel.textAlignment = NSTextAlignmentLeft;
            cell = xLabelCVCell;
        }
        else if (column == 1)
        {
            XSwitchCVCell* xSwitchCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XSwitchCVCell" forIndexPath:indexPath];
            XSwitch* xSwitch = xSwitchCVCell.xSwitch;
            xSwitch.delegate = self;
            xSwitch.on = _switchIsOn;
            cell = xSwitchCVCell;
        }
        else if (column == 2)
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = (_switchIsOn ? (NSString*)kON : (NSString*)kOFF);
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_Medium];
            xLabel.textColor = (_switchIsOn ? _darkGreen : _red);
            xLabel.textAlignment = NSTextAlignmentLeft;
            cell = xLabelCVCell;
        }
        else
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = Nil;
            cell = xLabelCVCell;
        }
    }
    // Score (Custom Drawing)
    else if (row == 3)
    {
        if (column == 0)
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kCustomDrawing;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_Small];
            xLabel.textColor = _black;
            xLabel.textAlignment = NSTextAlignmentLeft;
            xLabel.numberOfLines = 2;
            cell = xLabelCVCell;
        }
        else
        {
            XGolfScoreCVCell* xGolfScoreCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XGolfScoreCVCell" forIndexPath:indexPath];
            XGolfScore* xGolfScore = xGolfScoreCVCell.xGolfScore;
            xGolfScore.par = Par5;
            // Note: numbers based on a Par 5 hole (3 == Eagle, 4 == Birdie, 6 == Bogie)
            if (column == 1) xGolfScore.score = 3;
            else if (column == 2) xGolfScore.score = 4;
            else xGolfScore.score = 6;
            cell = xGolfScoreCVCell;
        }
    }
    // Image Buttons
    else if (row == kImageButtonsRow)
    {
        if (column == 0)
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kImageButtons;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_Small];
            xLabel.textColor = _black;
            xLabel.textAlignment = NSTextAlignmentLeft;
            xLabel.numberOfLines = 2;
            cell = xLabelCVCell;
        }
        else if (column == kImageButtons_GreyButtonColumn || column == kImageButtons_BrickButtonColumn)
        {
            XImageButtonCVCell* xImageButtonCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XImageButtonCVCell" forIndexPath:indexPath];
            XImageButton* xImageButton = xImageButtonCVCell.xImageButton;
            xImageButton.delegate = self;
            xImageButton.imageName = column == 1 ? (NSString*)kGreyButton : (NSString*)kBrickButton;
            
            // Size the control and center it in the cell
            CGRect cellBounds = xImageButtonCVCell.bounds;
            CGRect frame;
            frame.origin.x = 0;
            frame.origin.y = 0;
            frame.size.width = cellBounds.size.width < cellBounds.size.height ? cellBounds.size.width : cellBounds.size.height;
            frame.size.height = frame.size.width * .55;
            xImageButton.frame = frame;
            CGPoint center;
            center.x = cellBounds.size.width / 2;
            center.y = cellBounds.size.height / 2;
            xImageButton.center = center;
            
            cell = xImageButtonCVCell;
        }
        else
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = _imageButtonsStatusMsg;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_XXXSmall];
            xLabel.textColor = _black;
            xLabel.textAlignment = NSTextAlignmentCenter;
            cell = xLabelCVCell;
        }
    }
    // Stepper
    else if (row == kStepperRow)
    {
        if (column == 0)
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kStepper;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_Small];
            xLabel.textColor = _black;
            xLabel.textAlignment = NSTextAlignmentLeft;
            cell = xLabelCVCell;
        }
        else if (column == 1)
        {
            XStepperCVCell* xStepperCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XStepperCVCell" forIndexPath:indexPath];
            XStepper* xStepper = xStepperCVCell.xStepper;
            xStepper.delegate = self;
            cell = xStepperCVCell;
        }
        else if (column == 2)
        {
            XGolfScoreCVCell* xGolfScoreCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XGolfScoreCVCell" forIndexPath:indexPath];
            XGolfScore* xGolfScore = xGolfScoreCVCell.xGolfScore;
            xGolfScore.par = Par5;
            xGolfScore.score = _stepperValue;
            cell = xGolfScoreCVCell;
        }
    }
    // Checked Control
    else if (row == kCheckedControlRow)
    {
        if (column == 0)
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = (NSString*)kCheckedControl;
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_Small];
            xLabel.textColor = _black;
            xLabel.textAlignment = NSTextAlignmentLeft;
            xLabel.numberOfLines = 2;
            cell = xLabelCVCell;
        }
        else if (column == kCheckedControlColumn)
        {
            XCheckedCVCell* xCheckedCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XCheckedCVCell" forIndexPath:indexPath];
            XChecked* xChecked = xCheckedCVCell.xChecked;
            xChecked.delegate = self;
            // Change the checked/unchecked images to your own
            //xChecked.checkedImageName = @"???";
            //xChecked.uncheckedImageName = @"???";
            xChecked.checked = _checkedControlIsChecked;
            
            // Size the control and center it in the cell
            CGRect cellBounds = xCheckedCVCell.bounds;
            CGRect frame;
            frame.origin.x = 0;
            frame.origin.y = 0;
            frame.size.width = cellBounds.size.width < cellBounds.size.height ? cellBounds.size.width : cellBounds.size.height;
            frame.size.width = frame.size.width * .85;
            frame.size.height = frame.size.width;
            xChecked.frame = frame;
            CGPoint center;
            center.x = cellBounds.size.width / 2;
            center.y = cellBounds.size.height / 2;
            xChecked.center = center;
            
            cell = xCheckedCVCell;
        }
        else if (column == 2)
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = (_checkedControlIsChecked ? (NSString*)kChecked : (NSString*)kUnchecked);
            xLabel.font = [UIFont boldSystemFontOfSize:TextSize_XXSmall];
            xLabel.textColor = _black;
            xLabel.textAlignment = NSTextAlignmentLeft;
            cell = xLabelCVCell;
        }
        else
        {
            XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
            XLabel* xLabel = xLabelCVCell.xLabel;
            xLabel.text = Nil;
            cell = xLabelCVCell;
        }
    }
    
    else
    {
        XLabelCVCell* xLabelCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLabelCVCell" forIndexPath:indexPath];
        XLabel* xLabel = xLabelCVCell.xLabel;
        xLabel.text = Nil;
        cell = xLabelCVCell;
    }
    
    return cell;
}

/*
 - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 
 }
*/


/*********************** Implement Public UICollectionViewDelegateFlowLayout Protocol Properties/Methods ***********************/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.section;
    NSUInteger column = indexPath.row;
    
    CGRect bounds = collectionView.bounds;
    CGFloat width = 0.0;
    NSUInteger height = 0;  // use Unsigned Int here to prevent gaps in display between rows
    NSUInteger edgeInsets = kLeftEdgeInset + kRightEdgeInset;
    CGSize itemSize;
    width = (bounds.size.width - edgeInsets) / kColumnCount;
    // Note: the XStepper row only has 3 columns
    if (row == kStepperRow && column == 1) width = width * 2;
    itemSize.width = width;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) height = kiPhoneRowHeight;
    else height = kiPadRowHeight;
    
    itemSize.height = height;
    
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets;
    
    edgeInsets.left = kLeftEdgeInset;
    edgeInsets.right = kRightEdgeInset;
    edgeInsets.top = 0;
    edgeInsets.bottom = 0;
    
    return edgeInsets;
}

// Spacing between Rows
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

// Spacing between Columns
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize headerSize;
    
    headerSize.width = 0.0;
    headerSize.height = 0.0;
    
    return headerSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize footerSize;
    
    footerSize.width = 0.0;
    footerSize.height = 0.0;
    
    return footerSize;
}


/*********************** Implement Public UICollectionViewDelegate Protocol Properties/Methods ***********************/



/*********************** Implement Public XSwitchDelegate Protocol Properties/Methods ***********************/
#pragma mark - Public XSwitchDelegate Protocol Properties/Methods

- (void)xSwitch:(XSwitch *)xSwitch valueChanged:(BOOL)isOn
{
    _switchIsOn = isOn;
    
    NSUInteger row = [self rowForXControl:xSwitch];
    NSUInteger column = [self columnForXControl:xSwitch];
    
    // Force a reload of the cell that holds the Switch's value
    [self refreshRow:row column:column+1];
}


/*********************** Implement Public XStepperDelegate Protocol Properties/Methods ***********************/
#pragma mark - Public XStepperDelegate Protocol Properties/Methods

- (void)xStepper:(XStepper *)xStepper valueChanged:(double)value
{
    _stepperValue = value;
    //NSLog(@"Stepper Value:  %f", _stepperValue);
    
    NSUInteger row = [self rowForXControl:xStepper];
    NSUInteger column = [self columnForXControl:xStepper];
    
    // Force a reload of the cell that holds the Stepper's value
    [self refreshRow:row column:column+1];
}


/*********************** Implement Public XImageButtonDelegate Protocol Properties/Methods ***********************/
#pragma mark - Public XImageButtonDelegate Protocol Properties/Methods

- (void)xImageButtonTouchUpInside:(XImageButton *)xImageButton;
{
    NSUInteger row = [self rowForXControl:xImageButton];
    NSUInteger column = [self columnForXControl:xImageButton];
    
    // Check to see if the object is an XChecked control
    if ([xImageButton isKindOfClass:[XChecked class]])
    {
        // Safe to convert to XChecked object if needed
        //XChecked* xChecked = (XChecked*)xImageButton;
        
        if (row == kCheckedControlRow && column == kCheckedControlColumn)
        {
            // Toggle the state of the checked control
            _checkedControlIsChecked = _checkedControlIsChecked ? NO : YES;
            
            // Force a reload of the cell that holds the xChecked control
            [self refreshRow:row column:column];
            
            // Force a reload of the cell that holds the xChecked's state text
            [self refreshRow:row column:column+1];
        }
    }
    // It's an xImageButton object
    else
    {
        if (row == kImageButtonsRow)
        {
            if (column == kImageButtons_GreyButtonColumn)
            {
                _imageButtonsStatusMsg = [NSString stringWithString:(NSString*)kGreyButton];
                
                // Force a reload of the cell that holds the status message
                [self refreshRow:row column:column+2];
            }
            else if (column == kImageButtons_BrickButtonColumn)
            {
                _imageButtonsStatusMsg = [NSString stringWithString:(NSString*)kBrickButton];
                
                // Force a reload of the cell that holds the status message
                [self refreshRow:row column:column+1];
            }
        }
    }
}


/*********************** Implement Public cvDetailDisclosureCellDelegate Protocol Properties/Methods ***********************/
#pragma mark - Public cvDetailDisclosureCellDelegate Protocol Properties/Methods

/*
- (void)detailDisclosureBtnPressedForRow:(NSUInteger)row column:(NSUInteger)column
{
    _detailDisclosureValue += 1;
    
    // Force a reload of the cell that holds the DetailDisclosure's value
    [self refreshRow:row column:column+1];
}
*/


@end
