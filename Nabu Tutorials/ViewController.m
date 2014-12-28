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
        
        NabuFitness *fitnessContainer = [callback objectForKey: @"Fitness Data Records Retrieved"];
        
        NSLog(@"%lu %lu", (unsigned long)fitnessContainer.fitnessData.count, (unsigned long)fitnessContainer.fitnessHistoryData.count);
    }];
}

- (void)viewDidLoad {
      [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews {
  
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [scrollArea setContentSize: CGSizeMake(0, scrollArea.frame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
