//
//  ViewController.h
//  Lec-5
//
//  Created by Abhi Patel on 2025-05-26.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UISegmentedControl *genderSegment;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UISwitch *subscribeSwitch;
@property (nonatomic, strong) UISlider *ratingSlider;
@property (nonatomic, strong) UITextView *commentView;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIPickerView *countryPicker;
@property (nonatomic, strong) NSArray<NSString *> *countries;
@property (nonatomic, strong) UILabel *selectedCountryLabel;

@property (nonatomic, strong) UIStepper *experienceStepper;
@property (nonatomic, strong) UILabel *experienceLabel;


@end


