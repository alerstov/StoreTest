//
//  FakeManager.m
//  StoreTest
//
//  Created by Lion User on 30.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FakeManager.h"

@interface StoreKitManager()

@end


@implementation StoreKitManager
@synthesize delegate = _delegate;


// should be called at startup
-(void)initTransactionQueue
{
    
}


// user can disable the ability to make purchases
-(BOOL)canMakePayments
{
    return YES;
}

-(void)makePayment: (NSString*)pid
{
    [self.delegate completeTransaction:pid];
}

-(void)restorePurchases
{
    [self.delegate restoreTransaction:@"com.1"];
}



-(void)requestProducts:(NSSet*)pids
{
      
}

@end