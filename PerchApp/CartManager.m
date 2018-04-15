//
//  CartManager.m
//  PerchApp
//
//  Created by Joel Green on 4/15/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "CartManager.h"

@interface CartManager ()

@end

@implementation CartManager

+ (id)sharedInstance
{
    static CartManager *cManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cManager = [[self alloc] init];
    });
    return cManager;
}

#pragma mark - Lazy Initalization

- (NSMutableArray *)cartItems
{
    if (!_cartItems) {
        _cartItems = [[NSMutableArray alloc] init];
    }
    return _cartItems;
}


- (void)addItem:(NSString *)item
{
    [self.cartItems addObject:item];
}

- (void)resetCart
{
    self.cartItems = [[NSMutableArray alloc] init];
}


@end
