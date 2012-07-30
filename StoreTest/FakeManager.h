//
//  FakeManager.h
//  StoreTest
//
//  Created by Lion User on 30.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StoreKitManagerDelegate

-(void)completeTransaction:(NSString*)pid;
-(void)restoreTransaction:(NSString*)pid;
-(void)failedTransaction:(NSString*)pid :(NSError*)error;

@end


@interface StoreKitManager : NSObject

@property (nonatomic, assign) id<StoreKitManagerDelegate> delegate;

-(void)initTransactionQueue;
-(BOOL)canMakePayments;
-(void)makePayment: (NSString*)pid;
-(void)restorePurchases;
-(void)requestProducts:(NSSet*)pids;

@end
