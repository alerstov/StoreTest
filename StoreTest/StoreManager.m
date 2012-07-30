//
//  StoreManager.m
//  StoreTest
//
//  Created by Lion User on 29.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreManager.h"
#import "StoreKitManager.h"
#import "StoreData.h"

@interface StoreManager()<SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic, retain) StoreKitManager* storeKitManager;
@property (nonatomic, retain) NSMutableArray* buyPids;
@end



@implementation StoreManager
@synthesize pids = _pids;
@synthesize buyPids = _buyPids;
@synthesize products = _products;
@synthesize delegate = _delegate;
@synthesize storeKitManager = _storeKitManager;

+(id)defaultManager
{
    static StoreManager* storeManager = nil;
    if (storeManager == nil){
        storeManager = [[self alloc]init];
    }
    return storeManager;
}

-(id)init
{
    if (self = [super init]){
        self.storeKitManager = [[StoreKitManager alloc] init];
        self.storeKitManager.requestDelegate = self;
        self.storeKitManager.transactionObserver = self;
        
        // read pids
        self.pids = [[StoreData readFromResource:@"pids"] objectForKey:@"pids"];        
        NSArray* storePids = [[StoreData readFromFile:@"store.plist"] objectForKey:@"pids"];
        self.buyPids = [[NSMutableArray alloc]initWithArray:storePids];
    }
    return self;
}

-(void)initTransactionQueue
{
    [self.storeKitManager initTransactionQueue];
}

-(void)requestProducts
{
    NSSet* requestPids = [[NSSet alloc] initWithArray:self.pids];
    [self.storeKitManager requestProducts:[requestPids autorelease]];  
}

-(void)dealloc
{
    [self.pids release];
    [self.buyPids release];
    [self.products release];
    [self.storeKitManager release];
    [super dealloc];
}


-(BOOL)productPurchased:(NSString*)pid
{
    return [self.buyPids containsObject:pid];
}

-(void)restorePurchases
{
    [self.storeKitManager restorePurchases];
}

// user can disable the ability to make purchases
-(BOOL)canMakePayments
{
    return [self.storeKitManager canMakePayments];
}

-(void)makePayment:(NSString*)pid
{
    [self.storeKitManager makePayment:pid];
}



-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"products request complete");
    
    self.products = response.products;
    [self.delegate productsAvailable:self];
}

-(void)recordTransaction:(SKPaymentTransaction*)transaction
{
    // add transaction pid to buyPids array
    [self.buyPids addObject:transaction.payment.productIdentifier];

    // save buyPids array
    NSDictionary* dict = [NSDictionary dictionaryWithObject:self.buyPids forKey:@"pids"];
    [StoreData save:dict ToFile:@"store.plist"];
    [dict release];
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
    
    [self recordTransaction:transaction];
    [self.delegate transactionComplete:self :transaction.payment.productIdentifier];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)restoreTransaction: (SKPaymentTransaction*)transaction
{
    NSLog(@"transaction restore: %@", transaction.payment.productIdentifier);

    [self recordTransaction:transaction];
    [self.delegate transactionRestore:self :transaction.payment.productIdentifier];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)failedTransaction: (SKPaymentTransaction*)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled){
        // todo          
        NSLog(@"transaction failed: %@", transaction.error);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

@end
