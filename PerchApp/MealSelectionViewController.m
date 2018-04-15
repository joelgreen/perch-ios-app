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


@end

@implementation MealSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FSPagerView *pagerView = [[FSPagerView alloc] initWithFrame:self.pagedViewHolder.frame];
    pagerView.dataSource = self;
    pagerView.delegate = self;
    [pagerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.self.pagedViewHolder addSubview:pagerView];
    
    pagerView.transformer = [[FSPagerViewTransformer alloc] initWithType:FSPagerViewTransformerTypeLinear];

    
    // Create a page control
//    FSPageControl *pageControl = [[FSPageControl alloc] initWithFrame:frame2];
//    [self.view addSubview:pageControl];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (IBAction)dismissAnyModel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - FSPagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(FSPagerView *)pagerView
{
    return 3;
}

- (FSPagerViewCell *)pagerView:(FSPagerView *)pagerView cellForItemAtIndex:(NSInteger)index
{
    FSPagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell" atIndex:index];
    cell.imageView.image = [UIImage imageNamed:@"test-card.png"];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
//    cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@(index),@(index)];
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
