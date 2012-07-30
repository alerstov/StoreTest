//
//  StoreManager.m
//  StoreTest
//
//  Created by Lion User on 29.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreManager.h"
//#import "StoreKitManager.h"
#import "FakeManager.h"
#import "StoreData.h"

@interface StoreManager()<StoreKitManagerDelegate>

@property (nonatomic, retain) StoreKitManager* storeKitManager;
@property (nonatomic, retain) NSMutableArray* buyPids;
@end



@implementation StoreManager
@synthesize pids = _pids;
@synthesize buyPids = _buyPids;
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
        self.storeKitManager.delegate = self;
        
        // read pids
        self.pids = [[StoreData readFromResource:@"pids"] objectForKey:@"pids"];        
        NSArray* storePids = [[StoreData readFromFile:@"store.plist"] objectForKey:@"pids"];
        self.buyPids = [[NSMutableArray alloc]initWithArray:storePids];
        
        for (id pid in self.pids) {
            NSLog(@"pid %@",pid);
        }
        for (id pid in self.buyPids) {
            NSLog(@"buy pid %@",pid);
        }
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


-(void)recordTransaction:(NSString *)pid
{
    // add transaction pid to buyPids array
    if (![self.buyPids containsObject:pid]) [self.buyPids addObject:pid];

    // save buyPids array
    NSDictionary* dict = [NSDictionary dictionaryWithObject:self.buyPids forKey:@"pids"];
    [StoreData save:dict ToFile:@"store.plist"];
}



-(void)completeTransaction:(NSString *)pid
{
    [self recordTransaction:pid];
    [self.delegate transactionComplete:self :pid];
}

-(void)restoreTransaction:(NSString *)pid
{
    [self recordTransaction:pid];
    [self.delegate transactionRestore:self :pid];
}

-(void)failedTransaction:(NSString*)pid :(NSError*)error;
{
    // todo
}

@end
