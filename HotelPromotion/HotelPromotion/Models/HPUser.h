//
//  FTVillager.h
//  JanuaryApp
//
//  Created by Torin on 10/9/12.
//  Copyright (c) 2012 2359media. All rights reserved.
//

@interface HPUser : BaseModel

@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSNumber *hid;
@property (nonatomic, copy) NSNumber *password;
@property (nonatomic, copy) NSString *fname;
@property (nonatomic, copy) NSString *lname;
@property (nonatomic, copy) NSNumber *gender;
@property (nonatomic, copy) NSNumber *title;
@property (nonatomic, copy) NSString *passportNum;
@property (nonatomic, copy) NSDate *issueDate;
@property (nonatomic, copy) NSDate *expireDate;
@property (nonatomic, copy) NSString *creditType;
@property (nonatomic, copy) NSString *dateOfBirth;
@property (nonatomic, copy) NSString* mobileNum;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *registerDate;

@end
