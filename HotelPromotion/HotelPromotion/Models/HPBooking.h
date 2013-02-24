//
//  HPBooking.h
//  HotelPromotion
//
//  Created by Shaohuan Li on 25/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "BaseModel.h"

@interface HPBooking : BaseModel

@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSNumber *hid;
@property (nonatomic, copy) NSNumber *pid;
@property (nonatomic, copy) NSNumber *bid;
@property (nonatomic, copy) NSNumber *bookPrice;
@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSString *confirmationNum;
@property (nonatomic, copy) NSString *bookCurrency;
@property (nonatomic, copy) NSDate *bookTime;
@property (nonatomic, copy) NSDate *startDate;
@property (nonatomic, copy) NSDate *endDate;

@end
