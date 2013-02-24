//
//  FTCredentialsManager.h
//  JanuaryApp
//
//  Created by Torin on 22/11/12.
//
//

#import <Foundation/Foundation.h>

@interface HPCredentialsManager : NSObject
@property (nonatomic, strong) HPUser *currentUser;
@property (nonatomic, strong) NSArray *promotions;
+ (HPCredentialsManager *)sharedInstance;
- (void)loginAsCustomer;
- (void)loginAsStaff;
- (void)updatePromotions;
@end
