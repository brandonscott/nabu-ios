//
//  ViewController.m
//  Nabu Tutorials
//
//  Created by Brandon Scott on 23/12/2014.
//  Copyright (c) 2014 Brandon Scott. All rights reserved.
//

#import "ViewController.h"
#import <NabuOpenSDK/NabuOpenSDK.h>

@interface ViewController ()

@end

@implementation ViewController


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)pressedAuthenticate:(id)sender {
    
    NSLog(@"Pressed Authenticate");
    
    //Creates Authentication URL
    NSURL *authUrl = [[NabuDataManager sharedDataManager]authorizationURLForAppID:@"test" andScope:@"fitness" withAppURISchemeCallback:@"BJCS"];
    
    //Opens URL which redirects to the Nabu Utility
    [[UIApplication sharedApplication] openURL:authUrl];
    
}

- (IBAction)pressedCheckAuth:(id)sender {
    
    NSLog(@"Pressed Check Authenticate");
    
    //Check if the app is authenticated
    [[NabuDataManager sharedDataManager] checkAppAuthorizedWithBlock:^(NSDictionary *callback){
        NSLog(@"%@",[callback description]);
    }];
}

- (IBAction)pressedSendNotification:(id)sender {
    
     NSLog(@"Pressed Send Notification");
    
    //Instantiate a NabuNotification object
    NabuNotification *nabuNotification = [[NabuNotification alloc] init];
    
    //Add the attributes to the object
    nabuNotification.text = [titleTextField text];
    nabuNotification.text1 = [lineOneTextField text];
    nabuNotification.text2 = [lineTwoTextField text];
    nabuNotification.iconResId = @"smiley";
    
    //Send the object and wait for the callback
    [[NabuDataManager sharedDataManager] sendNotificationToBand:nabuNotification withBlock:^(NSDictionary *callback) {
        NSLog(@"%@",[callback description]);
    }];
}

- (IBAction)pressedGetProfile:(id)sender {
    [[NabuDataManager sharedDataManager] getUserProfileWithBlock:^(NSDictionary *userData) {
        
        //Debug Log to check keys in userData callback dictionary
        NSLog(@"%@",[userData description]);
        //Get the user object
        NabuUserProfile *userProfile = [userData objectForKey:@"Contents"];
        //Log the Gender property
        NSLog(@"%@",[userProfile gender]);
    }];
}

- (IBAction)pressedFitnessRecords:(id)sender {
    [[NabuDataManager sharedDataManager] getFitnessDataWithNumberOfRecords:@"2016" withBlock:^(NSDictionary *callback) {
        //Debug Log to check Callback
        NSLog(@"%@",[callback description]);
        
        //Get the NabuFitness object from callback
        NabuFitness *fitnessContainer = [callback objectForKey: @"Fitness Data Records Retrieved"];
        
        //Check how many elements in the fitnessData array
        NSLog(@"%lu", (unsigned long)fitnessContainer.fitnessData.count);
        
        //Iterate over each NabuFitnessData object in the array
        for (int i = 0; i < fitnessContainer.fitnessData.count; i++) {
            //Log both the calories for the record and the time it was recorded
            NSLog(@"%ld",(long)[[fitnessContainer.fitnessData objectAtIndex:i] calories]);
            NSLog(@"%ld",(long)[[fitnessContainer.fitnessData objectAtIndex:i] recordTime]);
        }
    }];
}

- (IBAction)pressedFitnessDate:(id)sender {
    [[NabuDataManager sharedDataManager] getFitnessDataByDate:@"1417156900" withBlock:^(NSDictionary *callback) {
        NSLog(@"%@",[callback description]);
        
        NabuFitness *fitnessContainer = [callback objectForKey: @"Fitness Data Records Retrieved"];
        
        NSLog(@"%lu %lu", (unsigned long)fitnessContainer.fitnessData.count, (unsigned long)fitnessContainer.fitnessHistoryData.count);
    }];
}

- (IBAction)pressedFitnessDays:(id)sender {
    [[NabuDataManager sharedDataManager] getFitnessHistoryDataForNumberOfDays:@"180" withBlock:^(NSDictionary *callback) {
        NSLog(@"%@",[callback description]);
        
        NabuFitness *fitnessContainer = [callback objectForKey: @"Fitness History Data Records Retrieved"];
        
        NSLog(@"%lu %lu", (unsigned long)fitnessContainer.fitnessData.count, (unsigned long)fitnessContainer.fitnessHistoryData.count);
    }];
}

- (IBAction)pressedSleepTracker:(id)sender {
    [[NabuDataManager sharedDataManager] getSleepTrackerDataWithStartTime:@"1417156900" endTime:@"1417356900" withBlock:^(NSDictionary *callback) {
        
        //Debug Log to check Callback
        NSLog(@"%@", [callback description]);
        
        //Get NabuSleepTracker object from callback
        NabuSleepTracker *sleepContainer = [callback objectForKey:@"Sleep Data Records Retrieved"];
        
        //Check how many elements in the sleepData array
        NSLog(@"%lu", (unsigned long)sleepContainer.sleepDataArray.count);
        
        //Iterate over each SleepTrackerData object in the array
        for (int i = 0; i < sleepContainer.sleepDataArray.count; i++) {
            //Log both the calories for the record and the time it was recorded
            NSLog(@"%ld",(long)[[sleepContainer.sleepDataArray objectAtIndex:i] efficiency]);
            NSLog(@"%ld",(long)[[sleepContainer.sleepDataArray objectAtIndex:i] good]);
        }
    }];
}

- (IBAction)pressedSleepHistory:(id)sender {
    [[NabuDataManager sharedDataManager] getSleepHistoryDataWithStartTime:@"4" withBlock:^(NSDictionary *callback) {
        NSLog(@"%@", [callback description]);
        
        NabuSleepTracker *sleepContainer = [callback objectForKey:@"Sleep History Data Records Retrieved"];
        
        NSLog(@"%lu", (unsigned long)sleepContainer.sleepDataArray.count);
    }];
}

- (IBAction)pressedCreateUpdateClipboard:(id)sender {
    
    NSString *message = @"test-action";
    NSString *publicBlob = @"charName:Brandon";
    NSString *privateBlob = @"refreshRate:1";
    
    NSData *publicBlobAsData = [publicBlob dataUsingEncoding:NSUTF8StringEncoding];
    NSData *privateBlobAsData = [privateBlob dataUsingEncoding:NSUTF8StringEncoding];
    
    [[NabuDataManager sharedDataManager] createUpdateMyClipboardWithMessage:message publicData:publicBlobAsData privateData:privateBlobAsData withBlock:^(NSDictionary *callback) {
        NSLog(@"%@", [callback description]);
    }];
}

- (IBAction)pressedDeleteClipboard:(id)sender {
    [[NabuDataManager sharedDataManager] deleteMyClipboardWithBlock:^(NSDictionary *callback){
        //Debug log
        NSLog(@"%@", [callback description]);
    }];
}

- (IBAction)pressedGetClipboard:(id)sender {
    [[NabuDataManager sharedDataManager] getMyClipboardWithBlock:^(NSDictionary *callback) {
        //Debug log
        NSLog(@"%@", [callback description]);
        
        //Get the data container for the information
        NSDictionary *dataContainer = [callback objectForKey:@"My Clipboard Data Record Retrieved"];
        
        //Get the blob storage
        NSData *publicBlobData = [dataContainer objectForKey: @"public-data"];
        NSData *privateBlobData = [dataContainer objectForKey: @"private-data"];
        
        //The two storage components contain strings, so convert them
        NSString *publicBlobDataString = [[NSString alloc] initWithData:publicBlobData encoding: NSUTF8StringEncoding];
        NSString *privateBlobDataString = [[NSString alloc] initWithData:privateBlobData encoding: NSUTF8StringEncoding];
        
        //Log Blob Storage
        NSLog(@"%@ %@", publicBlobDataString, privateBlobDataString);
    }];
}

- (IBAction)pressedClipboards:(id)sender {
    
    //Up to twenty Open IDs can be specified
    NSArray *openIds = @[@"2929292", @"32323232"];
    
    [[NabuDataManager sharedDataManager] getClipboardsWithOpenIds: openIds withBlock:^(NSDictionary *callback) {
        NSLog(@"%@", [callback description]);
    }];
}

- (IBAction)pressedPulseInfo:(id)sender {
    [[NabuDataManager sharedDataManager] getPulseDataWithStartTime:@"1417156900" endTime:@"1417356900" withBlock:^(NSDictionary *callback) {
        NSLog(@"%@", [callback description]);
    }];
}

- (IBAction)pressedHighFiveInfo:(id)sender {
    [[NabuDataManager sharedDataManager] getHiFiveDataWithStartTime:@"1417156900" endTime:@"1417356900" withBlock:^(NSDictionary *callback) {
        NSLog(@"%@", [callback description]);
    }];
}

- (void)viewDidLoad {
      [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews {
  
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [scrollArea setContentSize: CGSizeMake(0, scrollArea.frame.size.height + 400)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
