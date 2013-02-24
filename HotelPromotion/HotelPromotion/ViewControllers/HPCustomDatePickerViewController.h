//
//  HPCustomDatePickerViewController.h
//  HotelPromotion
//
//  Created by Le Viet Tien on 24/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "BaseViewController.h"
#import "HPNewPromotionViewController.h"

@interface HPCustomDatePickerViewController : BaseViewController
@property (nonatomic, strong) HPNewPromotionViewController *previousVC;
@property (nonatomic, strong) NSString *title;
@end
