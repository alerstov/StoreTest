//
//  StoreData.m
//  StoreTest
//
//  Created by Lion User on 30.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreData.h"


@implementation StoreData

+(NSString*)pathForDataFile:(NSString*)file
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:file];        
}

+(NSDictionary*)readFromFile:(NSString*)file
{
    NSString* path = [StoreData pathForDataFile:file];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return nil;
    
    NSData* data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    NSPropertyListFormat format;
    NSString* errorDesc = nil;
    return [NSPropertyListSerialization propertyListFromData:data 
                                        mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                        format:&format 
                                        errorDescription:&errorDesc];
}

+(void)save:(NSDictionary*)dict ToFile:(NSString*)file
{
    NSString* errorDesc = nil;
    NSData* data = [NSPropertyListSerialization dataFromPropertyList:dict 
                                                format:NSPropertyListXMLFormat_v1_0 
                                                errorDescription:&errorDesc];
    [data writeToFile:[StoreData pathForDataFile:file] atomically:YES];
}

+(NSDictionary*)readFromResource:(NSString*)name
{
    NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSData* data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    NSPropertyListFormat format;
    NSString* errorDesc = nil;
    return [NSPropertyListSerialization propertyListFromData:data 
                                        mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                        format:&format 
                                        errorDescription:&errorDesc];
}

+(void)deleteDataFile
{
    NSError* error;
    [[NSFileManager defaultManager] removeItemAtPath:[StoreData pathForDataFile:@"store.plist"] error:&error];
}

@end
