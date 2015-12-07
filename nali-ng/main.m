//
//  main.m
//  nali-ng
//
//  Created by wenlong on 15/12/7.
//  Copyright © 2015年 wenlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "qqwry.h"

#define NALI_QQWRY_PATH "/usr/local/share/QQWry.Dat"

#define CLLog(FORMAT, ...) fprintf(stdout,"%s",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


FILE *wry_file = NULL;

NSString* locationStringForIPString (NSString *ipString) {
    const char *ipCstring = [ipString UTF8String];
    char country[1024]={'\0'};
    char area[1024]={'\0'};
    qqwry_get_location(country,area,ipCstring,wry_file);
    
    NSMutableString *result = [NSMutableString stringWithString:@"["];
    if ( strlen(country) > 0 ) {
        [result appendString:[NSString stringWithCString:country encoding:-2147482062]];
    }
    if ( strlen(area) > 0 ) {
        [result appendFormat:@"%@%@", @" ", [NSString stringWithCString:area encoding:-2147482062]];
    }
    if (strlen(country) == 0 && strlen(area) == 0) {
        result = [NSMutableString stringWithString:@"未找到"];
    }
    [result appendString:@"]"];
    return result;
}

@implementation NSMutableString (IPLocation)

- (NSString *)ipLocationSring {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"((?:[0-2]?[0-9]{1,2}\\.){3}[0-2]?[0-9]{1,2})"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    NSUInteger current = 0;
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:self
                                                         options:0
                                                           range:NSMakeRange(current, self.length-current)];
    while (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        NSString *substringForFirstMatch = [self substringWithRange:rangeOfFirstMatch];
        NSUInteger endLocation = rangeOfFirstMatch.location + rangeOfFirstMatch.length;
        [self insertString:locationStringForIPString(substringForFirstMatch) atIndex:endLocation];
        current = endLocation;
        rangeOfFirstMatch = [regex rangeOfFirstMatchInString:self
                                                     options:0
                                                       range:NSMakeRange(current, self.length-current)];
    }
    return self;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if ((wry_file = fopen(NALI_QQWRY_PATH,"r")) == NULL ) {
            fprintf(stdout, "file: %s %s\n", NALI_QQWRY_PATH, "can not opened");
            return EXIT_FAILURE;
        }
        char inputString[BUFSIZ]={'\0'};
        switch (argc) {
            case 1:
                while (fgets(inputString, BUFSIZ, stdin) != NULL) {
                    CLLog(@"%@", [[NSMutableString stringWithUTF8String:inputString] ipLocationSring]);
                }
                break;
            case 2:
                CLLog(@"%@\n", [[NSMutableString stringWithUTF8String:argv[1]] ipLocationSring]);
                break;
            default:
                CLLog(@"Usage:\n1)    # nali 8.8.8.8\n2)    # nali\n      > 8.8.8.8\n")
                break;
        }
        fclose(wry_file);
    }
    return EXIT_SUCCESS;
}
