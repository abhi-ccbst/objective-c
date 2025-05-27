
#import "ViewController.h"

@implementation ViewController

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)loadView {
    self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 600, 400)];
    [self.view setWantsLayer:YES];
    self.view.layer.backgroundColor = [[NSColor whiteColor] CGColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupQuestions];
    [self setupUI];
    [self showQuestion];
}

- (void)setupQuestions {
    self.questions = @[
        @{@"question": @"What is the capital of France?",
          @"options": @[@"Berlin", @"London", @"Paris", @"Rome"],
          @"answer": @"Paris"},

        @{@"question": @"Which language is used in iOS development?",
          @"options": @[@"Java", @"Objective-C", @"Python", @"C#"],
          @"answer": @"Objective-C"},

        @{@"question": @"2 + 2 = ?",
          @"options": @[@"3", @"4", @"5", @"6"],
          @"answer": @"4"}
    ];
    self.currentQuestionIndex = 0;
}

- (void)setupUI {
    CGFloat x = 50;
    CGFloat y = 300;
    CGFloat width = 400;
    CGFloat height = 24;
    
    self.questionLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(x, y, width, height)];
    self.questionLabel.editable = NO;
    self.questionLabel.bezeled = NO;
    self.questionLabel.drawsBackground = NO;
    self.questionLabel.font = [NSFont boldSystemFontOfSize:16];
    [self.view addSubview:self.questionLabel];
    
    self.optionA = [self createOptionButtonWithTitle:@"A" y:y-50 tag:0];
    self.optionB = [self createOptionButtonWithTitle:@"B" y:y-90 tag:1];
    self.optionC = [self createOptionButtonWithTitle:@"C" y:y-130 tag:2];
    self.optionD = [self createOptionButtonWithTitle:@"D" y:y-170 tag:3];

    // Feedback Label
    self.feedbackLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(x, y-220, width, height)];
    self.feedbackLabel.editable = NO;
    self.feedbackLabel.bezeled = NO;
    self.feedbackLabel.drawsBackground = NO;
    self.feedbackLabel.textColor = [NSColor blueColor];
    [self.view addSubview:self.feedbackLabel];
    
    // Next Button
    self.nextButton = [[NSButton alloc] initWithFrame:NSMakeRect(x, y-260, 100, 30)];
    [self.nextButton setTitle:@"Next"];
    [self.nextButton setTarget:self];
    [self.nextButton setAction:@selector(nextQuestion)];
    [self.view addSubview:self.nextButton];
}

- (NSButton *)createOptionButtonWithTitle:(NSString *)title y:(CGFloat)y tag:(NSInteger)tag {
    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(50, y, 300, 30)];
    [button setButtonType:NSButtonTypeMomentaryPushIn];
    [button setBezelStyle:NSBezelStyleRounded];
    [button setTitle:title];
    button.tag = tag;
    [button setTarget:self];
    [button setAction:@selector(optionSelected:)];
    [self.view addSubview:button];
    return button;
}

- (void)optionSelected:(NSButton *)sender {
    NSDictionary *q = self.questions[self.currentQuestionIndex];
    NSString *selectedAnswer = q[@"options"][sender.tag];
    NSString *correctAnswer = q[@"answer"];

    if ([selectedAnswer isEqualToString:correctAnswer]) {
        self.feedbackLabel.stringValue = @"✅ Correct!";
    } else {
        self.feedbackLabel.stringValue = [NSString stringWithFormat:@"❌ Wrong! Correct: %@", correctAnswer];
    }
}



- (void)showQuestion {
    NSDictionary *q = self.questions[self.currentQuestionIndex];
    self.questionLabel.stringValue = q[@"question"];

    NSArray *options = q[@"options"];
    [self.optionA setTitle:options[0]];
    [self.optionB setTitle:options[1]];
    [self.optionC setTitle:options[2]];
    [self.optionD setTitle:options[3]];

    self.feedbackLabel.stringValue = @"";
}

- (void)nextQuestion {
    self.currentQuestionIndex++;
    if (self.currentQuestionIndex >= self.questions.count) {
        self.questionLabel.stringValue = @"🎉 Quiz Finished!";
        self.optionA.hidden = YES;
        self.optionB.hidden = YES;
        self.optionC.hidden = YES;
        self.optionD.hidden = YES;
        self.nextButton.enabled = NO;
        return;
    }
    [self showQuestion];
}

@end
