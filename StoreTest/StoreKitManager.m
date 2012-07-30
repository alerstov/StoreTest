//
//  StoreKitManager.m
//  StoreTest
//
//  Created by Lion User on 29.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreKitManager.h"
#import "StoreKit/StoreKit.h"


@interface StoreKitManager()<SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic,retain) SKProductsRequest* productsRequest;

@end



@implementation StoreKitManager
@synthesize delegate = _delegate;
@synthesize productsRequest = _productsRequest;

-(void)dealloc
{
    [self.productsRequest release];
    [super dealloc];
}

// should be called at startup
-(void)initTransactionQueue
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}


// user can disable the ability to make purchases
-(BOOL)canMakePayments
{
    return [SKPaymentQueue canMakePayments];
}

-(void)makePayment: (NSString*)pid
{
    SKPayment* p = [SKPayment paymentWithProductIdentifier:pid];
    [[SKPaymentQueue defaultQueue] addPayment:p];
}

-(void)restorePurchases
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}



-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for(SKPaymentTransaction* t in transactions)
    {
        switch (t.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:t];
                break;
                
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:t];
                break;
                
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:t];
                break;
                
            default:
                break;
        }
    }
}

-(void)completeTransaction: (SKPaymentTransaction*)transaction
{
    NSLog(@"transaction complete: %@", transaction.payment.productIdentifier);
        
    [self.delegate completeTransaction:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)restoreTransaction: (SKPaymentTransaction*)transaction
{
    NSLog(@"transaction restore: %@", transaction.payment.productIdentifier);
    
    [self.delegate restoreTransaction:transaction.payment.productIdentifier];    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)failedTransaction: (SKPaymentTransaction*)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled){
        NSLog(@"transaction failed: %@", transaction.error);
        [self.delegate failedTransaction:transaction.payment.productIdentifier :transaction.error];    
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}



-(void)requestProducts:(NSSet*)pids
{
    self.productsRequest = [[SKProductsRequest alloc]initWithProductIdentifiers:pids];
    self.productsRequest.delegate = self;
    [self.productsRequest start];    
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"products request complete");
    // todo response.products
}

@end
