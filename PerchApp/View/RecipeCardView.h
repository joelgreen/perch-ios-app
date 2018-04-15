//
//  RecipeCardView.h
//  PerchApp
//
//  Created by Joel Green on 4/15/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeObject.h"
#import "AddToBasketButton.h"

@interface RecipeCardView : UIView

@property (strong, nonatomic) RecipeObject *recipeObject;

- (void)addRecipeObject:(RecipeObject *)recipeObject;

- (void)flipOver;

@property (weak, nonatomic) IBOutlet AddToBasketButton *addBasketButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
