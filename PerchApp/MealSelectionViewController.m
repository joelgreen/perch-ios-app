//
//  MealSelectionViewController.m
//  PerchApp
//
//  Created by Joel Green on 4/14/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "MealSelectionViewController.h"
#import "PerchApp-Swift.h"
#import "RecipeCardView.h"
#import "RecipeObject.h"

@interface MealSelectionViewController () <FSPagerViewDelegate, FSPagerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *pagedViewHolder;
@property (weak, nonatomic) FSPagerView *pagerView;
@property (strong, nonatomic) NSArray *recipes;
@property (weak, nonatomic) IBOutlet UIImageView *topBar;

@property (weak, nonatomic) IBOutlet UILabel *cartCount;
@property (strong, nonatomic) NSMutableArray *recipeViews;

@property (nonatomic) BOOL viewDidLoadAlready;

@end

@implementation MealSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topBar.layer.cornerRadius = 8;
    self.topBar.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addedToCart:)
                                                 name:@"AddedToCart"
                                               object:nil];
}

- (void)addedToCart:(NSNotification *) notification
{
    self.cartCount.hidden = NO;
    self.cartCount.text = [NSString stringWithFormat:@"%d", (int)[self.cartCount.text integerValue] + 1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.viewDidLoadAlready) {
        FSPagerView *pagerView = [[FSPagerView alloc] initWithFrame:CGRectMake(0, 0, self.pagedViewHolder.frame.size.width, self.pagedViewHolder.frame.size.height)];
        pagerView.dataSource = self;
        pagerView.delegate = self;
        
        [pagerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.pagedViewHolder addSubview:pagerView];
        self.pagerView = pagerView;
        
        pagerView.transformer = [[FSPagerViewTransformer alloc] initWithType:FSPagerViewTransformerTypeLinear];
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1.2 * 0.6, 1.2);
        self.pagerView.itemSize = CGSizeApplyAffineTransform(self.pagerView.frame.size, transform);
        
        NSMutableArray *recipes = [[NSMutableArray alloc] init];
        
        RecipeObject *rec = [[RecipeObject alloc] init];
        rec.frontImageName = @"tikka.png";
        rec.backImageName = @"tikka-back.png";
        [recipes addObject:rec];
        
        RecipeObject *rec2 = [[RecipeObject alloc] init];
        rec2.frontImageName = @"halibut.png";
        rec2.backImageName = @"halibut-back.png";
        [recipes addObject:rec2];
        
        RecipeObject *rec3 = [[RecipeObject alloc] init];
        rec3.frontImageName = @"pizza.png";
        rec3.backImageName = @"pizza-back.png";
        [recipes addObject:rec3];
        self.recipes = recipes;
        
        self.cartCount.layer.cornerRadius = 42/2;
        self.cartCount.layer.borderWidth = 2.0f;
        self.cartCount.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    self.viewDidLoadAlready = YES;
}


- (IBAction)dismissAnyModel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - FSPagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(FSPagerView *)pagerView
{
    return self.recipes.count;
}

- (FSPagerViewCell *)pagerView:(FSPagerView *)pagerView cellForItemAtIndex:(NSInteger)index
{
    FSPagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell" atIndex:index];
    
    if (self.recipeViews.count <= index) {
        
        RecipeCardView *card = [[[NSBundle mainBundle] loadNibNamed:@"RecipeCardView" owner:self options:nil] objectAtIndex:0];
        
        [card addRecipeObject:[self.recipes objectAtIndex:index]];
        
        [cell addSubview:card];
        card.frame = cell.contentView.bounds;
        
        card.layer.shadowColor = [UIColor blackColor].CGColor;
        card.layer.shadowRadius = 8;
        card.layer.shadowOpacity = 0.65;
        card.layer.shadowOffset = CGSizeMake(0, 0);

        
        [self.recipeViews setObject:card atIndexedSubscript:index];
        
    }
    
    return cell;
}


#pragma mark - FSPagerView Delegate

#define FLIP_ANIMATION_DURATION 0.3

- (void)pagerView:(FSPagerView *)pagerView didSelectItemAtIndex:(NSInteger)index
{
    
    // Flip Animation
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionAllowUserInteraction;
    
    RecipeCardView *card = [self.recipeViews objectAtIndex:index];
    
    
    [UIView transitionWithView:card
                      duration:FLIP_ANIMATION_DURATION
                       options:options
                    animations:^{
                        [card flipOver];
                    }
                    completion:NULL];
}

- (void)pagerViewDidScroll:(FSPagerView *)pagerView
{
//    if (self.pageControl.currentPage != pagerView.currentIndex) {
//        self.pageControl.currentPage = pagerView.currentIndex;
//    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)recipeViews
{
    if (!_recipeViews) {
        _recipeViews = [[NSMutableArray alloc] init];
    }
    return _recipeViews;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
