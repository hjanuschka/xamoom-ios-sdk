#import <CommonCrypto/CommonDigest.h>
#import "XMMCoreDataGetByLocationIdentifier.h"
#import "XMMCoreDataContent.h"
#import "XMMCoreDataMenuItem.h"
#import "XMMCoreDataStyle.h"
#import "XMMCoreDataContentBlocks.h"

@interface XMMCoreDataGetByLocationIdentifier ()

// Private interface goes here.

@end

@implementation XMMCoreDataGetByLocationIdentifier

+ (NSDictionary *)getMapping
{
    return @{@"system_name":@"systemName",
             @"system_url":@"systemUrl",
             @"system_id":@"systemId",
             @"has_content":@"hasContent",
             @"has_spot":@"hasSpot",
             };
}

-(void)willSave {
    self.objectAsHash = [[NSMutableString alloc] init];
    
    [self.objectAsHash appendString:[self hashableDescription]];
    
    NSArray *menu = [self sortedMenuItem];
    for(XMMCoreDataMenuItem *item in menu) {
        [self.objectAsHash appendString:[item hashableDescription]];
    }
    
    [self.objectAsHash appendString:[self.style hashableDescription]];
    [self.objectAsHash appendString:[self.content hashableDescription]];
    
    NSArray *contentBlocks = self.content.sortedContentBlocks;
    for (XMMCoreDataContentBlocks *block in contentBlocks) {
        [self.objectAsHash appendString:[block hashableDescription]];
    }
    
    NSLog(@"HERE: %@", [self sha1:self.objectAsHash]);
    
    [self setPrimitiveValue:[self sha1:self.objectAsHash] forKey:@"checksum"];
}

- (NSString *)hashableDescription {
    NSString *stringA = self.systemId;
    NSString *stringB = self.systemName;
    NSString *stringC = self.systemUrl;
    NSString *stringD = self.hasContent;
    NSString *stringE = self.hasSpot;
    
    NSString *description = [NSString stringWithFormat:@"%@,%@,%@,%@,%@", stringA, stringB, stringC, stringD, stringE];
    return description;
}


- (NSString *)sha1:(NSString *)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

-(NSArray *)sortedMenuItem {
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES];
    NSArray *sorting = [NSArray arrayWithObject:descriptor];
    
    return [self.menu sortedArrayUsingDescriptors:sorting];
}

@end