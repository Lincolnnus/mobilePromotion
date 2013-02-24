//
//  HPPromotion.h
//  HotelPromotion
//
//  Created by Le Viet Tien on 24/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "BaseModel.h"

@interface HPPromotion : BaseModel
@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSNumber *hid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSDate *startTime;
@property (nonatomic, copy) NSDate *endTime;
@property (nonatomic, copy) NSDate *createTime;
@end
