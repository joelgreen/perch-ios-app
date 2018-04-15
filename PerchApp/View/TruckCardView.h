//
//  TruckCardView.h
//  PerchApp
//
//  Created by Joel Green on 4/14/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TruckCardView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLable;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
