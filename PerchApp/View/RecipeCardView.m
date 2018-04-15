//
//  RecipeCardView.m
//  PerchApp
//
//  Created by Joel Green on 4/15/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "RecipeCardView.h"
#import "ConstantHeader.h"

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

}


- (void)addRecipeObject:(RecipeObject *)recipeObject
{
    self.recipeObject = recipeObject;
    self.imageView.image = [UIImage imageNamed:recipeObject.frontImageName];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.clipsToBounds = YES;
    
}

- (void)flipOver
{
    if (!self.isFlipped) {
        self.imageView.image = [UIImage imageNamed:self.recipeObject.backImageName];
//        self.addBasketButton.hidden = YES;
    } else {
        self.imageView.image = [UIImage imageNamed:self.recipeObject.frontImageName];
//        self.addBasketButton.hidden = NO;
    }
    self.isFlipped = !self.isFlipped;
}

- (IBAction)addBasketClicked:(id)sender {
    NSLog(@"add basket clicked");
    

    UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"AddedToCart"
     object:self];
    
    [UIView animateWithDuration:0.75 delay:0 options:options animations:^{
        [self.addBasketButton setBackgroundColor:[UIColor clearColor]];
    } completion:^(BOOL finished) {
        //
    }];

}

- (IBAction)addBasketTouchDown:(id)sender {
    [self.addBasketButton setBackgroundColor:UIColorFromARGB(0x8865C97A)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
