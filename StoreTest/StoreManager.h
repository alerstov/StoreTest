//
//  StoreManager.h
//  StoreTest
//
//  Created by Lion User on 29.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

@class StoreManager;

@protocol StoreManagerDelegate

-(void)transactionComplete:(StoreManager*)storeManager :(NSString*)pid;
-(void)transactionRestore:(StoreManager*)storeManager :(NSString*)pid;

@end


// Use singleton to get instance of class
@interface StoreManager : NSObject

+(id)defaultManager;

-(BOOL)productPurchased:(NSString*)pid;
-(BOOL)canMakePayments;
-(void)makePayment:(NSString*)pid;
-(void)restorePurchases;

-(void)initTransactionQueue;
-(void)requestProducts;

@property (nonatomic, assign) id<StoreManagerDelegate> delegate;
@property (nonatomic, retain) NSArray* pids;

@end
