//
//  ViewController.h
//  WsTable
//
//  Created by Vitor Yudi Hansen on 07/08/13.
//  Copyright (c) 2013 Vitor Yudi Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expositor.h"

@interface ViewController : UIViewController{
    NSDictionary *jsonDict;
    NSURL *urlJson;
}

@property (nonatomic, retain) NSMutableArray *lista;
@property (strong, nonatomic) NSString *urlJs;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@end
