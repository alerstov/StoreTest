//
//  FakeManager.m
//  StoreTest
//
//  Created by Lion User on 30.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FakeManager.h"

@implementation FakeManager
{
    SKProductsRequest* productsRequest;
}
@synthesize requestDelegate;
@synthesize transactionObserver;

-(void)dealloc
{
    [productsRequest release];
    [super dealloc];
}

// should be called at startup
-(void)initTransactionQueue
{
    
}

-(void)requestProducts:(NSSet*)pids
{
//    self.requestDelegate productsRequest:<#(SKProductsRequest *)#> didReceiveResponse:<#(SKProductsResponse *)#>
}

// user can disable the ability to make purchases
-(BOOL)canMakePayments
{
    return YES;
}

-(void)makePayment: (NSString*)pid
{
    //SKPayment* p = [SKPayment paymentWithProduct:product];
    SKPayment* p = [SKPayment paymentWithProductIdentifier:pid];
    [[SKPaymentQueue defaultQueue] addPayment:p];
}

-(void)restorePurchases
{
    SKPaymentTransaction* tr = [[SKPaymentTransaction alloc]init];
    id tr = [[NSArray alloc] initWithObjects:@"com.1", nil];
    [self.transactionObserver paymentQueue:nil updatedTransactions:tr];
}

@end
