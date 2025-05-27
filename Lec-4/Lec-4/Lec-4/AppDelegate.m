//
//  AppDelegate.m
//  Lec-4
//
//  Created by Abhi Patel on 2025-05-07.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Create window
    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(100, 100, 600, 400)
                                              styleMask:(NSWindowStyleMaskTitled |
                                                         NSWindowStyleMaskClosable |
                                                         NSWindowStyleMaskResizable)
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    
    [self.window setTitle:@"Lec_4 Controls Demo"];

    // Create ViewController
    ViewController *vc = [[ViewController alloc] init];
    [self.window setContentViewController:vc];
    [self.window makeKeyAndOrderFront:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end
