//
//  NSString+Utils.h
//  server
//
//  Created by xiangwl on 14/12/17.
//  Copyright (c) 2014年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSString *) md5;
+ (NSString*) uniqueString;
- (NSString*) urlEncodedString;
- (NSString*) urlDecodedString;

- (BOOL)isValidEmail;
- (BOOL)isValidPhoneNumber;

@end
