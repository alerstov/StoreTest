//
//  ViewController.m
//  StoreTest
//
//  Created by Lion User on 28.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "StoreManager.h"

@interface ViewController ()<StoreManagerDelegate>
{

}
@end

@implementation ViewController

-(void)dealloc
{

    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    StoreManager* sm = [StoreManager defaultManager];
    sm.delegate = self;
    [sm initTransactionQueue];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)click:(id)sender {
    [[StoreManager defaultManager] makePayment:@"com.1"];
}

-(void)transactionComplete:(StoreManager*)storeManager :(NSString *)pid
{
    
}

-(void)transactionRestore:(StoreManager *)storeManager :(NSString *)pid                         
{
    
}

@end
