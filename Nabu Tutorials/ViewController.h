//
//  ViewController.h
//  Nabu Tutorials
//
//  Created by Brandon Scott on 23/12/2014.
//  Copyright (c) 2014 Brandon Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NabuOpenSDK/NabuOpenSDK.h>

@interface ViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *titleTextField;
    IBOutlet UITextField *lineOneTextField;
    IBOutlet UITextField *lineTwoTextField;
    IBOutlet UIScrollView *scrollArea;
}

- (IBAction)pressedAuthenticate:(id)sender;
- (IBAction)pressedCheckAuth:(id)sender;
- (IBAction)pressedSendNotification:(id)sender;
- (IBAction)pressedGetProfile:(id)sender;
- (IBAction)pressedFitnessRecords:(id)sender;
- (IBAction)pressedFitnessDate:(id)sender;
- (IBAction)pressedFitnessDays:(id)sender;
- (IBAction)pressedSleepTracker:(id)sender;
- (IBAction)pressedSleepHistory:(id)sender;

- (IBAction)pressedCreateUpdateClipboard:(id)sender;
- (IBAction)pressedDeleteClipboard:(id)sender;
- (IBAction)pressedGetClipboard:(id)sender;
- (IBAction)pressedClipboards:(id)sender;


- (IBAction)pressedPulseInfo:(id)sender;
- (IBAction)pressedHighFiveInfo:(id)sender;

@end

