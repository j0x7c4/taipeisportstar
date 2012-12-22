//
//  TPSSStadiumDetailInCreateViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumDetailInCreateViewController.h"


@interface TPSSStadiumDetailInCreateViewController () {
  NSArray* sports;
  UIPickerView *sportPickerView;
  UIDatePicker *startDatePickerView;
  UIDatePicker *endDatePickerView;
  NSDictionary* selectedSport;
  NSString* selectedStartTime;
  NSString* selectedStartTimeForShow;
  NSString* selectedEndTime;
  NSString* selectedDescription;
}
@property (strong, nonatomic) IBOutlet UIButton *buttonCreateEvent;
@property (strong, nonatomic) IBOutlet UITextField *selectedSportTextField;
@property (strong, nonatomic) IBOutlet UITextField *selectedTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *eventDescription;

@end

@implementation TPSSStadiumDetailInCreateViewController

- (IBAction)createEvent:(id)sender {
  if (FBSession.activeSession.isOpen) {
    if ( selectedSport && selectedStartTime ) {
      NSString *eventSportName = selectedSport[TPSSDataSourceDictKeySportName];
      NSString *eventStadiumName = stadium[TPSSDataSourceDictKeyStadiumName];
      NSString *eventLocation = stadium[TPSSDataSourceDictKeyStadiumAddress];
      NSString *eventDescription = [[NSString alloc]initWithFormat:@"台北運動星\n%@",selectedDescription];
      NSString *eventName = [[NSString alloc]initWithFormat:@"%@ @ %@",eventSportName,eventStadiumName];
      NSString *eventStartTime = selectedStartTime;
      NSLog(@"%@",selectedStartTime);
    
      NSDictionary *eventParameter = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    FBSession.activeSession.accessToken,@"access_token",
                                    eventName,@"name",
                                    eventStartTime,@"start_time",
                                    eventLocation,@"location",
                                    eventDescription,@"description", nil
                                    ];
    
      [[FBRequest requestWithGraphPath:@"me/events"
                            parameters:eventParameter
                            HTTPMethod:@"POST"] startWithCompletionHandler:^(FBRequestConnection *connection,
                                                                                                                             NSDictionary<FBGraphObject> *obj,
                                                                                                                             NSError *error) {
        if (!error) {
          NSLog(@"event id: %@",obj[@"id"]);
          if ( [TPSSDataSource createEventWith:obj[@"id"] :[TPSSDataSource sharedDataSource].userId: selectedSport[TPSSDataSourceDictKeySportID] :stadium[TPSSDataSourceDictKeyStadiumID] ] ){
            NSString *message  = [[NSString alloc]initWithFormat:@"創建活動成功！\n活動名稱:%@\n活動時間:%@",eventName,selectedStartTimeForShow];
            [[[UIAlertView alloc] initWithTitle:@"創建活動"
                                       message:message
                                      delegate: self
                             cancelButtonTitle:@"知道了"
                             otherButtonTitles:nil] show];
          }
        }
        else {
          NSLog(@"%@",error);
        }
      }];
      eventDescription = nil;
      eventLocation = nil;
      eventName = nil;
      eventParameter = nil;
      eventSportName = nil;
      eventStadiumName = nil;
      eventStartTime = nil;
    }
    else {
      UIAlertView *tip = [[UIAlertView alloc] initWithTitle:@"創建活動"
                                                      message:@"請選擇體育項目和活動時間"
                                                     delegate: self
                                            cancelButtonTitle:@"確定"
                                            otherButtonTitles:nil];
      [tip show];
      
    }
  }
}

- (void) setWithStadiumDictionary:(NSDictionary *)stadiumDict {
    stadium = stadiumDict;
}
- (void)setSelectedSport:(NSDictionary*)sport {
  selectedSport = sport;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  sports = [stadium[TPSSDataSourceDictKeyStadiumSports] allValues];
    self.buttonCreateEvent.titleLabel.text = @"創建活動";
  if ( selectedSport ) {
    self.selectedSportTextField.text = selectedSport[TPSSDataSourceDictKeySportName];
    
  }
}

- (void)dealloc {
  stadium = nil;
  sportPickerView = nil;
  sports = nil;
  startDatePickerView = nil;
  endDatePickerView = nil;
  selectedStartTimeForShow = nil;
  [sportPickerView resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  if ( textField.tag == 1 ) {
    sportPickerView = [[UIPickerView alloc] init];
    [sportPickerView sizeToFit];
    sportPickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    sportPickerView.delegate = self;
    sportPickerView.dataSource = self;
    sportPickerView.showsSelectionIndicator = YES;
    textField.inputView = sportPickerView;
  
  
  
    UIToolbar* keyboardButtonView = [[UIToolbar alloc] init];
    keyboardButtonView.barStyle = UIBarStyleBlack;
    keyboardButtonView.translucent = YES;
    keyboardButtonView.tintColor = nil;
    [keyboardButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"確定"
                                                                  style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(sportPickerDoneClicked:)];
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(sportPickerCancelClicked:)];
    [keyboardButtonView setItems:[NSArray arrayWithObjects:doneButton,cancelButton, nil]];
    textField.inputAccessoryView = keyboardButtonView;
  }
  else if ( textField.tag == 2 ) {
    startDatePickerView = [[UIDatePicker alloc] init];
    [startDatePickerView sizeToFit];
    startDatePickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    startDatePickerView.datePickerMode = UIDatePickerModeDateAndTime;
    textField.inputView = startDatePickerView;
    
    UIToolbar* keyboardButtonView = [[UIToolbar alloc] init];
    keyboardButtonView.barStyle = UIBarStyleBlack;
    keyboardButtonView.translucent = YES;
    keyboardButtonView.tintColor = nil;
    [keyboardButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"確定"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(datePickerDoneClicked:)];
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                     style:UIBarButtonItemStyleBordered target:self
                                                                    action:@selector(datePickerCancelClicked:)];
    [keyboardButtonView setItems:[NSArray arrayWithObjects:doneButton,cancelButton, nil]];
    textField.inputAccessoryView = keyboardButtonView;
  }
  else if (textField.tag == 3 ) {
    UIToolbar* keyboardButtonView = [[UIToolbar alloc] init];
    keyboardButtonView.barStyle = UIBarStyleBlack;
    keyboardButtonView.translucent = YES;
    keyboardButtonView.tintColor = nil;
    [keyboardButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"確定"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(descriptionDoneClicked:)];
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                     style:UIBarButtonItemStyleBordered target:self
                                                                    action:@selector(descriptionCancelClicked:)];
    [keyboardButtonView setItems:[NSArray arrayWithObjects:doneButton,cancelButton, nil]];
    textField.inputAccessoryView = keyboardButtonView;
  }
  
  return YES;
  
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return [sports count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return sports[row][TPSSDataSourceDictKeySportName];
}
- (void)sportPickerDoneClicked: (id)sender {
  int row = [sportPickerView selectedRowInComponent:0];
  self.selectedSportTextField.text = sports[row][TPSSDataSourceDictKeySportName];
  selectedSport = sports[row];
  [self.selectedSportTextField endEditing:YES];
}
- (void)sportPickerCancelClicked: (id)sender {
  [self.selectedSportTextField endEditing:YES];
}

- (void)datePickerDoneClicked: (id)sender {
  NSDate* date = [startDatePickerView date];
  NSDateFormatter *dateformatterForTextField = [[NSDateFormatter alloc]init];
  NSDateFormatter *dateformatterForFBEvent_first = [[NSDateFormatter alloc]init];
  NSDateFormatter *dateformatterForFBEvent_second = [[NSDateFormatter alloc]init];
  [dateformatterForTextField setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
  [dateformatterForFBEvent_first setDateFormat:@"yyyy-MM-dd"];
  [dateformatterForFBEvent_second setDateFormat:@"HH:mm:ss"];
  selectedStartTimeForShow = self.selectedTimeTextField.text =  [dateformatterForTextField stringFromDate:date];
  selectedStartTime = [[NSString alloc]initWithFormat:@"%@T%@+0800",
    [dateformatterForFBEvent_first stringFromDate:date],
    [dateformatterForFBEvent_second stringFromDate:date] ];
  date =nil;
  dateformatterForFBEvent_first=nil;
  dateformatterForFBEvent_second=nil;
  dateformatterForTextField=nil;
  [self.selectedTimeTextField endEditing:YES];
}
- (void)datePickerCancelClicked: (id)sender {
  [self.selectedTimeTextField endEditing:YES];
}
- (void)descriptionCancelClicked: (id)sender {
  selectedDescription=self.eventDescription.text = @"";
  [self.eventDescription endEditing:YES];
}
- (void)descriptionDoneClicked: (id)sender {
  selectedDescription = self.eventDescription.text;
  [self.eventDescription endEditing:YES];
}
@end
