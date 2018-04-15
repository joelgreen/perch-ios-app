//
//  CheckoutViewController.m
//  PerchApp
//
//  Created by Joel Green on 4/15/18.
//  Copyright © 2018 Perch. All rights reserved.
//

#import "CheckoutViewController.h"

@interface CheckoutViewController ()

@end

@implementation CheckoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayQRCode
{
    UIImageView *qrView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qr.png"]];
    qrView.frame = CGRectMake(0, 0, 300, 300);
    qrView.center = self.view.center;
    
    qrView.layer.shadowColor = [UIColor blackColor].CGColor;
    qrView.layer.shadowRadius = 8;
    qrView.layer.shadowOpacity = 0.65;
    qrView.layer.shadowOffset = CGSizeMake(0, 0);

    [self.view addSubview:qrView];
}

- (IBAction)acceptButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirm Payment of $26.97"
                                                                   message:@"This will be charged to your card ending in 8765."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self displayQRCode];
                                                          }];
    
    [alert addAction:defaultAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
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
