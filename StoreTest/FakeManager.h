//
//  FakeManager.h
//  StoreTest
//
//  Created by Lion User on 30.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreKit/StoreKit.h"

@interface FakeManager : NSObject

@property (nonatomic, assign) id<SKProductsRequestDelegate> requestDelegate;
@property (nonatomic, assign) id<SKPaymentTransactionObserver> transactionObserver;

-(void)initTransactionQueue;
-(void)requestProducts:(NSSet*)pids;
-(BOOL)canMakePayments;
-(void)makePayment: (NSString*)pid;
-(void)restorePurchases;

@end
