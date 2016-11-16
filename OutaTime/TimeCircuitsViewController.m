//
//  TimeCircuitsViewController.m
//  OutaTime
//
//  Created by Ben Gohlke on 2/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TimeCircuitsViewController.h"
#import "DatePickerViewController.h"

@interface TimeCircuitsViewController () <TimeCircuitsDatePickerDelegate>

//
// 1. We need three properties to hold various info.
//    One should be an NSTimer object to use when counting up the speedometer label (H- @property (nonatomic) NSTimer *timer;)
//    Another should be an NSDateFormatter object to use to format the dates for the time circuit readouts. (H-@property (nonatomic) NSDateFormatter *timeCircuitValue;)
//    The last is an NSInteger object to hold the current speed of the DeLorean. (H-@property (nonatomic) NSInteger *currentSpeedValue;)
//

// These are the properties that will be wired up to the labels in the storyboard. If the circles to the left of them are hollow, they have not been connected in the storyboard.
@property (weak, nonatomic) IBOutlet UILabel *destinationTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeDepartedLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSDateFormatter *timeCircuitsValue;
@property (assign) NSInteger currentSpeedValue;

// This is an IBAction. It is a method that will fire when the element it's connected to fires an event of your choosing.
- (IBAction)travelBack:(UIButton *)sender;

// These are private custom methods
- (void)startTimer;
- (void)stopTimer;
- (void)updateSpeed;

@end

@implementation TimeCircuitsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.timeCircuitsValue = [[NSDateFormatter alloc] init];
    //self.timeCircuitsValue.dateStyle = NSDateFormatterMediumStyle;
    //self.timeCircuitsValue.timeStyle = NSDateFormatterNoStyle;

    //
    // 2. The view should be titled "Time Circuits" (h- click View Controller in Main Story board and in Attributes Inspector, put in Time Circuits in the Title field)
    //
    //
    // 3. This is a good place to initialize the objects that will be used later on.
    //    The date formatter object you created above needs to be instantiated. (h-    self.timeCircuitsValue = [[NSDateFormatter alloc] init];)
        //(h-below two lines are only used outside the Method so I can use throughout the code. If I kept inside the Method, it would of only ran in one instance within the Method. We customizing the date, hence MMMddyyyy
        //self.timeCircuitsValue.dateStyle = NSDateFormatterMediumStyle;
        //self.timeCircuitsValue.timeStyle = NSDateFormatterNoStyle;)
    //
    // 4. Once created, the formatString you see below needs to be set as the date formatter's dateFormat (h- added self.timeCircuitsValue.dateFormat = formatString;)
    //

    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"MMMddyyyy"
                                                             options:0
                                                              locale:[NSLocale currentLocale]];
    self.timeCircuitsValue.dateFormat = formatString;
    //
    // 5. The presentTimeLabel needs to be set to today's date. Use the dateFormatter object to do this.
    //
    NSDate *today = [NSDate date];
    self.presentTimeLabel.text = [self.timeCircuitsValue stringFromDate:today];
    
    //
    // 6. The currentSpeed integer object needs to be set to 0 to start. (h-added self.currentSpeedValue = 0)
    //
    self.currentSpeedValue = 0;
    
    //
    // 7. The speedLabel should be set to "% MPH", with the % being the current speed
    //
    self.speedLabel.text = [NSString stringWithFormat: @"%ld MPH", (long) self.currentSpeedValue];
    
    //
    // 8. The lastTimeDeparted label needs to be set to "--- -- ----"
    //
    self.lastTimeDepartedLabel.text = @"--- -- ----";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDestinationDatePickerSegue"])
    {
        DatePickerViewController *timePickerVC = (DatePickerViewController *)[segue destinationViewController];
        //
        // 10. This view controller needs to be set as the time picker view controller's delegate object. (h-added above View Controller called timePickerVC and assigned to delegate object to make it 'this' VC called self.)
        //
        timePickerVC.delegate = self;
    }
    
}

#pragma mark - TimeCircuitsDatePickerDelegate

- (void)destinationDateWasChosen:(NSDate *)destinationDate
{
    //
    // 12. The destinationTimeLabel needs to be set to the destination date using our date formatter object
    self.destinationTimeLabel.text = [self.timeCircuitsValue stringFromDate:destinationDate];
    
}

#pragma mark - Action Handlers

- (IBAction)travelBack:(UIButton *)sender
{
    //
    // 13. This is where we will start counting the speedometer up to 88 MPH. We need to use the timer object to do that. Is
    //    there a method defined that will allow us to get the timer started? (H- resets the Travel Back button)
    [self startTimer];
    
}

#pragma mark - Private

- (void)startTimer
{
    //
    // 14. We need to check that the timer object isn't running, and the best way to do that is just to check if the timer
    //    object has been instantiated, or in this case, NOT instantiated.
    //
    if (!self.timer)
    {
        //
        // 15. Below is an example of a timer being instantiated with a particular interval and firing a particular
        //    method each time the time interval has elapsed. Use this to instantiate your timer for 0.1 sec intervals. It
        //    will need to fire our custom method to update the speed label.
        //
        
//        NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
//                                                           target:self
//                                                         selector:@selector(updateSpeed)
//                                                         userInfo:nil
//                                                          repeats:YES];
           self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSpeed) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer
    {
        
    }
    //
    // 16. We need to stop the timer object here. The method to call is called "invalidate".
    //    Once it's stopped, we want to nil out the object so we can create a new one when the user asks to travel back
    //    again.
    //

    

- (void)updateSpeed
{
    //
    // 17. We need to check if the current speed variable is set to 88 yet. (h- not means !=)
    //
    if (self.currentSpeedValue != 88)
    {
        //
        // 18. If it's not yet set to 88, we want to increment the current speed variable by 1.
        self.currentSpeedValue = self.currentSpeedValue +1;
        
        //
        // 19. Here we want to update the speed label to reflect the current speed.
        self.speedLabel.text = [NSString stringWithFormat:@"%ld MPH", (long)self.currentSpeedValue];
    }
    else
    {
        //
        // 20. If the speed variable is at least 88, we want to stop the timer here.
        [self.timer invalidate];
        self.timer = nil;

        //
        // 21. Then we need to update the lastTimeDepartedLabel with the value of the presentTimeLabel. (H-WHEN WOULD YOU NOT PUT IN .TEXT BELOW?)
        self.lastTimeDepartedLabel.text = self.presentTimeLabel.text;

        //
        // 22. The presentTimeLabel needs to take the value of the destinationTimeLabel here.
        self.presentTimeLabel.text = self.destinationTimeLabel.text;
        
        //
        // 23. Lastly, we need to reset the current speed label to 0 here.
        //self.speedTimer = 0
        self.currentSpeedValue = 0;
        
    }
}

@end
