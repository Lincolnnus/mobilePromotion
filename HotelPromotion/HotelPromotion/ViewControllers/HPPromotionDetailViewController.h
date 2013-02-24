//
//  HPPromotionDetailViewController.h
//  HotelPromotion
//
//  Created by Le Viet Tien on 24/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "BaseViewController.h"

@interface HPPromotionDetailViewController : BaseViewController
@property (nonatomic, strong) HPPromotion *promotion;
- (id)initWithPromotion:(HPPromotion *)promotion;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@end
