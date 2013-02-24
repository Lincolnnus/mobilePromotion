//
//  HPNewPromotionViewController.m
//  HotelPromotion
//
//  Created by Le Viet Tien on 24/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "HPNewPromotionViewController.h"

@interface HPNewPromotionViewController () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation HPNewPromotionViewController

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
	// Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"New Promotion"];
    [self.navigationController.tabBarItem setTitle:@"New Promotion"];
    
    self.titleTextField.delegate = self;
    self.contentTextView.delegate = self;
    self.categoryTextField.delegate = self;
    self.capacityTextField.delegate = self;
    self.startTimeTextField.delegate = self;
    self.endTimeTextField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.startTimeTextField) {
        
        return NO;
    } else if (textField == self.endTimeTextField) {
        return NO;
    } else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTitleTextField:nil];
    [self setContentTextView:nil];
    [self setCategoryTextField:nil];
    [self setCapacityTextField:nil];
    [self setStartTimeTextField:nil];
    [self setEndTimeTextField:nil];
    [super viewDidUnload];
}
@end
