//
//  ViewController.h
//  Lec-4
//
//  Created by Abhi Patel on 2025-05-07.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController


@property(nonatomic, strong) NSArray *questions;
@property(nonatomic, assign) NSInteger currentQuestionIndex;
@property (nonatomic, strong) NSTextField *questionLabel;
@property (nonatomic, strong) NSButton *optionA;
@property (nonatomic, strong) NSButton *optionB;
@property (nonatomic, strong) NSButton *optionC;
@property (nonatomic, strong) NSButton *optionD;
@property (nonatomic, strong) NSTextField *feedbackLabel;
@property (nonatomic, strong) NSButton *nextButton;

- (void)setupControls;
@end

