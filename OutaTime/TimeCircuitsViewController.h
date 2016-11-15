//
//  TimeCircuitsViewController.h
//  OutaTime
//
//  Created by Ben Gohlke on 2/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeCircuitsDatePickerDelegate

@end

@interface TimeCircuitsViewController () <UIPickerViewDataSource,UIPickerViewDelegate>


- (void)destinationDateWasChosen:(NSDate *)destinationDate;

@end
//
// 9. The TimeCircuitsViewController needs to implement the delegate protocol to receive the destination date from the picker
//    view. The way to declare a class as a delegate is to put the name of the delegate in between <>. It goes after the
//    superclass declaration (UIViewController below) (h- replaced with () <UIPickerViewDataSource,UIPickerViewDelegate> after @interface TimeCircuitsViewController.)
//


//@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

//@implementation TimeCircuitsViewController
