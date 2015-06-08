//
//  NSMutableData+Multipart.m
//  CameraApp
//
//  Created by Ricardo Champa on 08/06/15.
//  Copyright (c) 2015 Clickmobile. All rights reserved.
//

#import "NSMutableData+Multipart.h"

@implementation NSMutableData (Multipart)

NSString *boundary;
BOOL isSetLast;
BOOL isSetFirst;

- (void)initMultipart{
    boundary = @"---------------------------14737809831466499882746641449";
    isSetLast = NO;
    isSetFirst = NO;
}

- (void) writeFirstBoundaryIfNeeds{
    if(!isSetFirst){
        [self appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    isSetFirst = true;
}

- (void) writeLastBoundary{
    if(isSetLast){
        return ;
    }
    [self appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    isSetLast = true;
}

- (void) addPart:(NSString*) key withValue:(NSString*) value {
    [self writeFirstBoundaryIfNeeds];
    
    [self appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Type: text/plain; charset=UTF-8\r\n"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Transfer-Encoding: 8bit\r\n\r\n"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //[self appendData:[[NSString stringWithString:[NSString stringWithFormat:@"%@",value]] dataUsingEncoding:NSUTF8StringEncoding]];
    NSData* data = [value dataUsingEncoding:NSUTF8StringEncoding];
    [self appendData:[NSData dataWithData:data]];
    [self appendData:[[NSString stringWithString:[NSString stringWithFormat:@"\r\n--%@\r\n",boundary]] dataUsingEncoding:NSUTF8StringEncoding]];

}

- (void) addPart:(NSString*) key withFileName:(NSString*) fileName withNSData:(NSData*) data {
    [self writeFirstBoundaryIfNeeds];
    
    [self appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key,fileName]] dataUsingEncoding:NSUTF8StringEncoding]];
    [self appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [self appendData:[NSData dataWithData:data]];
    //[self appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self appendData:[[NSString stringWithString:[NSString stringWithFormat:@"\r\n--%@\r\n",boundary]] dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
