//
//  RecipeCardView.m
//  PerchApp
//
//  Created by Joel Green on 4/15/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "RecipeCardView.h"

@implementation RecipeCardView

- (id)init {
    self = [super init];
    if (self) {
        [self initHelper];
    }
    return self;
}

- (id)initWithFrame:(CGRect)theFrame {
    self = [super initWithFrame:theFrame];
    if (self) {
        [self initHelper];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        [self initHelper];
    }
    return self;
}

- (void) initHelper {
    self.addBasketButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.addBasketButton.imageView.clipsToBounds = YES;
}

- (void)addRecipeObject:(RecipeObject *)recipeObject
{
    self.recipeObject = recipeObject;
    self.imageView.image = [UIImage imageNamed:recipeObject.frontImageName];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.clipsToBounds = YES;
}

BOOL isFlipped = NO;

- (void)flipOver
{
    if (!isFlipped) {
        self.imageView.image = [UIImage imageNamed:self.recipeObject.backImageName];
//        self.addBasketButton.hidden = YES;
    } else {
        self.imageView.image = [UIImage imageNamed:self.recipeObject.frontImageName];
//        self.addBasketButton.hidden = NO;
    }
    isFlipped = !isFlipped;
}

- (IBAction)addBasketClicked:(id)sender {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
