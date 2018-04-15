//
//  MealSelectionViewController.m
//  PerchApp
//
//  Created by Joel Green on 4/14/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "MealSelectionViewController.h"
#import "PerchApp-Swift.h"

@interface MealSelectionViewController () <FSPagerViewDelegate, FSPagerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *pagedViewHolder;
@property (weak, nonatomic) FSPagerView *pagerView;
@property (strong, nonatomic) NSArray *recipes;
@property (weak, nonatomic) IBOutlet UIImageView *topBar;

@end

@implementation MealSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topBar.layer.cornerRadius = 8;
    self.topBar.clipsToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    FSPagerView *pagerView = [[FSPagerView alloc] initWithFrame:CGRectMake(0, 0, self.pagedViewHolder.frame.size.width, self.pagedViewHolder.frame.size.height)];
    pagerView.dataSource = self;
    pagerView.delegate = self;
    
    [pagerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.pagedViewHolder addSubview:pagerView];
    self.pagerView = pagerView;
    
    pagerView.transformer = [[FSPagerViewTransformer alloc] initWithType:FSPagerViewTransformerTypeLinear];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.2 * 0.535, 1.2);
    self.pagerView.itemSize = CGSizeApplyAffineTransform(self.pagerView.frame.size, transform);
    
//    float widthRatio = 834 / 1557;
//    NSLog(@"%f", pagerView.frame.size.height);
//    self.pagerView.itemSize = CGSizeMake((int)(pagerView.frame.size.height * widthRatio), pagerView.frame.size.height);
    
    self.recipes = @[@"chicken.png", @"halibut.png", @"pizza.png"];
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
    cell.imageView.image = [UIImage imageNamed:[self.recipes objectAtIndex:index]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.clipsToBounds = YES;
    return cell;
}

#pragma mark - FSPagerView Delegate

- (void)pagerView:(FSPagerView *)pagerView didSelectItemAtIndex:(NSInteger)index
{
    [pagerView deselectItemAtIndex:index animated:YES];
    [pagerView scrollToItemAtIndex:index animated:YES];
//    self.pageControl.currentPage = index;
}

- (void)pagerViewDidScroll:(FSPagerView *)pagerView
{
//    if (self.pageControl.currentPage != pagerView.currentIndex) {
//        self.pageControl.currentPage = pagerView.currentIndex;
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
