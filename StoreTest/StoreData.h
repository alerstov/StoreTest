//
//  StoreData.h
//  StoreTest
//
//  Created by Lion User on 30.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreData : NSObject

+(NSDictionary*)readFromFile:(NSString*)file;
+(void)save:(NSDictionary*)dict ToFile:(NSString*)file;
+(NSDictionary*)readFromResource:(NSString*)name;

@end
