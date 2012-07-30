//
//  StoreKitManager.m
//  StoreTest
//
//  Created by Lion User on 29.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreKitManager.h"


@implementation StoreKitManager
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
    [[SKPaymentQueue defaultQueue] addTransactionObserver:transactionObserver];
}

-(void)requestProducts:(NSSet*)pids
{
    if (productsRequest) [productsRequest release];
    productsRequest = [[SKProductsRequest alloc]initWithProductIdentifiers:pids];
    productsRequest.delegate = requestDelegate;
    [productsRequest start];    
}

// user can disable the ability to make purchases
-(BOOL)canMakePayments
{
    return [SKPaymentQueue canMakePayments];
}

-(void)makePayment: (NSString*)pid
{
    //SKPayment* p = [SKPayment paymentWithProduct:product];
    SKPayment* p = [SKPayment paymentWithProductIdentifier:pid];
    [[SKPaymentQueue defaultQueue] addPayment:p];
}

-(void)restorePurchases
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

@end
