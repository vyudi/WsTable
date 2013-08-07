//
//  Expositor.m
//  WsTable
//
//  Created by Vitor Yudi Hansen on 07/08/13.
//  Copyright (c) 2013 Vitor Yudi Hansen. All rights reserved.
//

#import "Expositor.h"

@implementation Expositor

@synthesize nome,website;

- (Expositor *) initWithName:(NSString *)n website:(NSString *)w{
    if(![self init]){
        return nil;
    }
    
    self.nome = n;
    self.website = w;
    return self;
    
}

@end
