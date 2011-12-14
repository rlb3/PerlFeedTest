//
//  main.m
//  PerlFeedTest
//
//  Created by Robert Boone on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PubSub/PubSub.h>

int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    NSURL *url = [NSURL URLWithString:@"http://search.cpan.org/uploads.rdf"];
    
    NSURLRequest  *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    NSData  *perlRssData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
    PSFeed *feed = [[PSFeed alloc] initWithData:perlRssData URL:url];

    // [feed refresh:&error];

    // Go through each entry and print out the title, authors, and content
    for (PSEntry *entry in [feed entries]) {
        
        printf("Entry Title:%s\n", [entry.titleForDisplay UTF8String]);
        printf("Entry Authors:%s\n", [entry.authorsForDisplay UTF8String]);
        printf("Entry Content:%s\n\n", [entry.content.plainTextString UTF8String]);
    }
    
    [feed release];
    [pool drain];
    return 0;
}
