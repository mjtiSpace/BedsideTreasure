//
//  AboutViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>
@property(nonatomic , retain)NSArray *dataSourceArr ;

@end
