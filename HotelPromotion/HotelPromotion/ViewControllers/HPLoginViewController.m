//
//  HPLoginViewController.m
//  HotelPromotion
//
//  Created by Le Viet Tien on 24/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "HPLoginViewController.h"

@interface HPLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation HPLoginViewController

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
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self.navigationItem setTitle:@"Login"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginCustomerSucceed:) name:@"loginCustomerSucceed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStaffSucceed:) name:@"loginStaffSucceed" object:nil];
}

-(void)loginCustomerSucceed:(NSNotification *)notification
{
    [self performSegueWithIdentifier:@"CustomerSegue" sender:self];
}

- (void)loginStaffSucceed:(NSNotification *)notification {
    [self performSegueWithIdentifier:@"StaffSegue" sender:self];
}

- (IBAction)loginAsCustomer:(id)sender {
    [[HPCredentialsManager sharedInstance] loginAsCustomer];
}

- (IBAction)loginAsStaff:(id)sender {
    [[HPCredentialsManager sharedInstance] loginAsStaff];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
}
@end
