//
//  ViewController.m
//  Lec-5
//
//  Created by Abhi Patel on 2025-05-26.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self setupUI];
}

- (void) setupUI {
    CGFloat padding = 20;
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(padding, 100, self.view.bounds.size.width - 2*padding, 40)];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.placeholder = @"Enter your name!";
    self.nameField.enabled = YES;
    self.nameField.userInteractionEnabled = YES;
    [self.view addSubview:self.nameField];

    self.emailField = [[UITextField alloc] initWithFrame:CGRectMake(padding, 160, self.view.bounds.size.width - 2*padding, 40)];
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailField.placeholder = @"Enter your email";
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.enabled = YES;
    self.emailField.userInteractionEnabled = YES;
    [self.view addSubview:self.emailField];
    
    UILabel *subscribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 220, 200, 30)];
        subscribeLabel.text = @"Subscribe to newsletter";
    [self.view addSubview:subscribeLabel];

    self.subscribeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 220, 0, 0)];
    [self.view addSubview:self.subscribeSwitch];

    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.submitButton.frame = CGRectMake(padding, 280, self.view.bounds.size.width - 2*padding, 50);
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(handleSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitButton];

    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 340, self.view.bounds.size.width - 2*padding, 50)];
    self.statusLabel.textColor = [UIColor systemRedColor];
    self.statusLabel.numberOfLines = 2;
    [self.view addSubview:self.statusLabel];
}

- (void)handleSubmit {
    NSString *name = self.nameField.text;
    NSString *email = self.emailField.text;
    
    if (name.length == 0 || email.length == 0) {
        self.statusLabel.text = @"Please fill in all fields.";
        return;
    }

    if (![email containsString:@"@"] || ![email containsString:@"."]) {
        self.statusLabel.text = @"Please enter a valid email address.";
        return;
    }

    NSString *subscribeText = self.subscribeSwitch.isOn ? @"You are subscribed!" : @"You chose not to subscribe.";
    self.statusLabel.textColor = [UIColor systemGreenColor];
    self.statusLabel.text = [NSString stringWithFormat:@"Thanks, %@!\n%@", name, subscribeText];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
