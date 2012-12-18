//
//  TPSSStadiumDetailInCreateViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumDetailInCreateViewController.h"
#import "TPSSDataSource.h"
#import <FacebookSDK/FacebookSDK.h>

@interface TPSSStadiumDetailInCreateViewController () {
  NSDictionary *stadium;
  NSArray* sports;
}
@property (strong, nonatomic) IBOutlet UILabel *labelStadiumName;
@property (strong, nonatomic) IBOutlet UILabel *labelOpenTime;
@property (strong, nonatomic) IBOutlet UILabel *labelSports;
@property (strong, nonatomic) IBOutlet UILabel *labelBusInfo;
@property (strong, nonatomic) IBOutlet UILabel *labelMRTInfo;
@property (strong, nonatomic) IBOutlet UIButton *buttonCreateEvent;
@property (strong, nonatomic) IBOutlet UITextField *selectedSport;
@property (strong, nonatomic) IBOutlet UITextField *selectedTime;
@property (strong, nonatomic) IBOutlet UITextView *eventDescription;

@end

@implementation TPSSStadiumDetailInCreateViewController

- (IBAction)createEvent:(id)sender {
  if (FBSession.activeSession.isOpen) {
    NSDictionary *eventParameter = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    FBSession.activeSession.accessToken,@"access_token",
                                    @"test_event",@"name",
                                    @"2012-12-18T15:55:30+0800",@"start_time",
                                    @"aaa",@"location",
                                    @"bbb",@"description", nil
                                    ];
    
    [[FBRequest requestWithGraphPath:@"me/events" parameters:eventParameter HTTPMethod:@"POST"] startWithCompletionHandler:^(FBRequestConnection *connection,
                                                                                                                             NSDictionary<FBGraphObject> *obj,
                                                                                                                             NSError *error) {
      NSLog(@"%@",connection);
      if (!error) {
        
      }
      else {
        NSLog(@"%@",error);
      }
    }];
  }
}

- (void) setWithStadiumDictionary:(NSDictionary *)stadiumDict {
    stadium = stadiumDict;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  self.title = self.labelStadiumName.text = stadium[TPSSDataSourceDictKeyStadiumName];
  self.labelBusInfo.text = [[NSString alloc]initWithFormat:@"公車路線:%@",stadium[TPSSDataSourceDictKeyStadiumBus]];
  self.labelMRTInfo.text = [[NSString alloc]initWithFormat:@"捷運路線:%@",stadium[TPSSDataSourceDictKeyStadiumMrt]];
  self.labelOpenTime.text = stadium[TPSSDataSourceDictKeyStadiumTime];
  sports = [stadium[TPSSDataSourceDictKeyStadiumSports] allValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  if ( textField.tag == 1 ) {
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [pickerView sizeToFit];
    pickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    textField.inputView = pickerView;
  
  
  
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                  style:UIBarButtonItemStyleBordered target:self
                                                                 action:@selector(pickerDoneClicked)];
  
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    textField.inputAccessoryView = keyboardDoneButtonView;
  }
  else if ( textField.tag == 2 ) {
    
  }
  
  return YES;
  
}


- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
  
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [sports count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return [sports objectAtIndex:row];
}
- (void)pickerDoneClicked {

}
@end
