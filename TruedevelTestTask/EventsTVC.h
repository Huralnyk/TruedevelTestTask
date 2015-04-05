//
//  EventsTVC.h
//  TruedevelTestTask
//
//  Created by Alexey Huralnyk on 4/5/15.
//  Copyright (c) 2015 Alexey Huralnyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTVC : UITableViewController

@property (nonatomic, strong) NSMutableArray *events; // of GitHubEvent NSDictionary

@end
