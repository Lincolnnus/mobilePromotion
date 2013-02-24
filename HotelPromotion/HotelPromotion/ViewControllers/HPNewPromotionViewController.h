//
//  HPNewPromotionViewController.h
//  HotelPromotion
//
//  Created by Le Viet Tien on 24/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "BaseViewController.h"

@interface HPNewPromotionViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UITextField *capacityTextField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTextField;
@end
