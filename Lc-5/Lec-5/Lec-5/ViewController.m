//
//  ViewController.m
//  Lec-5-Advanced
//
//  Created by Abhi Patel on 2025-05-26.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self setupUI];

    // Dismiss keyboard on tap
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)setupUI {
    CGFloat padding = 20;
    CGFloat width = self.view.bounds.size.width - 2 * padding;
    CGFloat y = 80;

    // Name Field
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(padding, y, width, 40)];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.placeholder = @"Enter your name";
    self.nameField.delegate = self;
    [self.view addSubview:self.nameField];
    y += 60;

    // Email Field
    self.emailField = [[UITextField alloc] initWithFrame:CGRectMake(padding, y, width, 40)];
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailField.placeholder = @"Enter your email";
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.delegate = self;
    [self.view addSubview:self.emailField];
    y += 60;

    // Gender Selection
    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, 150, 30)];
    genderLabel.text = @"Gender:";
    [self.view addSubview:genderLabel];

    self.genderSegment = [[UISegmentedControl alloc] initWithItems:@[@"Male", @"Female", @"Other"]];
    self.genderSegment.frame = CGRectMake(padding + 100, y, width - 100, 30);
    [self.view addSubview:self.genderSegment];
    y += 50;

    // Date Picker
    UILabel *dobLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 30)];
    dobLabel.text = @"Date of Birth:";
    [self.view addSubview:dobLabel];
    y += 30;

    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(padding, y, width, 100)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.datePicker];
    y += 110;

    // Subscribe Switch
    UILabel *subscribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width - 80, 30)];
    subscribeLabel.text = @"Subscribe to newsletter";
    [self.view addSubview:subscribeLabel];

    self.subscribeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, y, 0, 0)];
    [self.view addSubview:self.subscribeSwitch];
    y += 50;

    // Slider
    UILabel *sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 30)];
    sliderLabel.text = @"Rate our app:";
    [self.view addSubview:sliderLabel];
    y += 30;

    self.ratingSlider = [[UISlider alloc] initWithFrame:CGRectMake(padding, y, width, 30)];
    self.ratingSlider.minimumValue = 0;
    self.ratingSlider.maximumValue = 5;
    self.ratingSlider.value = 2.5;
    [self.view addSubview:self.ratingSlider];
    y += 50;

    // Comments TextView
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 30)];
    commentLabel.text = @"Comments:";
    [self.view addSubview:commentLabel];
    y += 30;

    self.commentView = [[UITextView alloc] initWithFrame:CGRectMake(padding, y, width, 80)];
    self.commentView.layer.borderColor = [UIColor systemGrayColor].CGColor;
    self.commentView.layer.borderWidth = 1.0;
    self.commentView.layer.cornerRadius = 8;
    self.commentView.delegate = self;
    [self.view addSubview:self.commentView];
    y += 100;
    
    // Country Picker Label
    UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 30)];
    countryLabel.text = @"Select Country:";
    [self.view addSubview:countryLabel];
    y += 30;

    // Country Picker
    self.countries = @[@"Canada", @"India", @"USA", @"UK", @"Germany"];
    self.countryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(padding, y, width, 100)];
    self.countryPicker.dataSource = self;
    self.countryPicker.delegate = self;
    [self.view addSubview:self.countryPicker];
    y += 100;

    // Display selected country
    self.selectedCountryLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 30)];
    self.selectedCountryLabel.text = @"Selected: None";
    [self.view addSubview:self.selectedCountryLabel];
    y += 40;

    // Stepper for experience
    UILabel *expTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 30)];
    expTitleLabel.text = @"Years of experience:";
    [self.view addSubview:expTitleLabel];
    y += 30;

    self.experienceStepper = [[UIStepper alloc] initWithFrame:CGRectMake(padding, y, 100, 30)];
    self.experienceStepper.minimumValue = 0;
    self.experienceStepper.maximumValue = 50;
    self.experienceStepper.value = 1;
    [self.experienceStepper addTarget:self action:@selector(stepperChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.experienceStepper];

    self.experienceLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding + 120, y, 150, 30)];
    self.experienceLabel.text = @"1 year";
    [self.view addSubview:self.experienceLabel];
    y += 50;

    // Submit Button
    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.submitButton.frame = CGRectMake(padding, y, width, 50);
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(handleSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitButton];
    y += 60;

    // Status Label
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 60)];
    self.statusLabel.textColor = [UIColor systemRedColor];
    self.statusLabel.numberOfLines = 3;
    [self.view addSubview:self.statusLabel];
}

- (void)stepperChanged:(UIStepper *)sender {
    NSInteger years = sender.value;
    NSString *yearText = (years == 1) ? @"1 year" : [NSString stringWithFormat:@"%ld years", (long)years];
    self.experienceLabel.text = yearText;
}

- (void)handleSubmit {
    NSString *name = self.nameField.text;
    NSString *email = self.emailField.text;
    NSString *comment = self.commentView.text;
    NSString *gender = [self.genderSegment titleForSegmentAtIndex:self.genderSegment.selectedSegmentIndex];

    if (name.length == 0 || email.length == 0 || gender.length == 0) {
        self.statusLabel.textColor = [UIColor systemRedColor];
        self.statusLabel.text = @"Please fill in all required fields.";
        return;
    }

    if (![email containsString:@"@"] || ![email containsString:@"."]) {
        self.statusLabel.textColor = [UIColor systemRedColor];
        self.statusLabel.text = @"Invalid email format.";
        return;
    }

    NSString *subscribeText = self.subscribeSwitch.isOn ? @"Subscribed to newsletter." : @"Not subscribed.";
    float rating = self.ratingSlider.value;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    NSString *dob = [df stringFromDate:self.datePicker.date];

    self.statusLabel.textColor = [UIColor systemGreenColor];
    self.statusLabel.text = [NSString stringWithFormat:@"Thanks, %@!\n%@\nDOB: %@\nRating: %.1f\n%@", name, subscribeText, dob, rating, comment];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate & UITextViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.countries.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.countries[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedCountryLabel.text = [NSString stringWithFormat:@"Selected: %@", self.countries[row]];
}

@end
