//
//  NSMutableData+Multipart.h
//  CameraApp
//
//  Created by Ricardo Champa on 08/06/15.
//  Copyright (c) 2015 Clickmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (Multipart)

- (void)initMultipart;
- (void) addPart:(NSString*) key withValue:(NSString*) value;
- (void) addPart:(NSString*) key withFileName:(NSString*) fileName withNSData:(NSData*) data;
- (void) writeLastBoundary;

@end
