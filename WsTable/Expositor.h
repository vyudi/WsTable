//
//  Expositor.h
//  WsTable
//
//  Created by Vitor Yudi Hansen on 07/08/13.
//  Copyright (c) 2013 Vitor Yudi Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expositor : NSObject

@property(nonatomic, strong) NSString *website;
@property(nonatomic, strong) NSString *nome;

- (Expositor *) initWithName:(NSString *)n website:(NSString *)w;

@end
