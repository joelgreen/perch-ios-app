//
//  AddToBasketButton.m
//  PerchApp
//
//  Created by Joel Green on 4/15/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "AddToBasketButton.h"
#import "ConstantHeader.h"

@implementation AddToBasketButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCode];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCode];
    }
    return self;
}

- (void)initCode
{
    self.layer.borderColor = UIColorFromRGB(0x65C97A).CGColor;
    self.layer.borderWidth = 2.0f;
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;

}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.titleLabel.alpha = 1;
    
    if (highlighted) {
        self.backgroundColor = self.selectedColor;
    }
    else {
        self.backgroundColor = self.unselectedColor;
    }
}

- (void)setUnselectedColor:(UIColor *)unselectedColor
{
    self.backgroundColor = unselectedColor;
    _unselectedColor = unselectedColor;
}

@end
