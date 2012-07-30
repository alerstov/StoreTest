//
//  ViewController.m
//  StoreTest
//
//  Created by Lion User on 28.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "StoreManager.h"
#import "StoreData.h"

@interface ViewController ()<StoreManagerDelegate>
{

}
@end

@implementation ViewController
@synthesize but_2;
@synthesize but_1;

-(void)dealloc
{
    [but_2 release];
    [but_1 release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    StoreManager* sm = [StoreManager defaultManager];
    sm.delegate = self;
    [sm initTransactionQueue];
    
    [self updateButtons];
}

- (void)viewDidUnload
{
    [self setBut_2:nil];
    [self setBut_1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)click_1:(id)sender {
    StoreManager* sm = [StoreManager defaultManager];
    if (![sm productPurchased:@"com.1"]){
        [sm makePayment:@"com.1"];
    }
}

- (IBAction)click_2:(id)sender {
    StoreManager* sm = [StoreManager defaultManager];
    if (![sm productPurchased:@"com.2"]){
        [sm makePayment:@"com.2"];
    }
}

-(void)updateButtons
{
    StoreManager* sm = [StoreManager defaultManager];
    if ([sm productPurchased:@"com.1"]){
        [self.but_1 setTitle:@"1" forState:UIControlStateNormal];
    }
    if ([sm productPurchased:@"com.2"]){
        [self.but_2 setTitle:@"2" forState:UIControlStateNormal];
    }
}

-(void)transactionComplete:(StoreManager*)storeManager :(NSString *)pid
{
    [self updateButtons];
}

-(void)transactionRestore:(StoreManager *)storeManager :(NSString *)pid                         
{
    [self updateButtons];
}

- (IBAction)unbuy:(id)sender {
    [StoreData deleteDataFile];
}
@end
