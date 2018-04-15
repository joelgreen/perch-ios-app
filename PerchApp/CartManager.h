//
//  CartManager.h
//  PerchApp
//
//  Created by Joel Green on 4/15/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartManager : NSObject

@property (strong, nonatomic) NSMutableArray *cartItems;

+ (id)sharedInstance;

- (void)addItem:(NSString *)item;

- (void)resetCart;

@end
